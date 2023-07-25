import 'package:flutter/material.dart';

// 防止重复点击
class HYInkWell extends StatelessWidget {

  final Widget? child;
  final Color? highlightColor;
  final Function()? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onDoubleTap;
  /// 防止重复点击时间间隔，单位：秒
  final int repeatInterval;

  DateTime? _lastPressedAdt;

  HYInkWell({Key? key, this.onTap, this.child, this.highlightColor, this.onLongPress, this.onDoubleTap, this.repeatInterval = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap == null ? onTap : (){
        _oneClick();
      },
      highlightColor: highlightColor,
      child: child,
      onDoubleTap: onDoubleTap,
    );
  }

  void _oneClick(){

    if (repeatInterval == 0){
      onTap?.call();
      return;
    }
    if(_lastPressedAdt == null || DateTime.now().difference(_lastPressedAdt!)> Duration(seconds: repeatInterval)){
      //两次点击时间间隔超过1秒则重新计时
      _lastPressedAdt = DateTime.now();
      onTap?.call();
    }
  }
}

class HYGestureDetector extends StatelessWidget {

  final Widget? child;
  final Color? highlightColor;
  final Function()? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onDoubleTap;
  /// 防止重复点击时间间隔，单位：秒
  final int repeatInterval;

  DateTime? _lastPressedAdt;

  HYGestureDetector({Key? key, this.highlightColor, this.onTap, this.onLongPress, this.child, this.onDoubleTap, this.repeatInterval = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap == null ? onTap : (){
        _oneClick();
      },
      child: child,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
    );
  }

  void _oneClick(){
    if (repeatInterval == 0){
      onTap?.call();
      return;
    }
    if(_lastPressedAdt == null || DateTime.now().difference(_lastPressedAdt!)> Duration(seconds: repeatInterval)){
      //两次点击时间间隔超过1秒则重新计时
      _lastPressedAdt = DateTime.now();
      onTap?.call();
    }
  }
}

