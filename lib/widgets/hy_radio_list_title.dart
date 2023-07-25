import 'package:flutter/material.dart';

import 'hy_container.dart';
import 'hy_text.dart';


/// Created by wdx
/// on 2022-07-8
/// page hy_radio_list_title
/// 单选多选组件

class HYRadioListTitle extends StatelessWidget {

  const HYRadioListTitle({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
    this.horizontal=0,
    this.activeColor,
  });


  /// 标题
  final String? label;
  /// 控件的间距
  final EdgeInsets? padding;
  /// groupValue
  final String? groupValue;
  /// value
  final String? value;
  /// 选择回调
  final Function? onChanged;
  final Color? activeColor;
  /// 文字和图片间距
  final double horizontal;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        if (value != groupValue)
          onChanged?.call(value);
      },
      child: Container(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<String?>(
              activeColor: activeColor,
              groupValue: groupValue,
              value: value,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (String? newValue) {
                onChanged?.call(value);
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: Text(label!),
            ),
          ],
        ),
      ),
    );
  }
}


class HYRadioTitle<T> extends StatelessWidget {

  /// 纯文本样式
  HYRadioTitle.text({
    this.label,
    this.margin,
    this.groupValue,
    this.value,
    this.singleCallback,
    this.multipleCallback,
    this.activeColor,
    this.width,
    this.height,
    this.backgroudColor,
    this.radius,
    this.textColor,
    this.activeTextColor,
    this.fontSize=12,
    this.tag,
    this.isMultipleChoice=false,
    this.data,
    this.normalBorder,
    this.selectedBorder,
    this.constraints,
    this.padding,
    this.initSelected=false,
    this.index,
    this.normalBackgroundImage,
    this.selectedBackgroundImage,
    this.backgroundAlignment=Alignment.bottomRight,
  }) : selectedImage=null,
        normalImage=null,
        imageSize=null,
        horizontal=0.0,
        showImage=false;

  /// 点图片样式
  HYRadioTitle.image({
    this.label,
    this.margin,
    this.value,
    this.activeColor,
    this.width,
    this.height,
    this.backgroudColor,
    this.radius,
    this.textColor,
    this.activeTextColor,
    this.groupValue,
    this.fontSize=12,
    this.tag,
    this.isMultipleChoice=false,
    this.data,
    this.initSelected=false,
    required this.selectedImage,
    required this.normalImage,
    required this.imageSize,
    this.horizontal = 5.0,
    this.normalBorder,
    this.selectedBorder,
    this.constraints,
    this.padding,
    this.index,
    this.singleCallback,
    this.multipleCallback,
    this.normalBackgroundImage,
    this.selectedBackgroundImage,
    this.backgroundAlignment=Alignment.bottomRight,
  }) : showImage = true,
        assert(selectedImage != null),
        assert(normalImage != null),
        assert(imageSize != null);

  /// 标题
  final String? label;
  /// 控件的间距
  final EdgeInsets? margin;
  final EdgeInsetsGeometry? padding;
  /// groupValue
  final String? groupValue;
  /// value
  final String? value;
  /// 选中颜色
  final Color? activeColor;
  /// 字体颜色
  final Color? textColor;
  /// 字体选中颜色
  final Color? activeTextColor;
  /// 字体大小
  final double fontSize;
  /// 宽度
  final double? width;
  /// 高度
  final double? height;
  /// 背景颜色
  final Color? backgroudColor;
  /// 圆角
  final BorderRadiusGeometry? radius;
  /// tag标记
  final int? tag;
  /// 是否多选,默认false
  final bool isMultipleChoice;
  /// 标签对应的数据
  final T? data;
  /// 初始化是否选中,默认false
  final bool initSelected;
  /// 是否显示图片
  final bool showImage;
  /// 选中图片
  final String? selectedImage;
  /// 未选中图片
  final String? normalImage;
  /// 图片大小，
  final Size? imageSize;
  /// 文字和图片间距
  final double horizontal;
  /// 边框
  final BoxBorder? normalBorder;
  /// 边框
  final BoxBorder? selectedBorder;
  /// 约束
  final BoxConstraints? constraints;
  final int? index;
  /// 单选回调
  final Function(int? tag, String? value, dynamic data)? singleCallback;
  /// 多选回调
  final Function(int? tag, String? value, dynamic data, int? index, bool selected)? multipleCallback;
  /// 未选择背景
  final String? normalBackgroundImage;
  /// 选中背景
  final String? selectedBackgroundImage;
  final AlignmentGeometry backgroundAlignment;

  @override
  Widget build(BuildContext context) {

    return HYContainer(
      width: width,
      height: height,
      alignment: Alignment.center,
      backgroundAlignment: backgroundAlignment,
      backgroundImage: isMultipleChoice ? !initSelected ? normalBackgroundImage : selectedBackgroundImage : value != groupValue ? normalBackgroundImage : selectedBackgroundImage,
      constraints: constraints,
      margin: margin,
      padding: padding,
      border: isMultipleChoice ? !initSelected ? normalBorder : selectedBorder : value != groupValue ? normalBorder : selectedBorder,
      backgroundColor: isMultipleChoice ? !initSelected ? backgroudColor : activeColor : value != groupValue ? backgroudColor : activeColor,
      borderRadius: radius,
      onTap: () {
        if (isMultipleChoice){
          multipleCallback?.call(tag, value, data, index, !initSelected);
        }else {
          if (value != groupValue){
            singleCallback?.call(tag, value, data,);
          } else {
            singleCallback?.call(tag, value, data,);
          }
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          showImage ? Container(
            child: Image.asset(isMultipleChoice ? !initSelected ? normalImage! : selectedImage! : value != groupValue ? normalImage! : selectedImage!, width: imageSize!.width, height: imageSize!.height,),
          ) : SizedBox(width: 0,),
          showImage ? SizedBox(width: horizontal,) : SizedBox(width: 0,),
          HyText.normal(
            label??'',
            textAlign: TextAlign.center,
            fontSize: fontSize,
            textColor: isMultipleChoice ? !initSelected ? textColor : activeTextColor : value != groupValue ? textColor : activeTextColor,
          ),
        ],
      ),
    );
  }

}