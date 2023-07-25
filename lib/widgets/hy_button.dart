import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../define/hy_config.dart';
import 'hy_container.dart';


/// Created by wdx
/// on 2022/07/06
/// page xfs_button
/// desc 按钮，包括纯文本，文本加图片,有对应的初始化命名方法

enum HYTextButtonIconTextDirection {
  /// 文本在左，图片早右
  textLIconR,
  /// 文本在右，图片早左
  textRIconL,
  /// 文本在上，图片早下
  textTIconB,
  /// 文本在下，图片早上
  textBIconT,
}

class HYTextButton extends StatelessWidget {

  /// 构建纯文本按钮
  HYTextButton.text({
    Key? key,
    this.onPressed,
    this.onLongPress,
    @required this.title,
    this.fontSize,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.pressedTextColor,
    this.backgroundColor=Colors.transparent,
    this.pressedBackgroundColor,
    this.borderColor=Config.color333333,
    this.borderWidth=1,
    this.borderStyle=BorderStyle.none,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.overlayColor,
    this.borderRadius,
    this.enableFeedback,
    this.animationDuration,
    this.repeatInterval=1,
    this.width,
    this.height,
    this.enable=true,
    this.unenbleTextColor,
    this.unenbleBackgroundColor,
  }) : this.icon = null,
        this.gap = null,
        this.direction = null,
        this.container = false,
        super(key: key);

  /// 构建图文按钮
  HYTextButton.icon({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.title,
    this.fontSize,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.pressedTextColor,
    this.backgroundColor=Colors.transparent,
    this.pressedBackgroundColor,
    this.borderColor=Config.color333333,
    this.borderWidth=1,
    this.borderStyle=BorderStyle.none,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.overlayColor,
    this.borderRadius,
    this.enableFeedback,
    this.animationDuration,
    this.repeatInterval=1,
    @required this.icon,
    this.gap = 8,
    this.direction = HYTextButtonIconTextDirection.textRIconL,
    this.width,
    this.height,
    this.enable=true,
    this.unenbleTextColor,
    this.unenbleBackgroundColor,
  }) : this.container = false,
        super(key: key);

  HYTextButton.container({
    Key? key,
    this.icon,
    this.onPressed,
    this.onLongPress,
    this.title,
    this.fontSize,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.pressedTextColor,
    this.backgroundColor=Colors.transparent,
    this.pressedBackgroundColor,
    this.borderColor=Config.color333333,
    this.borderWidth=1,
    this.borderStyle=BorderStyle.none,
    this.padding,
    this.borderRadius,
    this.gap = 8,
    this.direction = HYTextButtonIconTextDirection.textRIconL,
    this.enable=true,
    this.width,
    this.height,
    this.repeatInterval=1,
    this.unenbleTextColor,
  }) : this.container = true,
        this.unenbleBackgroundColor = null,
        this.elevation = null,
        this.shadowColor = null,
        this.overlayColor = null,
        this.enableFeedback = null,
        this.animationDuration = null,
        super(key: key);

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  /// 按钮标题
  final String? title;
  /// 字体大小
  final double? fontSize;
  /// 默认字体颜色
  final Color? textColor;
  /// 选中字体颜色
  final Color? pressedTextColor;
  /// 字体
  final String? fontFamily;
  /// 字体样式
  final FontWeight? fontWeight;
  /// 默认背景颜色
  final Color backgroundColor;
  /// 选中背景颜色
  final Color? pressedBackgroundColor;
  /// 边框颜色
  final Color borderColor;
  /// 边框宽度
  final double borderWidth;
  /// 边框样式
  final BorderStyle borderStyle;
  /// 宽
  final double? width;
  /// 高
  final double? height;
  /// padding
  final EdgeInsetsGeometry? padding;
  /// 阴影
  final double? elevation;
  /// 阴影颜色
  final Color? shadowColor;
  /// 高亮色，按钮处于focused, hovered, or pressed时的颜色
  final Color? overlayColor;
  /// 边框圆角
  final BorderRadiusGeometry? borderRadius;
  /// 检测到的手势是否应提供声音和/或触觉反馈。例如，在Android上，点击会产生咔哒声，启用反馈后，长按会产生短暂的振动。通常，组件默认值为true。
  final bool? enableFeedback;
  /// [shape]和[elevation]的动画更改的持续时间。
  final Duration? animationDuration;
  /// 防止重复点击时间间隔，单位：秒
  final int repeatInterval;
  /// 图片
  final Widget? icon;
  /// 图片与文字的间隔
  final double? gap;
  /// Icon方向
  final HYTextButtonIconTextDirection? direction;
  /// 是否可以点击
  final bool enable;
  /// 不可点击时候字体颜色
  final Color? unenbleTextColor;
  /// 不可点击时候背景颜色
  final Color? unenbleBackgroundColor;
  /// 是否容器，true 的时候不用TextButton ，直接使用 XFSContainer
  final bool container;

