import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extension/hy_extension.dart';

import '../define/hy_config.dart';
import '../widgets/hy_container.dart';


/// formmart样式输入框
class HYFormTextField extends StatelessWidget{

  final bool obscureText;
  final TextEditingController? controller;
  /// inputFormatters 中的参数，限制最大数以后底部不会出现输入字数提示
  final int inputMaxLength;
  /// flutter自带的限制最大数，底部会自动出现输入数字提示
  final int maxLength;
  /// 最大行数，默认1
  final int? maxLine;
  final int? minLines;
  final String? labelText;
  final double labelTextFontSize;
  final Color labelTextColor;
  final String? hintText;
  final double hintTextFontSize;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final FormFieldValidator<String>? validator;
  /// 暗黑模式字体颜色
  final Color? darkTextColor;

  const HYFormTextField(
      {Key? key,
        this.obscureText = false,
        this.controller,
        this.maxLength = 10000,
        this.inputMaxLength = 10000,
        this.labelText,
        this.hintText,
        this.prefixIcon,
        this.enabledBorder,
        this.focusedBorder,
        this.validator,
        this.labelTextColor=Colors.black,
        this.hintTextColor,
        this.labelTextFontSize=15,
        this.hintTextFontSize=15,
        this.darkTextColor,
        this.maxLine,
        this.minLines,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      obscureText: obscureText,
      inputFormatters: [
        LengthLimitingTextInputFormatter(inputMaxLength),
      ],
      maxLength: maxLength,
      maxLines: maxLine??1,
      minLines: minLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: hyColor(light: labelTextColor, dark: darkTextColor),
          fontSize: labelTextFontSize,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontSize: hintTextFontSize,
        ),
        prefixIcon: prefixIcon,
        // 未获得焦点下划线设为灰色
        enabledBorder: enabledBorder??UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        //获得焦点下划线设为蓝色
        focusedBorder: focusedBorder??UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      controller: controller,
      validator: validator,
    );
  }
}

/// ios样式输入框
class HYCupertinoTextField extends StatelessWidget{

  /// 隐藏文本
  final bool obscureText;
  final TextEditingController? controller;
  /// inputFormatters 中的参数，限制最大数以后底部不会出现输入字数提示
  final int? inputMaxLength;
  /// flutter自带的限制最大数，底部会自动出现输入数字提示
  final int maxLength;
  /// 提示文字.文本框聚焦的时候整个文案会上移
  final String? labelText;
  /// 提示字体大小
  final double labelTextFontSize;
  /// 提示字体颜色
  final Color labelTextColor;
  /// 默认显示
  final String? hintText;
  final double? hintTextFontSize;
  final Color hintTextColor;
  final ValueChanged<String>? onChanged;
  final double? height;
  final double? width;
  /// 外层container的属性
  final EdgeInsetsGeometry? padding;
  /// 外层container的属性
  final EdgeInsetsGeometry? margin;
  /// textflied的属性
  final EdgeInsetsGeometry contentPadding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  /// 文本对齐方式
  final TextAlign textAlign;
  /// 对齐方式
  final AlignmentGeometry alignment;
  /// 最大输入行数
  final int? maxLines;
  final int? minLines;
  /// 是否可用.
  /// Disables the text field when false.
  final bool? enabled;
  /// 焦点
  final FocusNode? focusNode;
  /// 文本字体大小
  final double? textFontSize;
  /// 文本字体颜色
  final Color? textColor;
  final ValueChanged<String>? onSubmitted;
  /// 键盘输入模式
  final TextInputType? keyboardType;
  /// 清空按钮显示
  final OverlayVisibilityMode clearButtonMode;
  /// 键盘右下角按钮样式
  final TextInputAction textInputAction;
  /// 显示在文本输入框后面
  final Widget? suffix;
  /// 显示模式[OverlayVisibilityMode] 默认 [OverlayVisibilityMode.never]
  final OverlayVisibilityMode suffixMode;
  /// 显示在文本输入框前面的
  final Widget? prefix;
  /// 显示模式[OverlayVisibilityMode] 默认 [OverlayVisibilityMode.never]
  final OverlayVisibilityMode prefixMode;
  /// 是否自动获取焦点
  final bool autofocus;
  /// 光标颜色
  final Color? cursorColor;
  /// 是否只读
  final bool readOnly;
  /// 长按弹出工具栏
  /// [ToolbarOptions]
  /// const ToolbarOptions(
  //            selectAll: true,
  //            paste: true,
  //          )
  final ToolbarOptions? toolbarOptions;
  final VoidCallback? onEditingComplete;
  /// 输入约束,限制输入数字直接用[inputMaxLength]字段，不需要用[LengthLimitingTextInputFormatter],内部已经实现
  /// [FilteringTextInputFormatter.digitsOnly,]只能输入数字
  final List<TextInputFormatter>? inputFormatters;
  /// 是否禁用emoji表情
  final emojiEnabled;
  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback? onTap;

