import 'package:flutter/widgets.dart';

import 'rendering/sliver_pinned_header.dart';

/// [SliverPinnedHeader] keeps its child pinned to the leading edge of the viewport.
class SliverPinnedHeader extends SingleChildRenderObjectWidget {
  const SliverPinnedHeader({
    Key? key,
    required Widget child,
    this.getScrollableSize,
  }) : super(key: key, child: child);

  final double Function(double childSize)? getScrollableSize;

  @override
  RenderSliverPinnedHeader createRenderObject(BuildContext context) {
    return RenderSliverPinnedHeader(getScrollableSize: getScrollableSize);
  }
}
