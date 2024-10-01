import 'dart:async';

import 'package:flutter/widgets.dart';

class ControllHover {
  OverlayEntry? hover;
  bool hoverFloat, hoverChild;
  LayerLink link;
  Timer? timeOut;
  ControllHover({
    this.hover,
    this.timeOut,
    required this.hoverFloat,
    required this.hoverChild,
    required this.link,
  });
}
