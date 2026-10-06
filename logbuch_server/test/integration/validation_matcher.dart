import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:test/test.dart';

/// Matches a call that fails with a [ValidationException] for [reason].
Matcher throwsValidation(ValidationError reason, {String? detail}) {
  var exception = isA<ValidationException>().having(
    (e) => e.reason,
    'reason',
    reason,
  );
  if (detail != null) {
    exception = exception.having((e) => e.detail, 'detail', detail);
  }
  return throwsA(exception);
}