  /// 上次点击时间，防止重复点击
  DateTime? _lastPressedAdt;

  @override
  Widget build(BuildContext context) {

    if (container){
      return HYContainer(
        width: width,
        height: height,
        child: icon == null ? _buildTextChild() : _buildIconChild()!,
        backgroundColor: enable ? unenbleBackgroundColor??backgroundColor : backgroundColor,
        padding: padding,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, style: borderStyle, width: borderWidth),
        repeatInterval: repeatInterval,
        onTap: onPressed == null ? onPressed : (){
          if (enable){
            _oneClick();
          }
        },
      );
    }

    return TextButton(
      onPressed: onPressed == null ? onPressed : (){
        if (enable){
          _oneClick();
        }
      },
      child: icon == null ? _buildTextChild() : _buildIconChild()!,
      onLongPress: onLongPress,
      style: ButtonStyle(
        foregroundColor: enable ? MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.pressed) ? pressedTextColor??textColor : textColor;
        }) : MaterialStateProperty.all(unenbleTextColor??Config.colorE7E7E7),
        backgroundColor: enable ? MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.pressed) ? pressedBackgroundColor??backgroundColor : backgroundColor;
        }) : MaterialStateProperty.all(unenbleBackgroundColor??Colors.white),
        side: MaterialStateProperty.all(BorderSide(color: borderColor, style: borderStyle, width: borderWidth)),
        minimumSize: MaterialStateProperty.all(Size(width??63, height??36)),
        padding: MaterialStateProperty.all(padding),
        elevation: MaterialStateProperty.all(elevation),
        shadowColor: MaterialStateProperty.all(shadowColor),
        overlayColor: MaterialStateProperty.all(enable ? overlayColor : Colors.transparent),
        shape: borderRadius == null ? null : MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius!)),
        enableFeedback: enableFeedback,
        animationDuration: animationDuration,
      ),
    );
  }

  /// 构建文本图片。
  Widget? _buildIconChild(){


    // ignore: missing_enum_constant_in_switch
    switch(direction){

      case HYTextButtonIconTextDirection.textLIconR:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextChild(),
            SizedBox(width: gap,),
            icon!,
          ],
        );
      case HYTextButtonIconTextDirection.textRIconL:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            SizedBox(width: gap,),
            _buildTextChild(),
          ],
        );
      case HYTextButtonIconTextDirection.textTIconB:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextChild(),
            SizedBox(height: gap,),
            icon!,
          ],
        );
      case HYTextButtonIconTextDirection.textBIconT:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            SizedBox(height: gap,),
            _buildTextChild(),
          ],
        );
    }
  }

  /// 构建文本
  Widget _buildTextChild(){
    return Text(
      title??'',
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: enable ? textColor : unenbleTextColor??Config.colorE7E7E7 ,
      ),
    );
  }

  /// 防止重复点击，
  void _oneClick(){

    if(_lastPressedAdt == null || DateTime.now().difference(_lastPressedAdt!)> Duration(seconds: repeatInterval)){
      //两次点击时间间隔超过1秒则重新计时
      _lastPressedAdt = DateTime.now();
      if (onPressed != null){
        onPressed!();
      }
    }
  }

}


class HYButton extends StatelessWidget {

  /// 构建纯文本按钮
  HYButton.text({
    Key? key,
    this.onPressed,
    this.onLongPress,
    @required this.title,
    this.fontSize,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.pressedTextColor,
    this.backgroundColor=Colors.transparent,
    this.pressedBackgroundColor,
    this.borderColor=Config.color333333,
    this.borderWidth=1,
    this.borderStyle=BorderStyle.none,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.overlayColor,
    this.borderRadius,
    this.enableFeedback,
    this.animationDuration,
    this.repeatInterval=1,
    this.width=0,
    this.height=0,
    this.enable=true,
    this.unenbleTextColor,
    this.unenbleBackgroundColor,
  }) : icon = null,
        gap = null,
        direction = null,
        super(key: key);

