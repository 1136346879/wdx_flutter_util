import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/extension/hy_extension.dart';
import 'package:hy_flutter_utils/widgets/hy_inkwell.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_contain

class HYContainer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角
  final BorderRadiusGeometry? borderRadius;

  /// 边框
  final BoxBorder? border;

  /// 点击事件
  final Function()? onTap;

  /// 高度
  final double? height;

  /// 宽度
  final double? width;

  /// 控件的alignment
  final AlignmentGeometry? alignment;

  /// 子视图
  final Widget? child;

  /// 约束
  final BoxConstraints? constraints;

  /// 背景图片
  final String? backgroundImage;
  final BoxFit? backgroundImageFit;
  final AlignmentGeometry backgroundAlignment;
  final BoxShape shape;
  final List<BoxShadow>? boxShadow;

  /// 防止重复点击时间间隔，单位：秒 默认1秒
  final int repeatInterval;
  final LinearGradient? gradient;

  final Clip clipBehavior;
  const HYContainer({
    Key? key,
    this.padding,
    this.margin,
    this.backgroundColor = Colors.transparent,
    this.borderRadius,
    this.border,
    this.onTap,
    this.height,
    this.width,
    this.alignment,
    this.child,
    this.constraints,
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundAlignment = Alignment.bottomRight,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.repeatInterval = 1,
    this.gradient,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? HYInkWell(
            child: _container(),
            onTap: onTap,
            repeatInterval: repeatInterval,
          )
        : _container();
  }

  Widget _container() {
    return Container(
      constraints: constraints,
      alignment: alignment,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
          shape: shape,
          boxShadow: boxShadow,
          color: backgroundColor,
          borderRadius: borderRadius,
          border: border,
          gradient: gradient,
          image: backgroundImage.isNullOrEmpty()
              ? null
              : DecorationImage(
                  image: _buildDecorationImage(),
                  fit: backgroundImageFit ?? BoxFit.cover,
                  alignment: backgroundAlignment,
                )),
      child: child ?? Container(),
    );
  }

  ImageProvider _buildDecorationImage() {
    if (backgroundImage!.startsWith('http')) {
      return NetworkImage(backgroundImage!);
    } else {
      return AssetImage(backgroundImage!);
    }
  }
}
