import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'status_provider.g.dart';

/// Something that is over and that the status bar tells the user about.
sealed class StatusMessage {
  const StatusMessage();
}

/// The data that was asked for has arrived.
class DataLoaded extends StatusMessage {
  const DataLoaded();
}

/// Data could not be loaded because of [error].
class LoadFailed extends StatusMessage {
  const LoadFailed(this.error);

  final Object error;
}

/// A change was saved.
class Saved extends StatusMessage {
  const Saved();
}

/// A record was deleted.
class Deleted extends StatusMessage {
  const Deleted();
}

/// The server made a document, which was opened as the file [name].
class DocumentCreated extends StatusMessage {
  const DocumentCreated(this.name);

  final String name;
}

/// Something else has worked. [text] says what, in the language of the app.
class Done extends StatusMessage {
  const Done(this.text);

  final String text;
}

/// What the status bar shows.
class StatusState {
  const StatusState({this.loading = false, this.message});

  /// Whether data is being loaded.
  final bool loading;

  /// What happened last, or null once that is no longer news.
  final StatusMessage? message;
}

/// What the status bar shows. Loading is reported by [StatusObserver]; what
/// the user did is reported where it is done, once it has worked.
@Riverpod(keepAlive: true)
class Status extends _$Status {
  /// How long the status bar says that something the user did has worked.
  static const doneDuration = Duration(seconds: 5);

  /// How long it says that data was loaded, which happens all the time.
  static const loadedDuration = Duration(seconds: 3);

  /// How long loading shows at least. Most data is there at once, and the
  /// animation would only flicker.
  static const minLoadingDuration = Duration(milliseconds: 200);

  Timer? _expiry;

  /// Runs while loading has to show on, and what [loadFinished] was told
  /// meanwhile.
  Timer? _minLoading;
  bool? _finishedFailed;

  @override
  StatusState build() {
    ref.onDispose(() {
      _expiry?.cancel();
      _minLoading?.cancel();
    });
    return const StatusState();
  }

  void saved() => _show(const Saved(), doneDuration);

  void deleted() => _show(const Deleted(), doneDuration);

  void documentCreated(String name) =>
      _show(DocumentCreated(name), doneDuration);

  void done(String text) => _show(Done(text), doneDuration);

  /// Data starts to load, so what was said about the data loaded before is
  /// out of date.
  void loadStarted() {
    // Loading goes on, or starts to show for its shortest time.
    _finishedFailed = null;
    if (!state.loading) {
      _minLoading = Timer(minLoadingDuration, () {
        _minLoading = null;
        if (_finishedFailed case final failed?) loadFinished(failed: failed);
      });
    }
    final message = state.message;
    if (message is DataLoaded || message is LoadFailed) {
      _expiry?.cancel();
      state = const StatusState(loading: true);
    } else {
      state = StatusState(loading: true, message: message);
    }
  }

  /// Loading failed with [error]. This is said until data is loaded anew,
  /// so that it is not missed.
  void loadFailed(Object error) => _show(LoadFailed(error), null);

  /// Nothing is loading anymore. Unless some of the data [failed] to load,
  /// this is said, but not in place of what the user did a moment ago.
  void loadFinished({required bool failed}) {
    if (_minLoading != null) {
      _finishedFailed = failed;
      return;
    }
    _finishedFailed = null;
    final message = state.message;
    state = StatusState(message: message);
    if (!failed && (message == null || message is LoadFailed)) {
      _show(const DataLoaded(), loadedDuration);
    }
  }

  void _show(StatusMessage message, Duration? duration) {
    _expiry?.cancel();
    _expiry = duration == null
        ? null
        : Timer(duration, () => state = StatusState(loading: state.loading));
    state = StatusState(loading: state.loading, message: message);
  }
}

/// Tells the status bar when providers load data and how that ends. It has
/// to be given to the provider container of the app.
final class StatusObserver extends ProviderObserver {
  /// The providers that are loading, and those of them that failed in this
  /// round of loading.
  final _loading = <Object>{};
  final _failing = <Object>{};

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) =>
      _track(context, null, value);

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) => _track(context, previousValue, newValue);

  @override
  void didUnmountProvider(ProviderObserverContext context) {
    _failing.remove(context.provider);
    if (_loading.remove(context.provider)) _finishIfDone(context);
  }

  void _track(
    ProviderObserverContext context,
    Object? previous,
    Object? value,
  ) {
    if (value is! AsyncValue<Object?>) return;
    final provider = context.provider;

    if (value.isLoading && _loading.isEmpty) {
      _failing.clear();
      _tell(context, (status) => status.loadStarted());
    }

    // A provider that is tried again keeps its error, which is told once.
    final error = _failure(value);
    if (error != null && !identical(error, _failure(previous))) {
      _failing.add(provider);
      _tell(context, (status) => status.loadFailed(error));
    } else if (value is AsyncData) {
      _failing.remove(provider);
    }

    if (value.isLoading) {
      _loading.add(provider);
    } else if (_loading.remove(provider)) {
      _finishIfDone(context);
    }
  }

  void _finishIfDone(ProviderObserverContext context) {
    if (_loading.isNotEmpty) return;
    final failed = _failing.isNotEmpty;
    _tell(context, (status) => status.loadFinished(failed: failed));
  }

  /// The error [value] failed with, also while it is tried again.
  static Object? _failure(Object? value) {
    if (value is! AsyncValue<Object?>) return null;
    return value is AsyncError || value.retrying ? value.error : null;
  }

  /// Hands [report] to the status bar a moment later. Providers must not
  /// change one another while they are built, which is when this is called.
  void _tell(ProviderObserverContext context, void Function(Status) report) {
    final container = context.container;
    scheduleMicrotask(() {
      try {
        report(container.read(statusProvider.notifier));
      } on StateError {
        // The app was closed meanwhile.
      }
    });
  }
}
