import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/base/hy_getx_base_page_ui.dart';
import 'package:hy_flutter_utils/base/hy_refresh_view.dart';
import 'package:hy_flutter_utils/define/hy_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../hy_flutter_utils.dart';
import 'hy_base_page_controller.dart';
import 'hy_getx_base_list_page_ui.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_getx_base_page
/// desc 基于getx框架的basepage页面

/// 无状态页面，没有controller，用于纯展示的页面
// ignore: must_be_immutable
abstract class HYStatelessWidget<O> extends StatelessWidget
    with HYGetXBasePageUI<O> {
  @override
  Widget build(BuildContext context) {
    return createWidget(context, pageData);
  }
}

/// 扩展，新增list页面的监听，可以使空页面的时候有下拉刷新的功能
extension HYListStateExt<T> on StateMixin<T> {
  Widget listObx(
    NotifierBuilder<T?> widget, {
    RefreshController? refreshController,
    VoidCallback? onLoadMore,
    VoidCallback? onRefresh,
    bool hasLoadMore = true,
    bool hasRefresh = true,
    Function()? loadfailedOnTap,
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
  }) {
    return SimpleBuilder(builder: (_) {
      Widget child = widget(value);
      Widget? noMoreWidget;

      if (status.isLoading) {
        child = onLoading ?? const Center(child: CircularProgressIndicator());
      } else if (status.isError) {
        child = onError != null
            ? onError(status.errorMessage)
            : Center(child: Text('A error occurred: ${status.errorMessage}'));
      } else if (status.isEmpty) {
        child = onEmpty != null
            ? onEmpty
            : SizedBox.shrink(); // Also can be widget(null); but is risky
      }

      // ignore: invalid_use_of_protected_member
      if (value.isNullOrEmpty()) {
        /// 如果是空数据的时候，没有更多数据不显示，
        noMoreWidget = hyZeroWidget;
      }

      return HYRefreshView(
        listView: child,
        refreshController: refreshController,
        onLoading: onLoadMore,
        onRefresh: onRefresh,
        enableLoading: hasLoadMore,
        enableRefresh: hasRefresh,
        loadfailedOnTap: () => loadfailedOnTap,
        noMoreWidget: noMoreWidget,
      );
    });
  }
}

/// getx基类，basepage的ui
// ignore: must_be_immutable
abstract class HYGetView<T extends HYBaseController, O> extends StatelessWidget
    with HYGetXBasePageUI<O> {
  HYGetView({Key? key}) : super(key: key);

  /// tag
  final String? getxControllerTag = null;

  /// 如果页面不需要controller则设置为false。因为如果为true的时候回自动在缓存里面查找，并放入缓存
  final bool useController = true;

  T get controller => GetInstance().find<T>(tag: getxControllerTag);

  @override
  O? get pageData => controller.pageData;

  @override
  Widget build(BuildContext context) {
    doInit();

    return createWidget(context, useController ? controller.pageData : null);
  }

  @override
  void emptyViewAction() {
    controller.emptyViewAction();
  }

  @override
  void errorViewAction() {
    controller.errorViewAction();
  }
}

/// 无状态basepage
// ignore: must_be_immutable
abstract class HYGetXStatelessBasePage<T extends HYBaseController, O>
    extends HYGetView<T, O> with HYGetXPageMin<T, O> {}

/// listView 混入 HYGetXBaseListPageUI,
// ignore: must_be_immutable
abstract class _HYGetXStatelessListPage<T extends HYBaseListPageController, O>
    extends HYGetView<T, List<O>> with HYGetXBaseListPageUI<O> {}

// ignore: must_be_immutable
abstract class HYGetXStatelessBaseListPage<T extends HYBaseListPageController,
    O> extends _HYGetXStatelessListPage<T, O> with HYGetXListPageMin<T, O> {
  @override
  buildWidget(BuildContext? context, List<O>? object) {
    return buildListChild(object);
  }
}

/// basePage get混入
mixin HYGetXPageMin<T extends HYBaseController, O> on HYGetView<T, O> {
  @override
  buildChild(data) {
    return useController
        ? controller.obx(
            (state) => super.buildChild(controller.pageData),
            onError: (msg) => buildErrorView(errorString: msg),
            onEmpty: buildEmptyView(),
            onLoading: buildProgressView(),
          )
        : super.buildChild(data);
  }
}

/// 列表getx混入
mixin HYGetXListPageMin<T extends HYBaseListPageController, O>
    on _HYGetXStatelessListPage<T, O> {
  @override
  Widget buildListChild(List? data) {
    return useController
        ? _buildControllerWidget()
        : super.buildListChild(null);
  }

  Widget _buildControllerWidget() {
    return Container(
        child: hasRefreshView
            ? controller.listObx(
                (state) => super.buildListChild(controller.pageData),
                onRefresh: onRefresh,
                onLoadMore: onLoadMore,
                hasRefresh: hasRefresh,
                hasLoadMore: hasLoadMore,
                loadfailedOnTap: loadFailedTipOnTap,
                onError: (msg) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    child: buildErrorView(errorString: msg),
                  ),
                ),
                onEmpty: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    child: buildEmptyView(),
                  ),
                ),
                onLoading: buildProgressView(),
                refreshController: controller.refreshController,
              )
            : controller.obx(
                (state) => super.buildListChild(controller.pageData),
                onError: (msg) => buildErrorView(errorString: msg),
                onEmpty: buildEmptyView(),
                onLoading: buildProgressView(),
              ));
  }

  @override
  int? get pageNumber => controller.pageNumber;

  @override
  ScrollController? get scrollController => controller.scrollController;

  @override
  void onRefresh() {
    // ignore: invalid_use_of_protected_member
    controller.onRefresh();
  }

  @override
  void onLoadMore() {
    // ignore: invalid_use_of_protected_member
    controller.onLoadMore();
  }
}
