import 'package:flutter/widgets.dart';
import 'package:yaru/yaru.dart';

/// The gap between the edges of a panel and what it shows, the same as
/// around the cards of the dashboard.
const panelGap = kYaruPagePadding;

/// Around the row of controls at the top of a panel.
const panelBarPadding = EdgeInsets.fromLTRB(panelGap, panelGap, panelGap, 16);

/// Around a row of controls below the top of a panel, such as the toolbar
/// of a section.
const panelToolbarPadding = EdgeInsets.fromLTRB(panelGap, 16, panelGap, 16);

/// Around what a panel shows below its controls.
const panelContentPadding = EdgeInsets.fromLTRB(
  panelGap,
  0,
  panelGap,
  panelGap,
);

/// Around a list of tiles, or a table, below the controls of a panel. Tiles
/// and cells have a gap of 12 of their own, so that what they show lines up
/// with the controls above.
const panelListPadding = EdgeInsets.fromLTRB(
  panelGap - 12,
  0,
  panelGap - 12,
  panelGap,
);
