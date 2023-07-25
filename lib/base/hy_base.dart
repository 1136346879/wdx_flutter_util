import 'package:flutter/material.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_base
/// desc、

typedef HYWidgetBuilder = Widget Function(BuildContext context, dynamic model);

/// 空页面类型
enum EmptyViewType{
  ERROR,
  EMPTY,
  CUSTOM,
}

/// baseList页面属性
enum HYBaseListPageType{
  LIST,
  GRID,
  CUSTOM,
}

/// 刷新页面
mixin HYStateUpdaterMixin<T extends StatefulWidget> on State<T> {

  void getUpdate() {
    if (mounted) setState(() {});
  }
}

class HYColorTabIndicator extends Decoration {

  const HYColorTabIndicator(this.color);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final Color color;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    return super.lerpTo(b, t);
  }

  @override
  _ColorPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ColorPainter(this, onChanged);
  }
}

class _ColorPainter extends BoxPainter {
  _ColorPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final HYColorTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Rect rect1 = Rect.fromLTRB(rect.left, rect.top+5, rect.right, rect.bottom-5);
    // rect.top - 5;
    // rect.bottom - 5;
    final Paint paint = Paint();
    paint.color = decoration.color;
    canvas.drawRRect(RRect.fromRectAndRadius(rect1, Radius.circular(30)), paint);
    // canvas.drawRect(rect, paint);
  }
}