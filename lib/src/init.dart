import 'dart:async';
import 'dart:math';

import 'package:animation_transition/animation_transition.dart';
import 'package:flutter/material.dart';

import 'model/func.dart';
import 'model/controll.dart';
import 'model/model.dart';

class HoverFloatAnimation extends StatefulWidget {
  HoverAnimationData hoverData;
  HoverFloatAnimation({super.key, required this.hoverData});

  @override
  State<HoverFloatAnimation> createState() => _HoverFloatAnimationState();
}

class _HoverFloatAnimationState extends State<HoverFloatAnimation>
    with WidgetsBindingObserver {
  final ControllHover controller = ControllHover(
    hoverFloat: false,
    hoverChild: false,
    link: LayerLink(),
    overlay: OverlayPortalController(),
  );
  FuncPosition controllerPositition = FuncPosition();
  int tken = 0;
  final GlobalKey gKey = GlobalKey();
  final GlobalKey floatKey = GlobalKey();

  bool changePosition = false;
  late Offset position;
  late Size sizeParent;
  Size floatSize = Size.zero;

  late Offset showPosition;

  int token() {
    Random random = Random();
    int max = 9999999;
    int min = 1000000;
    int token = min + random.nextInt((max + 1) - 1);
    return token;
  }

  hover({bool float = false, bool parent = false}) {
    print('hover');
    if (parent) {
      controller.hoverChild = true;
    } else {
      controller.hoverFloat = float;
    }
  }

  bool status({bool hoverFloat = false, bool hoverChild = false}) {
    if (hoverFloat) {
      return controller.hoverFloat;
    } else if (hoverChild) {
      return controller.hoverChild;
    }
    return false;
  }

  Timer? getTimeOut({
    bool cancel = false,
  }) {
    if (cancel) {
      controller.timeOut!.cancel();
      controller.timeOut = null;
    }
    return controller.timeOut;
  }

  setTimeOut({
    required Timer func,
  }) {
    return controller.timeOut = func;
  }

  show() {
    if (controller.hoverFloat) {
      return;
    }
    controller.overlay.show();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(const Duration(milliseconds: 200), () {
          try {
            if (changePosition && floatSize != Size.zero) {
              setState(() {
                changeSizeAndPosition();
                changePosition = false;
              });
              return;
            }
            RenderBox? rnder =
                floatKey.currentContext?.findRenderObject()! as RenderBox;
            if (floatSize == rnder.size) return;
            floatSize = rnder.size;
            setState(() {
              changeSizeAndPosition();
            });
          } catch (e) {
            print(e);
          }
        });
      },
    );
    controller.hoverFloat = true;
  }

  hide() async {
    transitionAnimation.reverse(token: tken).then(
      (value) {
        controller.overlay.hide();
        controller.hoverFloat = false;
      },
    );
  }

  changeSizeAndPosition() {
    showPosition = controllerPositition.getPosition(
      parentPosition: position,
      parentSize: sizeParent,
      horizontal: widget.hoverData.positionHorizontal,
      vertical: widget.hoverData.positionVertical,
      size: floatSize,
      relativePosition: widget.hoverData.relativePosition,
      context: context,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.hoverData.onStart != nullFunc) {
      widget.hoverData.onStart();
    }
    tken = token();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        showPosition = controller.link.leader!.offset;
        positionSize();
      },
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    controller.timeOut?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void positionSize() {
    if (!changePosition) {
      changePosition = true;
    }
    RenderBox render = gKey.currentContext!.findRenderObject()! as RenderBox;
    position = render.localToGlobal(Offset.zero);
    sizeParent = render.size;
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    positionSize();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      key: gKey,
      cursor: SystemMouseCursors.alias,
      onExit: (_) {
        hover(
          parent: false,
        );
        if (getTimeOut() != null) {
          getTimeOut(cancel: true);
        }
        setTimeOut(
          func: Timer(
            const Duration(milliseconds: 300),
            () async {
              if (!status(hoverFloat: true) ||
                  (status(hoverFloat: false) && status(hoverChild: false))) {
                await hide();
              }
            },
          ),
        );
      },
      onHover: (_) async {
        if (status()) {
          return;
        }
        hover(
          parent: true,
        );
        show();
      },
      onEnter: (_) {
        if (getTimeOut() != null) {
          getTimeOut(cancel: true);
        }
        if (status()) {
          return;
        }
        hover(
          parent: true,
        );
        show();
      },
      child: Column(
        children: [
          CompositedTransformTarget(
            link: controller.link,
            child: OverlayPortal(
              controller: controller.overlay,
              child: widget.hoverData.child,
              overlayChildBuilder: (context) {
                return Material(
                  type: MaterialType.transparency,
                  child: Stack(
                    children: [
                      CompositedTransformFollower(
                        link: controller.link,
                        offset: showPosition,
                        child: MouseRegion(
                          onEnter: (_) {
                            hover(
                              float: true,
                            );
                            widget.hoverData.onEnterMouse();
                          },
                          onHover: (_) {
                            hover(
                              float: true,
                            );
                          },
                          onExit: (_) {
                            hover(
                              float: false,
                            );
                            if (getTimeOut() != null) {
                              getTimeOut(cancel: true);
                            }
                            setTimeOut(
                              func: Timer(
                                const Duration(milliseconds: 300),
                                () async {
                                  widget.hoverData.onExitMouse();
                                  if (status(hoverChild: true)) {
                                    await hide();
                                  }
                                },
                              ),
                            );
                          },
                          child: SizedBox(
                            key: floatKey,
                            width: widget.hoverData.sizeFloat.width,
                            child: IntrinsicHeight(
                              child: widget.hoverData.animation
                                  ? transitionAnimation.start(
                                      data: AnimationData(
                                        token: tken,
                                        duration:
                                            widget.hoverData.animationDuration,
                                        transition: widget.hoverData.transition,
                                        child: widget.hoverData.hoverChild,
                                      ),
                                    )
                                  : widget.hoverData.hoverChild,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
