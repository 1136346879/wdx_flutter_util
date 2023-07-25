import 'package:flutter/material.dart';
import '../define/hy_config.dart';
import 'hy_container.dart';
import 'hy_radio_list_title.dart';

/// Created by wdx
/// on 2020/11/16
/// page ht_wrap_titles
/// desc 多选单选的多标题排列

class HYChooseWrapTheme {

  /// 控件的间距
  final EdgeInsets? margin;
  final EdgeInsetsGeometry? padding;
  /// 选中颜色
  final Color activeColor;
  /// 字体颜色
  final Color textColor;
  /// 字体选中颜色
  final Color activeTextColor;
  /// 字体大小
  final double fontSize;
  /// 宽度
  final double? width;
  /// 高度
  final double? height;
  /// 背景颜色
  final Color backgroudColor;
  /// 圆角
  final BorderRadiusGeometry? radius;
  /// 文字和图片间距
  final double horizontal;
  /// 是否显示图片,如果显示图片的话，下面跟图片有关的三项为必选，
  final bool showImage;
  /// 选中图片
  final String? selectedImage;
  /// 未选中图片
  final String? normalImage;
  /// 图片大小，
  final Size? imageSize;
  final BoxConstraints? constraints;
  /// 边框
  final BoxBorder? normalBorder;
  /// 边框
  final BoxBorder? selectedBorder;
  /// 未选择背景
  final String? normalBackgroundImage;
  /// 选中背景
  final String? selectedBackgroundImage;
  final AlignmentGeometry backgroundAlignment;
  /// 单选是否可以取消
  final bool canCancel;

  /// 纯文本样式
  const HYChooseWrapTheme.text( {
    this.margin,
    required this.activeColor,
    required this.textColor,
    required this.activeTextColor,
    this.fontSize=15,
    this.width,
    this.height,
    required this.backgroudColor,
    this.radius,
    this.constraints,
    this.normalBorder,
    this.selectedBorder,
    this.padding,
    this.normalBackgroundImage,
    this.selectedBackgroundImage,
    this.backgroundAlignment=Alignment.bottomRight,
    this.canCancel = true,
  }) : showImage = false,
        selectedImage = null,
        normalImage = null,
        imageSize = null,
        horizontal = 0;

  /// 图片样式
  const HYChooseWrapTheme.image( {
    this.margin,
    required this.activeColor,
    required this.textColor,
    required this.activeTextColor,
    this.fontSize=15,
    this.width,
    this.height,
    required this.backgroudColor,
    this.radius,
    this.selectedImage,
    this.normalImage,
    this.imageSize,
    this.horizontal=10,
    this.constraints,
    this.normalBorder,
    this.selectedBorder,
    this.padding,
    this.normalBackgroundImage,
    this.selectedBackgroundImage,
    this.backgroundAlignment=Alignment.bottomRight,
    this.canCancel = true,
  }): showImage = true,
        assert(activeColor != null),
        assert(activeTextColor != null),
        assert(backgroudColor != null),
        assert(textColor != null),
        assert(selectedImage != null),
        assert(normalImage != null),
        assert(imageSize != null);
}

/// 多列不规则排列
/// [list] 如果是自定义的数组. 需要实现抽象类[XFSTitle],不然不能显示标题
/// 如下：
/// class Model implements XFSTitle {
//
//   String name;
//
//   @override
//   String getTitle() {
//     return name;
//   }
// }
class HYChooseWrap<T> extends StatefulWidget {

  HYChooseWrap({
    Key? key,
    this.tag,
    required this.list,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.isMultipleChoice=false,
    this.initSelectedIndex,
    this.singleCallback,
    this.multipleCallback,
    required this.theme,
    this.margin,
    this.padding,
    this.maxSelectedCount,
    this.beyondMaxSelectedCallback,
    this.enable=true,
  }) : assert(theme != null),
        assert(list != null),
        super(key: key);

  /// tag标记
  final int? tag;

  /// 标签对应的数据
  final List<T> list;

  /// 方向
  final Axis direction;

  /// 对齐方式
  final WrapAlignment alignment;

  /// 水平间隔
  final double spacing;

  /// 对齐方式
  final WrapAlignment runAlignment;

  /// 垂直间隔
  final double runSpacing;

  /// 对齐方式
  final WrapCrossAlignment crossAxisAlignment;

  /// 是否多选,默认false
  final bool isMultipleChoice;

  /// 默认选中下标
  final int? initSelectedIndex;

  /// 单选回调,返回的是选中数据
  final Function(int tag, dynamic data)? singleCallback;

  /// 多选回调,返回的是选中数据
  final Function(int tag, List data)? multipleCallback;

  /// 控件的间距
  final EdgeInsets? margin;
  final EdgeInsetsGeometry? padding;
  /// 最大可选数。多选时候设置，默认无限大
  final int? maxSelectedCount;
  /// 超出最大可选数
  final Function? beyondMaxSelectedCallback;

  /// 样式
  final HYChooseWrapTheme theme;
  /// 是否可点击
  final bool enable;

  @override
  _HYChooseWrapState<T> createState() => _HYChooseWrapState<T>();

}

class _HYChooseWrapState<T> extends State<HYChooseWrap> {

  String? _groupValue;
  List _list = [];
  List<bool> _multipleSelectedList = [];

