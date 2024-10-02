import 'dart:async';
import 'dart:math';

import 'package:animation_transition/dialogModel.dart';
import 'package:flutter/widgets.dart';
import 'package:hover_float_animation/src/hover.dart';

import 'model/controll.dart';
import 'model/model.dart';

class HoverFloatAnimation {
  final Map<int, ControllHover> _controll = {};
  OverlayState? _hoverState = null;
  int token() {
    Random random = Random();
    int max = 9999999;
    int min = 1000000;
    int token = min + random.nextInt((max + 1) - 1);
    return token;
  }

  addHover({
    required int token,
    required ControllHover hover,
  }) {
    if (!_controll.containsKey(token)) {
      _controll.addAll({token: hover});
    }
  }

  hover({required int token, required bool hover, required bool child}) {
    if (_controll.containsKey(token)) {
      if (child) {
        _controll[token]!.hoverChild = hover;
      } else {
        _controll[token]!.hoverFloat = hover;
      }
    }
  }

  bool status(
      {required int token, bool hoverFloat = false, bool hoverChild = false}) {
    if (_controll.containsKey(token)) {
      if (hoverFloat) {
        return _controll[token]!.hoverFloat;
      } else if (hoverChild) {
        return _controll[token]!.hoverChild;
      } else {
        return _controll[token]!.hover == null ? false : true;
      }
    } else {
      return false;
    }
  }

  Widget start({required HoverAnimationData hover}) {
    if (hover.token == 0) {
      hover.token = token();
    }
    if (hover.onStart != nullFunc) {
      hover.onStart(hover.token);
    }
    return FloatHoverTransioncion(data: hover);
  }

  Timer? getTimeOut({
    required int token,
    bool cancel = false,
  }) {
    if (_controll.containsKey(token)) {
      if (cancel) {
        _controll[token]!.timeOut!.cancel();
        _controll[token]!.timeOut = null;
      }
      return _controll[token]?.timeOut;
    }
    return null;
  }

  setTimeOut({
    required int token,
    required Timer func,
  }) {
    if (_controll.containsKey(token)) {
      return _controll[token]?.timeOut = func;
    }
  }

  LayerLink? getLink({
    required int token,
  }) {
    if (_controll.containsKey(token)) {
      return _controll[token]?.link;
    }
    return null;
  }

  show({
    required int token,
    required BuildContext context,
    required OverlayEntry hover,
  }) {
    _hoverState ??= Overlay.of(context);
    if (_controll.containsKey(token)) {
      _controll[token]!.hover = hover;
      _hoverState!.insert(_controll[token]!.hover!);
    }
  }

  hide({required int token}) async {
    if (_controll.containsKey(token) && _controll[token]!.hover != null) {
      if (!_controll[token]!.hoverChild && !_controll[token]!.hoverFloat) {
        await transitionAnimation.reversePlay(
          token: token,
        );
        _controll[token]!.hover!.remove();
        _controll[token]!.hover = null;
      }
    }
  }

  dispose({required int token}) {
    if (_controll.containsKey(token)) {
      if (!_controll[token]!.hoverChild && !_controll[token]!.hoverFloat) {
        if (_controll[token]!.hover != null) {
          _controll[token]!.hover!.remove();
        }
        _controll.remove(token);
      }
    }
  }
}

HoverFloatAnimation HoverFloatController = HoverFloatAnimation();
