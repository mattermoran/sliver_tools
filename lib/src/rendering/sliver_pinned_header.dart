import 'dart:math';

import 'package:flutter/rendering.dart';

class RenderSliverPinnedHeader extends RenderSliverSingleBoxAdapter {
  final double Function(double childSize)? getScrollableSize;

  RenderSliverPinnedHeader({this.getScrollableSize});

  @override
  void performLayout() {
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }
    final paintedChildExtent = min(
      childExtent,
      constraints.remainingPaintExtent - constraints.overlap,
    );

    final scrollableSize = getScrollableSize?.call(childExtent) ?? 0;
    final paintOrigin = constraints.overlap -
        (constraints.scrollOffset + constraints.overlap)
            .clamp(0, scrollableSize);

    geometry = SliverGeometry(
      paintExtent: paintedChildExtent,
      maxPaintExtent: childExtent,
      maxScrollObstructionExtent: childExtent,
      paintOrigin: paintOrigin,
      scrollExtent: childExtent,
      layoutExtent: max(0.0, paintedChildExtent - constraints.scrollOffset),
      hasVisualOverflow: paintedChildExtent < childExtent,
    );
  }

  @override
  double childMainAxisPosition(RenderBox child) {
    return 0;
  }
}