  @override
  void initState() {
    super.initState();

    // 单选时候，如果有默认选中并且当前index 和默认index相同时候 _groupValue 赋值为当前值
    if (!widget.isMultipleChoice && widget.initSelectedIndex != null){
      var element = widget.list[widget.initSelectedIndex!];
      _groupValue = _buildTitle(element);
    }

    _multipleSelectedList = List.generate(widget.list.length, (index) => index == widget.initSelectedIndex ? true : false);

  }

  @override
  Widget build(BuildContext context) {

    return HYContainer(
      padding: widget.padding,
      margin: widget.margin,
      child: Wrap(
        direction: widget.direction,
        alignment: widget.alignment,
        spacing: widget.spacing,
        runAlignment: widget.runAlignment,
        runSpacing: widget.runSpacing,
        children:List.generate(widget.list.length, (index) {
          var element = widget.list[index];
          String title = _buildTitle(element);
          return _buildChild(
            title: title,
            data: element,
            index: index,
          );
        }),
      ),
    );
  }

  /// 构建标题
  String _buildTitle(Object element){
    String title;
    if (element is String){
      title = element;
    }
    else if (element is HYTitle){
      title = element.getTitle();
    }
    else {
      title = element.toString();
    }
    return title;
  }

  _buildChild({String? title, T? data, int? index}){

    if (widget.theme.showImage){
      return HYRadioTitle<T>.image(
        padding: widget.theme.padding,
        normalBorder: widget.theme.normalBorder,
        selectedBorder: widget.theme.selectedBorder,
        constraints: widget.theme.constraints,
        label: title,
        margin: widget.theme.margin,
        width: widget.theme.width,
        height: widget.theme.height,
        value: title,
        activeColor: widget.theme.activeColor,
        activeTextColor: widget.theme.activeTextColor,
        backgroudColor: widget.theme.backgroudColor,
        textColor: widget.theme.textColor,
        fontSize: widget.theme.fontSize,
        radius: widget.theme.radius,
        tag: widget.tag,
        isMultipleChoice: widget.isMultipleChoice,
        data: data,
        singleCallback: (int? tag, String? value, dynamic t) => _onSingleClick(tag ?? 0, value ?? "", t),
        multipleCallback: (int? tag, String? value, dynamic data, int? index, bool? selected) => _onMultipleClick(tag ?? 0, value ?? "", data, index ?? 0, selected ?? false),
        groupValue: _groupValue,
        imageSize: widget.theme.imageSize!,
        normalImage: widget.theme.normalImage!,
        selectedImage: widget.theme.selectedImage!,
        horizontal: widget.theme.horizontal,
        initSelected: _multipleSelectedList[index!],
        index: index,
        normalBackgroundImage: widget.theme.normalBackgroundImage,
        selectedBackgroundImage: widget.theme.selectedBackgroundImage,
        backgroundAlignment: widget.theme.backgroundAlignment,
      );
    }

    return HYRadioTitle<T>.text(
      index: index,
      padding: widget.theme.padding,
      normalBorder: widget.theme.normalBorder,
      selectedBorder: widget.theme.selectedBorder,
      constraints: widget.theme.constraints,
      label: title,
      margin: widget.theme.margin,
      width: widget.theme.width,
      height: widget.theme.height,
      groupValue: _groupValue,
      value: title,
      activeColor: widget.theme.activeColor,
      activeTextColor: widget.theme.activeTextColor,
      backgroudColor: widget.theme.backgroudColor,
      textColor: widget.theme.textColor,
      fontSize: widget.theme.fontSize,
      radius: widget.theme.radius,
      tag: widget.tag,
      normalBackgroundImage: widget.theme.normalBackgroundImage,
      selectedBackgroundImage: widget.theme.selectedBackgroundImage,
      backgroundAlignment: widget.theme.backgroundAlignment,
      isMultipleChoice: widget.isMultipleChoice,
      data: data,
      initSelected: _multipleSelectedList[index!],
      singleCallback: (int? tag, String? value, dynamic t) => _onSingleClick(tag ?? 0, value ?? "", t),
      multipleCallback: (int? tag, String? value, dynamic data, int? index, bool? selected) => _onMultipleClick(tag ?? 0, value ?? "", data, index ?? 0, selected ?? false),
    );
  }

  _onSingleClick(int tag, String value, dynamic t){
    if (!widget.enable){
      return;
    }
    if (widget.theme.canCancel){
      _groupValue = '';
    } else {
      _groupValue = value;
    }
    if (widget.singleCallback != null){
      widget.singleCallback!(tag, t);
    }
    setState(() {});
  }

  _onMultipleClick(int tag, String value, dynamic t, int index, bool selected){
    if (!widget.enable){
      return;
    }
    if (_list.contains(t)){
      _list.remove(t);
    }else{
      _list.add(t);
    }
    List selectedList = [];
    for (int i = 0; i < _multipleSelectedList.length; i++){
      if (_multipleSelectedList[i] == true){
        selectedList.add(true);
      }
    }
    /// 判断是否最大可选数
    if (widget.maxSelectedCount != null && selectedList.length >= widget.maxSelectedCount! && selected){
      if (widget.beyondMaxSelectedCallback != null){
        widget.beyondMaxSelectedCallback!();
      }
    }else {
      _multipleSelectedList[index] = selected;
    }

    if (widget.multipleCallback != null){
      widget.multipleCallback!(tag, _list);
    }
    setState(() {});
  }
}