  /// 构建图文按钮
  HYButton.icon({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.title,
    this.fontSize,
    this.textColor,
    this.fontFamily,
    this.fontWeight,
    this.pressedTextColor,
    this.backgroundColor=Colors.transparent,
    this.pressedBackgroundColor,
    this.borderColor=Config.color333333,
    this.borderWidth=1,
    this.borderStyle=BorderStyle.none,
    this.padding,
    this.elevation,
    this.shadowColor,
    this.overlayColor,
    this.borderRadius,
    this.enableFeedback,
    this.animationDuration,
    this.repeatInterval=1,
    @required this.icon,
    this.gap = 8,
    this.direction = HYTextButtonIconTextDirection.textRIconL,
    this.width=63,
    this.height=36,
    this.enable=true,
    this.unenbleTextColor,
    this.unenbleBackgroundColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  /// 按钮标题
  final String? title;
  /// 字体大小
  final double? fontSize;
  /// 默认字体颜色
  final Color? textColor;
  /// 选中字体颜色
  final Color? pressedTextColor;
  /// 字体
  final String? fontFamily;
  /// 字体样式
  final FontWeight? fontWeight;
  /// 默认背景颜色
  final Color backgroundColor;
  /// 选中背景颜色
  final Color? pressedBackgroundColor;
  /// 边框颜色
  final Color borderColor;
  /// 边框宽度
  final double borderWidth;
  /// 边框样式
  final BorderStyle borderStyle;
  /// 宽
  final double width;
  /// 高
  final double height;
  /// padding
  final EdgeInsetsGeometry? padding;
  /// 阴影
  final double? elevation;
  /// 阴影颜色
  final Color? shadowColor;
  /// 高亮色，按钮处于focused, hovered, or pressed时的颜色
  final Color? overlayColor;
  /// 边框圆角
  final BorderRadiusGeometry? borderRadius;
  /// 检测到的手势是否应提供声音和/或触觉反馈。例如，在Android上，点击会产生咔哒声，启用反馈后，长按会产生短暂的振动。通常，组件默认值为true。
  final bool? enableFeedback;
  /// [shape]和[elevation]的动画更改的持续时间。
  final Duration? animationDuration;
  /// 防止重复点击时间间隔，单位：秒
  final int repeatInterval;
  /// 图片
  final Widget? icon;
  /// 图片与文字的间隔
  final double? gap;
  /// Icon方向
  final HYTextButtonIconTextDirection? direction;
  /// 是否可以点击
  final bool enable;
  /// 不可点击时候字体颜色
  final Color? unenbleTextColor;
  /// 不可点击时候背景颜色
  final Color? unenbleBackgroundColor;

  /// 上次点击时间，防止重复点击
  DateTime? _lastPressedAdt;

  @override
  Widget build(BuildContext context) {

    return HYContainer(
      onTap: onPressed == null ? onPressed : (){
        if (enable){
          _oneClick();
        }
      },
      child: icon == null ? _buildTextChild() : _buildIconChild()!,
      backgroundColor: enable ? pressedBackgroundColor??backgroundColor : backgroundColor,
      padding: padding,
      borderRadius: borderRadius,
      border: Border.all(color: borderColor, style: borderStyle, width: borderWidth),

    );

  }

  /// 构建文本图片。
  Widget? _buildIconChild(){


    switch(direction){

      case HYTextButtonIconTextDirection.textLIconR:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextChild(),
            SizedBox(width: gap,),
            icon!,
          ],
        );
      case HYTextButtonIconTextDirection.textRIconL:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            SizedBox(width: gap,),
            _buildTextChild(),
          ],
        );
        break;
      case HYTextButtonIconTextDirection.textTIconB:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextChild(),
            SizedBox(height: gap,),
            icon!,
          ],
        );
      case HYTextButtonIconTextDirection.textBIconT:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon!,
            SizedBox(height: gap,),
            _buildTextChild(),
          ],
        );
    }
  }

  /// 构建文本
  Widget _buildTextChild(){
    return Text(
      title??'',
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }

  /// 防止重复点击，
  void _oneClick(){

    if(_lastPressedAdt == null || DateTime.now().difference(_lastPressedAdt!)> Duration(seconds: repeatInterval)){
      //两次点击时间间隔超过1秒则重新计时
      _lastPressedAdt = DateTime.now();
      if (onPressed != null){
        onPressed!();
      }
    }
  }

}