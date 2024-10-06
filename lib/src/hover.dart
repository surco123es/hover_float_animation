import 'dart:async';

import 'package:animation_transition/animation_transition.dart';
import 'package:flutter/material.dart';
import 'package:hover_float_animation/src/model/controll.dart';

import '../hover_float_animation.dart';

class FloatHoverTransioncion extends StatefulWidget {
  HoverAnimationData data;
  FloatHoverTransioncion({super.key, required this.data});

  @override
  State<FloatHoverTransioncion> createState() => _FloatHoverTransioncionState();
}

class _FloatHoverTransioncionState extends State<FloatHoverTransioncion> {
  late GlobalKey gKey = GlobalKey();
  late Offset position;
  late Size size;
  bool calEnter = false;
  bool hover = false;
  @override
  void initState() {
    HoverFloatController.addHover(
      token: widget.data.token,
      hover: ControllHover(
        link: LayerLink(),
        hoverChild: false,
        hoverFloat: false,
      ),
    );
    widget.data.onStart(widget.data.token);
    super.initState();
  }

  void positionSize() {
    RenderBox render = gKey.currentContext!.findRenderObject()! as RenderBox;
    position = render.localToGlobal(Offset.zero);
    size = render.size;
  }

  void initShow() {
    positionSize();
    HoverFloatController.show(
      token: widget.data.token,
      context: context,
      hover: OverlayEntry(
        builder: (context) {
          return HoverFloatPosition(
            animation: widget.data.animation,
            potisionHorizontal: widget.data.positionHorizontal,
            potisionVertical: widget.data.positionVertical,
            token: widget.data.token,
            durationAnimation: widget.data.animationDuration,
            transition: widget.data.transition,
            onExit: widget.data.onExitMouse,
            onEnter: widget.data.onEnterMouse,
            parentPosition: position,
            parentSize: size,
            relativePosition: widget.data.relativePosition,
            floatSize: widget.data.sizeFloat,
            child: widget.data.hoverChild,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    HoverFloatController.dispose(token: widget.data.token);

    if (HoverFloatController.getTimeOut(token: widget.data.token) != null) {
      HoverFloatController.getTimeOut(token: widget.data.token, cancel: true)!
          .cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return MouseRegion(
        key: gKey,
        cursor: SystemMouseCursors.alias,
        onExit: (_) {
          HoverFloatController.hover(
            token: widget.data.token,
            hover: false,
            child: true,
          );
          if (HoverFloatController.getTimeOut(token: widget.data.token) !=
              null) {
            HoverFloatController.getTimeOut(
                token: widget.data.token, cancel: true);
          }
          HoverFloatController.setTimeOut(
            token: widget.data.token,
            func: Timer(
              const Duration(milliseconds: 300),
              () async {
                if (!HoverFloatController.status(
                    token: widget.data.token, hoverFloat: true)) {
                  await HoverFloatController.hide(token: widget.data.token);
                }
              },
            ),
          );
        },
        onHover: (_) async {
          if (HoverFloatController.status(token: widget.data.token)) {
            return;
          }
          HoverFloatController.hover(
            token: widget.data.token,
            hover: true,
            child: true,
          );
          initShow();
        },
        onEnter: (_) {
          if (HoverFloatController.getTimeOut(token: widget.data.token) !=
              null) {
            HoverFloatController.getTimeOut(
                token: widget.data.token, cancel: true);
          }
          if (HoverFloatController.status(token: widget.data.token)) {
            return;
          }
          HoverFloatController.hover(
            token: widget.data.token,
            hover: true,
            child: true,
          );
          initShow();
        },
        child: CompositedTransformTarget(
          link: HoverFloatController.getLink(token: widget.data.token)!,
          child: widget.data.child,
        ),
      );
    } catch (e) {
      return const SizedBox();
    }
  }
}

class HoverFloatPosition extends StatefulWidget {
  Widget child;
  Offset parentPosition;
  Size parentSize, floatSize;
  HoverPositionVertical potisionVertical;
  HoverPositionHorizontal potisionHorizontal;
  Duration durationAnimation;
  TransitionType transition;
  bool animation, relativePosition;
  int token;
  HoverToken onExit, onEnter;
  HoverFloatPosition({
    super.key,
    required this.child,
    required this.potisionHorizontal,
    required this.potisionVertical,
    required this.animation,
    required this.token,
    required this.transition,
    required this.durationAnimation,
    required this.onExit,
    required this.onEnter,
    required this.parentPosition,
    required this.parentSize,
    required this.relativePosition,
    required this.floatSize,
  });
  @override
  State<HoverFloatPosition> createState() => _HoverFloatPositionState();
}

class _HoverFloatPositionState extends State<HoverFloatPosition> {
  late Offset mainPosition;
  Size screenSize = Size.zero;
  @override
  void initState() {
    super.initState();
  }

  double getLeft({
    required Offset parentPosition,
    required Size parentSize,
    required Size size,
    required HoverPositionHorizontal horizontal,
    required bool relativePosition,
  }) {
    double left = 0;
    double contentLeft = 0;
    if (horizontal == HoverPositionHorizontal.center) {
      if (size.width > parentSize.width) {
        left = -(size.width - parentSize.width) / 2;
        contentLeft = parentPosition.dx - ((size.width - parentSize.width) / 2);
      } else {
        left = -(parentSize.width - size.width) / 2;
        contentLeft = parentPosition.dx - ((parentSize.width - size.width) / 2);
      }
      if (relativePosition && contentLeft < 0) {
        left = 0;
      } else if (relativePosition &&
          contentLeft + size.width > screenSize.width) {
        left = screenSize.width - size.width;
      }
    } else if (horizontal == HoverPositionHorizontal.left) {
      left = parentSize.width;
      contentLeft = parentPosition.dx + (parentSize.width + size.width);
      if (contentLeft > screenSize.width) {
        left = -size.width;
      }
    } else if (horizontal == HoverPositionHorizontal.right) {
      left = -size.width;
      contentLeft = parentPosition.dx - size.width;
      if (contentLeft < 0) {
        left = parentSize.width;
      }
    }
    return left;
  }

  double getTop({
    required Offset parentPosition,
    required Size parentSize,
    required Size size,
    required HoverPositionVertical vertical,
    required bool relativePosition,
  }) {
    double top = 0;
    double contentTop = 0;
    if (vertical == HoverPositionVertical.center) {
      if (size.height > parentSize.height) {
        top = -(size.height - parentSize.height) / 2;
        contentTop =
            parentPosition.dy - ((size.height - parentSize.height) / 2);
      } else {
        top = (parentSize.height - size.height) / 2;
        contentTop =
            parentPosition.dy - ((parentSize.height - size.height) / 2);
      }
      if (relativePosition && contentTop < 0) {
        top = 0;
      } else if (relativePosition &&
          contentTop + size.height > screenSize.height) {
        top = (size.height > parentSize.height)
            ? -(size.height - parentSize.height)
            : (parentSize.height - size.height);
      }
    } else if (vertical == HoverPositionVertical.top) {
      top = -size.height;
      contentTop = parentPosition.dy - size.height;
      if (contentTop < 0) {
        top = parentSize.height;
      }
    } else if (vertical == HoverPositionVertical.bottom) {
      top = parentSize.height;
      contentTop = parentPosition.dy + size.height + parentSize.height;
      if (top > screenSize.height) {
        top = parentPosition.dy - size.height;
      }
    }
    return top;
  }

  Offset getPosition({
    required Offset parentPosition,
    required Size parentSize,
    required Size size,
    required HoverPositionHorizontal horizontal,
    required HoverPositionVertical vertical,
    required bool relativePosition,
  }) {
    double top = 0;
    double left = 0;
    late Offset positionNew;
    screenSize = MediaQuery.of(context).size;
    left = getLeft(
        parentPosition: parentPosition,
        parentSize: parentSize,
        size: size,
        horizontal: horizontal,
        relativePosition: relativePosition);
    top = getTop(
        parentPosition: parentPosition,
        parentSize: parentSize,
        size: size,
        vertical: vertical,
        relativePosition: relativePosition);
    positionNew = Offset(left, top);
    return positionNew;
  }

  @override
  Widget build(Object context) {
    mainPosition = getPosition(
      parentPosition: widget.parentPosition,
      parentSize: widget.parentSize,
      horizontal: widget.potisionHorizontal,
      vertical: widget.potisionVertical,
      size: widget.floatSize,
      relativePosition: widget.relativePosition,
    );
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          CompositedTransformFollower(
            link: HoverFloatController.getLink(token: widget.token)!,
            offset: mainPosition,
            child: MouseRegion(
              onEnter: (_) {
                widget.onEnter(widget.token);
              },
              onHover: (_) {
                HoverFloatController.hover(
                  token: widget.token,
                  hover: true,
                  child: false,
                );
              },
              onExit: (_) {
                HoverFloatController.hover(
                  token: widget.token,
                  hover: false,
                  child: false,
                );
                if (HoverFloatController.getTimeOut(token: widget.token) !=
                    null) {
                  HoverFloatController.getTimeOut(
                      token: widget.token, cancel: true);
                }
                HoverFloatController.setTimeOut(
                  token: widget.token,
                  func: Timer(
                    const Duration(milliseconds: 300),
                    () async {
                      widget.onExit(widget.token);
                      if (!HoverFloatController.status(
                          token: widget.token, hoverChild: true)) {
                        await HoverFloatController.hide(token: widget.token);
                      }
                    },
                  ),
                );
              },
              child: SizedBox(
                height: widget.floatSize.height,
                width: widget.floatSize.width,
                child: widget.animation
                    ? transitionAnimation.start(
                        data: AnimationData(
                          duration: widget.durationAnimation,
                          transition: widget.transition,
                          child: widget.child,
                          token: widget.token,
                        ),
                      )
                    : widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
