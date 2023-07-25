
import 'package:flutter/material.dart';

import '../hy_flutter_utils.dart';


class HYPopFilterView extends StatefulWidget {
  Widget? child;
  double? height;
  Color? color;
  VoidCallback? voidCallback;

  HYPopFilterView(
      {required this.child, this.height = 300.0, this.color = Colors.white,this.voidCallback});

  @override
  State<StatefulWidget> createState() {
    return _HYPopFilterViewState();
  }
}

class _HYPopFilterViewState extends State<HYPopFilterView>
    with SingleTickerProviderStateMixin {
  Animation? _animation;
  AnimationController? animationController;

  AnimationController? _animationController() {
    if (animationController != null) {
      return animationController;
    }
    AnimationController controller =
    AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _animation = Tween(begin: 0.0, end: widget.height).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    animationController = controller;
    return animationController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animation?.removeListener(() {});
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController();
    return Container(
      width: Get.width,
      color: widget.color,
      height: _animation?.value,
      child: widget.child,
    );
  }
}