import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/define/hy_config.dart';
import 'package:hy_flutter_utils/extension/hy_extension.dart';
import 'package:hy_flutter_utils/utils/hy_px_density.dart';

import 'hy_inkwell.dart';
import 'dart:ui' as ui show Shadow;

/// Created by wdx
/// on 2022/6/14
/// page hy_text

class HyText extends StatelessWidget {

  /// 纯文本属性。。
  final String? text;

  /// 默认14,字体大小
  final double? fontSize;

  /// 文字方向
  final TextAlign? textAlign;

  /// 最大行数
  final int? maxLines;

  /// How overflowing text should be handled.
  ///
  /// A [TextOverflow] can be passed to [Text] and [RichText] via their
  /// [Text.overflow] and [RichText.overflow] properties respectively.
  final TextOverflow? overflow;

  /// 文字加横线。
  /// 横线位置：
  /// [TextDecoration.overline] 文字顶部横线
  /// [TextDecoration.lineThrough] 文字中间横线
  /// [TextDecoration.underline] 文字底部横线
  /// 组合使用:[TextDecoration.combine(TextDecoration.overline, TextDecoration.underline])]
  final TextDecoration? decoration;

  /// 横线颜色
  final Color? decorationColor;

  /// 横线样式
  /// [TextDecorationStyle.double]双横线
  /// [TextDecorationStyle.dashed]虚线
  /// [TextDecorationStyle.dotted]点连成线
  /// [TextDecorationStyle.solid]实线默认样式
  /// [TextDecorationStyle.wavy]波浪线
  final TextDecorationStyle? decorationStyle;

  /// 字体类型
  final String? fontFamily;

  /// 字体颜色
  final Color? textColor;
  /// 字体，默认 Normal / regular / plain
  final FontWeight? fontWeight;

  final String hint;
  final Color hintColor;
  final double? hintFontSize;
  /// 文本是否换行
  final bool? softWrap;

  /// 文字渐变色
  /// [Paint]
  /// Paint()..shader = ui.Gradient.linear(const Offset(0, 20),const Offset(150, 20), [Colors.red, Colors.yellow])
  final Paint? foreground;

  /// 字母间距
  final double? letterSpacing;

  /// 单词间距
  final double? wordSpacing;

  ///文字添加阴影
  ///示例：[ui.Shadow]
  /// [
  //           Shadow(
  //             offset: Offset(10.0, 10.0),
  //             blurRadius: 3.0,
  //             color: Color.fromARGB(255, 0, 0, 0),
  //           ),
  //           Shadow(
  //             offset: Offset(10.0, 10.0),
  //             blurRadius: 8.0,
  //             color: Color.fromARGB(125, 0, 0, 255),
  //           )
  //         ]
  final List<ui.Shadow>? shadows;
  /// 默认实现，是否包含container。包含的话就可以设置高度，点击事件
  final bool hasContainer;

  /// 点击事件
  final Function()? onTap;

  /// ------包含container属性
  /// 控件的alignment
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  /// 背景颜色
  final Color? backgroudColor;

  /// 圆角
  final BorderRadiusGeometry? borderRadius;

  /// 边框
  final BoxBorder? border;

  /// 高度
  final double? height;

  /// 宽度
  final double? width;

  /// 约束
  final BoxConstraints? constraints;

  /// 防止重复点击时间间隔，单位：秒 默认1秒
  final int repeatInterval;

  /// 行高
  final StrutStyle? strutStyle;

  const HyText.container(this.text,{
    Key? key,
    this.fontSize,
    this.textAlign=TextAlign.left,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.fontFamily,
    this.textColor,
    this.padding,
    this.margin,
    this.backgroudColor=Colors.transparent,
    this.borderRadius,
    this.border,
    this.onTap,
    this.height,
    this.width,
    this.alignment=Alignment.centerLeft,
    this.fontWeight=FontWeight.w400,
    this.hint='',
    this.hintColor=Config.color999999,
    this.hintFontSize,
    this.softWrap,
    this.decorationColor,
    this.decorationStyle,
    this.foreground,
    this.letterSpacing,
    this.wordSpacing,
    this.shadows,
    this.constraints,
    this.repeatInterval = 1,
    this.strutStyle,
  }) : hasContainer = true,
        super(key: key);


  /// 纯文本，只有点击事件，和文本，不可以设置背景，边框，宽高等。
  const HyText.normal(this.text,
      {Key? key,
        this.fontSize,
        this.textAlign,
        this.maxLines,
        this.overflow,
        this.decoration,
        this.fontFamily,
        this.textColor,
        this.fontWeight,
        this.hint='',
        this.hintColor=Config.color999999,
        this.hintFontSize,
        this.decorationColor,
        this.decorationStyle,
        this.softWrap,
        this.foreground,
        this.onTap,
        this.letterSpacing,
        this.wordSpacing,
        this.shadows,
        this.repeatInterval = 1,
        this.strutStyle,
      }) : hasContainer = false,
        alignment = null,
        padding = null,
        margin = null,
        backgroudColor = null,
        borderRadius = null,
        border = null,
        height = null,
        width = null,
        constraints = null,
        super(key: key);

  /// 纯文本，只有点击事件，和文本，不可以设置背景，边框，宽高等。
  const HyText(this.text,
      {Key? key,
        this.fontSize,
        this.textAlign,
        this.maxLines,
        this.overflow,
        this.decoration,
        this.fontFamily,
        this.textColor,
        this.fontWeight,
        this.hint='',
        this.hintColor=Config.color999999,
        this.hintFontSize,
        this.decorationColor,
        this.decorationStyle,
        this.softWrap,
        this.foreground,
        this.onTap,
        this.letterSpacing,
        this.wordSpacing,
        this.shadows,
        this.repeatInterval = 1,
        this.strutStyle,
      }) : hasContainer = false,
        alignment = null,
        padding = null,
        margin = null,
        backgroudColor = null,
        borderRadius = null,
        border = null,
        height = null,
        width = null,
        constraints = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return  HYInkWell(
      child: hasContainer ? Container(
        constraints: constraints,
        alignment: alignment,
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroudColor,
          borderRadius: borderRadius,
          border: border,
        ),
        child: _buildText(),
      ) : _buildText(),
      onTap: onTap,
      repeatInterval: repeatInterval,
    );
  }

  _buildText(){
    return Text(
      (text.isNotNullOrEmpty() ? text : hint)!,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: (maxLines == 1 && overflow == null) ? TextOverflow.ellipsis : overflow,
      softWrap: softWrap,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: text.isNullOrEmpty() ? hintFontSize??sp12 : fontSize??sp14,
        color: text.isNullOrEmpty() ? hintColor : textColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontWeight: fontWeight,
        foreground: foreground,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        shadows: shadows,
      ),
      strutStyle: strutStyle,
    );
  }
}
