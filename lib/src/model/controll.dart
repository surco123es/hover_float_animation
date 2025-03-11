import 'dart:async';

import 'package:flutter/widgets.dart';

class ControllHover {
  bool hoverFloat, hoverChild;
  LayerLink link;
  Timer? timeOut;
  OverlayPortalController overlay;
  ControllHover({
    this.timeOut,
    required this.hoverFloat,
    required this.hoverChild,
    required this.link,
    required this.overlay,
  });
}
