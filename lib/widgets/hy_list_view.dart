import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


/// Created by wdx
/// on 2022-07-11
/// page hu_list_view
/// 带headerList 类似iOS UITableView


class HYListView extends BoxScrollView {

  HYListView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    this.itemExtent,
    required HYListDelegate delegate,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) :
        _itemCount = delegate._buildChild(),
        childrenDelegate = SliverChildBuilderDelegate(
              (context, index) => delegate._itemBuilder(context, index),
          childCount: delegate._itemCount(),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
        key: key,
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount ?? delegate._itemCount(),
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
      );


  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  ///
  /// Specifying an [itemExtent] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  final double? itemExtent;

  /// A delegate that provides the children for the [ListView].
  ///
  /// The [ListView.custom] constructor lets you specify this delegate
  /// explicitly. The [ListView] and [ListView.builder] constructors create a
  /// [childrenDelegate] that wraps the given [List] and [IndexedWidgetBuilder],
  /// respectively.
  final SliverChildDelegate childrenDelegate;

  final int _itemCount;

  @override
  Widget buildChildLayout(BuildContext context) {
    if (itemExtent != null) {
      return SliverFixedExtentList(
        delegate: childrenDelegate,
        itemExtent: itemExtent!,
      );
    }
    return SliverList(delegate: childrenDelegate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('itemExtent', itemExtent, defaultValue: null));
  }

  // Helper method to compute the actual child count for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}

/// list分区显示
abstract class HYListDelegate {

  /// 存放列表样式数据
  List<HYListTypeModel> _list = [];

  /// 构建列表list数据
  int _buildChild(){
    // 所有分区个数
    int sectionLengh = sectionCount();

    // 判断是否有listHeader，只显示在列表头部
    if (buildHeader() != null) {

      HYListTypeModel listHeaderTypeModel = HYListTypeModel(type: HYListWidgetType.listHeader,);
      _list.add(listHeaderTypeModel);
    }

    // section
    for (int section = 0; section < sectionLengh; section++) {
      if (buildSectionHeader(section) != null){
        HYListTypeModel sectionTypeModel = HYListTypeModel(type: HYListWidgetType.sectionHeader, section: section);
        _list.add(sectionTypeModel);
      }

      // Item
      var rowCount = itemCount(section);
      for (int row = 0; row < rowCount; row++) {
        HYListTypeModel rowTypeModel = HYListTypeModel(type: HYListWidgetType.item, section: section, row: row);
        _list.add(rowTypeModel);
      }

      if (buildSectionFooter(section) != null){
        HYListTypeModel sectionFooterTypeModel = HYListTypeModel(type: HYListWidgetType.sectionFooter, section: section);
        _list.add(sectionFooterTypeModel);
      }

    }

    // listFooter
    if (buildFooter() != null) {
      HYListTypeModel listFooterTypeModel = HYListTypeModel(type: HYListWidgetType.listFooter,);
      _list.add(listFooterTypeModel);
    }

    return _list.length;
  }

  /// 返回item个数，
  /// [section] 属于哪一个分区
  ///
  /// return [int]
  int itemCount(int section);

  /// 返回section个数，必选返回数据，最小返回1，如果返回0就不显示数据
  ///
  /// return [int]
  int sectionCount();

  /// item构建
  /// [section] 分区
  /// [row] 行
  ///
  /// return [Widget]
  Widget buildItem(BuildContext context, int section, int row,);

  /// section头构建
  /// [section] 分区
  ///
  /// return [Widget]
  Widget? buildSectionHeader(int section) => null;

  /// section底部构建
  /// [section] 分区
  ///
  /// return [Widget]
  Widget? buildSectionFooter(int section) => null;

  /// 列表顶部构建
  ///
  /// return [Widget]
  Widget? buildHeader() => null;

  /// 列表底部构建
  ///
  /// return [Widget]
  Widget? buildFooter() => null;

  /// 获取列表数量
  ///
  /// return int
  int _itemCount(){
    return _list.length;
  }

  /// 获取构建item
  /// [index] 下标
  ///
  /// return widget
  Widget? _itemBuilder(BuildContext context, int index) {
    HYListTypeModel listTypeModel = _list[index];

    switch(listTypeModel.type){

      case HYListWidgetType.listHeader:
        return buildHeader();
      case HYListWidgetType.sectionHeader:
        return buildSectionHeader(listTypeModel.section!);
      case HYListWidgetType.item:
        return buildItem(context, listTypeModel.section!, listTypeModel.row!);
      case HYListWidgetType.sectionFooter:
        return buildSectionFooter(listTypeModel.section!);
      case HYListWidgetType.listFooter:
        return buildFooter();
    }
  }
}

/// 用于区分listItem显示
class HYListTypeModel{
  final HYListWidgetType type;
  final int? section;
  final int? row;

  HYListTypeModel({this.type=HYListWidgetType.item, this.section, this.row,});
}

/// HYListItem显示样式
enum HYListWidgetType{
  /// 列表头
  listHeader,
  /// 分区头
  sectionHeader,
  /// item
  item,
  /// 分区底部
  sectionFooter,
  /// 列表底部
  listFooter,
}