  const HYCupertinoTextField(
      {Key? key,
        this.obscureText = false,
        this.controller,
        this.inputMaxLength,
        this.maxLength = 10000,
        this.labelText,
        this.focusNode,
        this.hintText,
        this.labelTextColor=Colors.black,
        this.hintTextColor=Colors.grey,
        this.labelTextFontSize=15,
        this.hintTextFontSize=13,
        this.onChanged,
        this.height,
        this.width,
        this.padding=const EdgeInsets.all(0),
        this.margin,
        this.enabled,
        this.backgroundColor,
        this.borderRadius,
        this.border,
        this.textAlign=TextAlign.start,
        this.alignment = Alignment.center,
        this.maxLines,
        this.textFontSize,
        this.textColor,
        this.onSubmitted,
        this.keyboardType,
        this.clearButtonMode=OverlayVisibilityMode.never,
        this.textInputAction=TextInputAction.done,
        this.suffix,
        this.suffixMode=OverlayVisibilityMode.never,
        this.autofocus=false,
        this.contentPadding=const EdgeInsets.all(0),
        this.cursorColor,
        this.prefix,
        this.prefixMode=OverlayVisibilityMode.never,
        this.readOnly=false,
        this.toolbarOptions,
        this.onEditingComplete,
        this.inputFormatters,
        this.emojiEnabled = true,
        this.minLines,
        this.onTap,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// 输入约束
    List<TextInputFormatter> list = [];
    if (inputMaxLength != null){
      list.add(LengthLimitingTextInputFormatter(inputMaxLength));
    }
    if (inputFormatters.isNotNullOrEmpty()){
      list.addAll(inputFormatters!);
    }

    if (emojiEnabled){
      list.add(FilteringTextInputFormatter.deny(RegExp("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]")));
    }

    return Container(
      padding: padding,
      alignment:alignment,
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          color: backgroundColor??Colors.transparent
      ),
      child: CupertinoTextField(
        onTap: onTap,
        inputFormatters: list,
        cursorColor: cursorColor,
        maxLength: maxLength,
        obscureText: obscureText,
        prefix: prefix??Container(margin: EdgeInsets.only(right: 5), child: Icon(Icons.search, size: 15, color: Colors.grey,),),
        prefixMode: prefixMode,
        autofocus: autofocus,
        focusNode: focusNode,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        maxLines: maxLines??1,
        minLines: minLines,
        padding: contentPadding,
        placeholder: hintText??"",
        placeholderStyle: TextStyle(
          color: hintTextColor,
          fontSize: hintTextFontSize,
        ),
        keyboardType: keyboardType,
        clearButtonMode: clearButtonMode,
        textInputAction: textInputAction,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        textAlign: textAlign,
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        style: TextStyle(
          color: textColor,
          fontSize: textFontSize,
        ),
        suffix: suffix??Container(margin: EdgeInsets.only(right: 5), child: Icon(Icons.search, size: 15, color: Colors.grey,),),
        suffixMode: suffixMode,
        readOnly: readOnly,
        toolbarOptions: toolbarOptions,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}

/// flutter样式输入框
class HYTextField extends StatelessWidget {
  
  /// 隐藏文本，密码输入
  final bool obscureText;
  final TextEditingController? controller;
  /// inputFormatters 中的参数，限制最大数以后底部不会出现输入字数提示
  final int? inputMaxLength;
  /// flutter自带的限制最大数，底部会自动出现输入数字提示
  final int? maxLength;
  /// 提示文字.文本框聚焦的时候整个文案会上移
  final String? labelText;
  /// 提示字体大小
  final double labelTextFontSize;
  /// 提示字体颜色
  final Color labelTextColor;
  /// 默认显示
  final String? hintText;
  final double hintTextFontSize;
  final Color hintTextColor;
  final ValueChanged<String>? onChanged;
  final Color? backgroundColor;
  /// 文本对齐方式
  final TextAlign textAlign;
  /// 对齐方式
  final AlignmentGeometry? alignment;
  /// 最大输入行数
  final int? maxLines;
  final int? minLines;
  /// 是否可用
  final bool? enabled;
  /// 焦点
  final FocusNode? focusNode;
  /// 文本字体大小
  final double? textFontSize;
  /// 文本字体颜色
  final Color? textColor;
  final ValueChanged<String>? onSubmitted;
  /// 键盘输入模式
  final TextInputType? keyboardType;
  /// 键盘右下角按钮样式
  final TextInputAction? textInputAction;
  /// 显示在文本输入框后面
  final Widget? suffix;
  /// 显示在文本输入框前面的
  final Widget? prefix;
  ///输入样式自定义
  final InputDecoration? decoration;
  /// 是否自动获取焦点
  final bool autofocus;
  /// 光标颜色
  final Color cursorColor;
  /// 左侧图标,
  final String? prefixImage;
  /// 左侧图标,本地图片路径
  final String? suffixImage;
  /// 文本方向
  final TextDirection? textDirection;
  final EdgeInsetsGeometry? prefixIconPadding;
  final EdgeInsetsGeometry? suffixIconPadding;
  final double? height;
  /// 输入框填充颜色
  final Color fillColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  /// 输入约束,限制输入数字直接用[inputMaxLength]字段，不需要用[LengthLimitingTextInputFormatter],内部已经实现
  /// [FilteringTextInputFormatter.digitsOnly,]只能输入数字
  final List<TextInputFormatter>? inputFormatters;
  /// 圆角
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  /// 是否禁用emoji表情
  final emojiEnabled;
  /// 文本输入字数限制widget
  final InputCounterWidgetBuilder? buildCounter;

  const HYTextField({
    Key? key,
    this.obscureText=false,
    this.controller,
    this.inputMaxLength,
    this.maxLength,
    this.labelText,
    this.labelTextFontSize=15,
    this.labelTextColor=Colors.black,
    this.hintTextColor=Colors.grey,
    this.hintText,
    this.hintTextFontSize=13,
    this.onChanged,
    this.backgroundColor,
    this.textAlign=TextAlign.start,
    this.alignment,
    this.maxLines,
    this.enabled,
    this.focusNode,
    this.textFontSize,
    this.textColor,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.suffix,
    this.prefix,
    this.autofocus=false,
    this.cursorColor=Config.colorFFA200,
    this.prefixImage,
    this.suffixImage,
    this.border,
    this.textDirection,
    this.prefixIconPadding,
    this.suffixIconPadding,
    this.height,
    this.fillColor=Colors.transparent,
    this.padding,
    this.margin,
    this.inputFormatters,
    this.borderRadius,
    this.emojiEnabled=true,
    this.minLines,
    this.decoration,
    this.buildCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// 输入约束
    List<TextInputFormatter> list = [];
    if (inputMaxLength != null){
      list.add(LengthLimitingTextInputFormatter(inputMaxLength));
    }
    if (inputFormatters.isNotNullOrEmpty()){
      list.addAll(inputFormatters!);
    }
    if (emojiEnabled){
      list.add(FilteringTextInputFormatter.deny(RegExp("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]")));
    }

    return HYContainer(
      padding: padding??EdgeInsets.only(),
      margin: margin??EdgeInsets.only(),
      height: height,
      backgroundColor: backgroundColor,
      alignment: alignment,
      borderRadius: borderRadius,
      border: border,
      child: _textField(list),
    );
  }

  _textField(List<TextInputFormatter> list){
    return TextField(
      controller: controller,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: textFontSize,
      ),
      autofocus: autofocus,
      obscureText: obscureText,
      cursorColor: cursorColor,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      enabled: enabled,
      maxLines: maxLines??1,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: list,
      textDirection: textDirection,
      buildCounter: buildCounter,
      decoration: decoration ?? InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 2),//偏移修正。当修饰框和输入内容一样的时候会向下偏移
        isCollapsed: true,
        labelText: labelText,
        labelStyle: TextStyle(
          color: labelTextColor,
          fontSize: labelTextFontSize,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontSize: hintTextFontSize,
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: fillColor,
        prefix: prefix,
        prefixIconConstraints: BoxConstraints(
            maxHeight: 15,
            maxWidth: 15
        ),
        prefixIcon: prefixImage.isNullOrEmpty() ? null : Container(
          child: Image.asset(prefixImage!, width: 15, height: 15,),
        ),
        suffixIconConstraints: BoxConstraints(
            maxHeight: 15,
            maxWidth: 15
        ),
        suffixIcon: suffixImage.isNullOrEmpty() ? null : Container(
          child: Image.asset(suffixImage!, width: 15, height: 15,),
        ),
        suffix: suffix,
      ),
    );
  }
}

