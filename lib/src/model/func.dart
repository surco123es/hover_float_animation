import 'package:flutter/material.dart';

import '../../hover_float_animation.dart';

class FuncPosition {
  Size screenSize = Size.zero;
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
    required BuildContext context,
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
}
