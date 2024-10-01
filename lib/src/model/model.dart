import 'package:animation_transition/animation_transition.dart';
import 'package:flutter/widgets.dart';
import 'package:hover_float_animation/src/model/type.dart';

nullFunc(int tk) {}

class HoverAnimationData {
  Widget child;
  Widget hoverChild;
  Size sizeFloat;
  bool animation, autoClose, relativePosition;
  int token;
  TransitionType transition;
  HoverToken onStart, onEnterMouse, onExitMouse;
  HoverPositionVertical positionVertical;
  HoverPositionHorizontal positionHorizontal;
  Duration animationDuration;

  HoverAnimationData({
    required this.child,
    required this.hoverChild,
    required this.sizeFloat,
    this.token = 0,
    this.animation = true,
    this.autoClose = true,
    this.relativePosition = true,
    this.transition = TransitionType.FadeIn,
    this.positionVertical = HoverPositionVertical.center,
    this.positionHorizontal = HoverPositionHorizontal.center,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.onStart = nullFunc,
    this.onEnterMouse = nullFunc,
    this.onExitMouse = nullFunc,
  });
}
