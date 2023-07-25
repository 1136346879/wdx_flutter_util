import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/utils/hy_px_density.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'hy_base.dart';
import 'hy_refresh_view.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_base_list_page_properties
/// desc 列表纯UI样式

mixin HYGetXBaseListPageUI<O> {
  /// 列表样式
  HYBaseListPageType get pageType => HYBaseListPageType.LIST;

  /// 表格padding属性
  EdgeInsetsGeometry? get listPadding => null;

  /// 是否需要上拉、下拉刷新组件
  bool get hasRefreshView => true;

  /// 进入页面自动刷新
  bool get autoRefresh => false;

  /// 属性控制器
  RefreshController? refreshController;

  /// 滑动控制器
  ScrollController? scrollController;

  // 横向滑动，与[setListHeight]一起使用
  Axis get scrollDirection => Axis.vertical;

  ///无限高度
  bool get shrinkWrap => false;

  ///列表是否反转
  bool get reverse => false;

  ///默认存在分页
  bool get hasLoadMore => true;

  ///默认可以刷新
  bool get hasRefresh => true;

  /// 默认分页，
  int? pageNumber = 1;

  /// 滑动样式
  ScrollPhysics? get configureScrollPhysics => null;

  /// 初始化RefreshController
  void initRefreshController() {
    refreshController = RefreshController(initialRefresh: autoRefresh);
  }

  /// 创建listView
  Widget createListView(List<O>? pageData) {
    return hasRefreshView
        ? HYRefreshView(
            listView: buildListChild(pageData),
            refreshController: refreshController,
            onLoading: onLoadMore,
            onRefresh: onRefresh,
            enableLoading: hasLoadMore,
            enableRefresh: hasRefresh,
            loadfailedOnTap: () => loadFailedTipOnTap(),
          )
        : buildListChild(pageData);
  }

  /// 构建页面,外部可以调用
  Widget buildListChild(List<O>? data) {
    return _initChildView(data);
  }

  /// 构建页面
  Widget _initChildView(List<O>? pageData) {
    switch (pageType) {
      case HYBaseListPageType.LIST:
        return ListView.builder(
          physics: configureScrollPhysics,
          shrinkWrap: shrinkWrap,
          padding: listPadding,
          controller: scrollController,
          reverse: reverse,
          scrollDirection: scrollDirection,
          itemBuilder: (ctx, index) {
            return buildItem(pageData![index], index)!;
          },
          itemCount: pageData?.length ?? 0,
        );
      case HYBaseListPageType.GRID:
        return GridView.builder(
          padding: listPadding,
          gridDelegate: gridViewDelegate(),
          controller: scrollController,
          itemBuilder: (ctx, index) {
            return buildItem(pageData![index], index)!;
          },
          scrollDirection: scrollDirection,
          reverse: reverse,
          itemCount: pageData?.length ?? 0,
        );
      case HYBaseListPageType.CUSTOM:
        return buildCustomList()!;
    }
  }

  /// 构建自定义list.如果是HYBaseListPageType.CUSTOM则必须实现
  Widget? buildCustomList() => null;

  Widget? buildItem(O entity, int index);

  /// 加载更多报错，点击底部tip提示操作
  void loadFailedTipOnTap() {
    beginLoadMore();
  }

  /// 开始刷新
  void beginRefresh() {
    refreshController?.requestRefresh();
  }

  /// 开始加载更多。
  void beginLoadMore() {
    refreshController?.requestLoading();
  }

  ///与GridView 同时出现
  SliverGridDelegate gridViewDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: dp10,
      mainAxisSpacing: dp10,
      childAspectRatio: 1 / 2,
    );
  }

  ///刷新回调
  void onRefresh() {}

  ///加载回调
  void onLoadMore() {}
}
