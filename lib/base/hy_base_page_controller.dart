import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hy_flutter_utils/widgets/hy_progress.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../hy_flutter_utils.dart';
import 'hy_base.dart';
import 'hy_base_entity.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_base_page_controller
/// desc
///
/// 目前页面有两个loading弹出方式，
/// 1：页面状态[RxStatus.loading()],这种是直接在当前页面显示，相当于当前页面的ui，可以进行别的点击，手势操作等，
/// 2：弹出的loading框[showLoading]，这种是弹出框，不可以进行手势，点击操作。
///    注意：如果进入页面需要显示这个样式，则需要使用[showInitLoading]这个属性去控制，进入页面以后调用没有这个限制，

abstract class HYBaseController<T> extends GetxController with ShowCustomState, StateMixin{

  /// 页面数据
  T? _data;
  T? get pageData => _data;
  set pageData (T? data){
    _data =  data;
  }
  

  /// 是否初始化显示页面级弹框，
  ///
  /// 因为网络请求开始的时候页面没有渲染完成，所以调用loading框的时候会报错。
  /// showloding必须在页面渲染完成以后调用，也就是onReady中，
  /// 为了避免跟不显示页面loading时候调用网络请求发送冲突，
  /// 所以第一进页面需要显示弹框loading而不是页面的loading状态，用这个属性，
  /// 不需要主动调用[showLoading]方法，
  bool get showInitLoading => false;

  void showEmptyView({EmptyViewType? type, BaseEntity? baseEntity}) {
    if (_data.isNotNullOrEmpty()){
      return;
    }

    if (type == null){

      if (baseEntity?.xfsCode != '0'){
        type = EmptyViewType.ERROR;
      } else {
        type = EmptyViewType.EMPTY;
      }
    }

    switch (type){
      case EmptyViewType.ERROR:
        change(pageData, status: RxStatus.error(baseEntity?.message));
        break;
      case EmptyViewType.EMPTY:
        change(pageData, status: RxStatus.empty());
        break;
      case EmptyViewType.CUSTOM:
        change(pageData, status: RxStatus.empty());
        break;
    }
  }

  void showToast(String toast){}

  /// 显示弹出的loading框
  ///
  /// 注：如果是进页面时候需要显示这个loading框，则使用[showInitLoading]属性。
  ///    只有第一次进入页面调用[showLoading]需要设置这个属性，其他情况还是直接调用方法
  ///
  /// [barrierDismissible] 是否点击取消
  /// [msg] 提示信息
  /// [size] 提示框大小
  void showLoading({bool barrierDismissible = false, String? msg, double size=60}){
    if (Get.isOverlaysClosed){
      Get.dialog(HYLoadingView(title: msg, width: size,), barrierColor: Colors.transparent, barrierDismissible: barrierDismissible);
    }
  }

  /// 隐藏loading
  void hideLoading(){
    if(Get.isOverlaysOpen){
      Get.back();
    }
  }

  @override
  void onInit() {
    super.onInit();

    change(null, status: initStatus);

    onLoadingRequest();
  }


  @override
  void onReady() {
    if (showInitLoading){
      showLoading();
    }
  }

  /// 初始化状态
  RxStatus get initStatus => RxStatus.loading();

  /// 加载网络请求
 void onLoadingRequest();

  void emptyViewAction(){
    change(_data, status: RxStatus.loading());
    onLoadingRequest();
  }

  void errorViewAction(){
    change(_data, status: RxStatus.loading());
    onLoadingRequest();
  }
}

abstract class HYBasePageController<T> extends HYBaseController<T>{

  /// 显示页面
  void showData(T data){
    _data = data;

    change(_data, status: RxStatus.success());
  }
}

abstract class HYBaseListPageController<T> extends HYBaseController<T> {

  HYPageModel? _pageModel;
  HYPageModel? get pageModel => _pageModel;

  @override
  RxStatus get initStatus => RxStatus.success();

  /// 自动刷新
  bool get autoRefresh => true;

  /// 初始化页码
  int initPageNumber = 1;

  /// 页码
  late int _pageNumber;

  int get pageNumber => _pageNumber;
  set pageNumber (int page){
    _pageNumber = page;
  }

  RefreshController? refreshController;
  /// 滑动控制器
  ScrollController? scrollController;

  /// 是否显示滚动到顶部
  RxBool showScrollTop = false.obs;

  /// 滚动偏移量
  double get showScrollTopOffset => 200;

  @override
  void onInit() {
    _pageNumber = initPageNumber;
    refreshController = RefreshController(initialRefresh: autoRefresh, initialLoadStatus: LoadStatus.noMore);
    /// 滑动控制器
    scrollController = ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.offset > 200){
        showScrollTopView(true);
      } else {
        showScrollTopView(false);
      }
    });

    super.onInit();
  }

  /// 显示跳转顶部view
  void showScrollTopView(bool show){
    if (show){
      // 如果按钮不显示时候去显示
      if (!showScrollTop.value){
        showScrollTop.value = true;
      }
    } else {
      // 如果按钮显示时候去隐藏
      if (showScrollTop.value){
        showScrollTop.value = false;
      }
    }

  }

  /// 跳转到指定位置
  void jumpTo(double value){
    scrollController!.jumpTo(value);

  }

  /// 跳转到指定位置，有动画效果的
  void animateTo(
      double offset, {
        Duration duration = const Duration(milliseconds: 500),
        Curve curve = Curves.ease,
      }){
    scrollController!.animateTo(offset, duration: duration, curve: curve);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController?.dispose();
    scrollController?.dispose();
  }

  @override
  void errorViewAction() {
    beginRefrsh();
  }

  @override
  void emptyViewAction() {
    beginRefrsh();
  }

  void showData(T data) {

    _data = data;
    /// 如果数据为空就显示空页面
    if (data.isNullOrEmpty()){
      showEmptyView(type: EmptyViewType.EMPTY);
    }else{
      change(_data, status: RxStatus.success());
    }
  }

  /// 刷新
  @protected
  @mustCallSuper
  void onRefresh(){
    _pageNumber = initPageNumber;
    showScrollTopView(false);
    getUrlData(true);
  }

  /// 加载更多
  @protected
  @mustCallSuper
  void onLoadMore(){
    _pageNumber++;
    getUrlData(false);
  }
  
  /// 获取网络请求数据
  /// 
  /// [isRefresh] 是否刷新
  /// [showProgress] 是否显示加载框
  void getUrlData(bool isRefresh,{bool showProgress = false}){}
  
  /// 开始刷新,下拉动画
  void beginRefrsh(){
    _pageNumber = initPageNumber;
    if (!status.isSuccess){
      change(_data, status: RxStatus.success());
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshController?.requestRefresh();
    });
  }

  /// 开始加载更多。
  void beginLoadmore(){
    refreshController?.requestLoading();
  }

  /// 结束请求刷新控件的调用, 过期方法, 建议调用[refreshFinishNew]
  ///
  /// [isRefresh] 是否刷新
  /// [hasMore] 是否有更多
  /// [isSuccess] 是否成功
  @deprecated
  void refreshFinish(bool isRefresh, bool hasMore, {required bool isSuccess}){
    /// 如果失败，并且是加载更多的时候，pageNumber需要在减去1
    if (!isRefresh && !isSuccess && _pageNumber > initPageNumber){
      _pageNumber--;
    }
    _configureRefreshPageWithState(isRefresh, hasMore);
  }

  /// 结束请求刷新控件的调用,
  ///
  /// [isRefresh] 是否刷新
  /// [pageModel] 分页信息，如果是成功的时候为必传参数
  void refreshFinishNew(bool isRefresh, {HYPageModel? pageModel}){
    if (pageModel != null){
      _pageModel = pageModel;
    }
    _pageNumber = _pageModel?.pageNumber??initPageNumber;
    _configureRefreshPageWithState(isRefresh, _pageModel?.hasNext??false);
  }

  /// 控制下拉刷新状态以及页面展示
  /// [isRefresh] 是否刷新
  /// [hasNext] 是否有更多
  void _configureRefreshPageWithState(bool isRefresh, bool hasNext) {
    if (isRefresh) {
      refreshController?.refreshCompleted(resetFooterState: hasNext);
      if (!hasNext){
        refreshController?.loadNoData();
      }
    } else {
      if (hasNext) {
        refreshController?.loadComplete();
      } else {
        refreshController?.loadNoData();

      }
    }
  }

  @override
  void onLoadingRequest() {}

}

/// 显示自定义状态,
mixin ShowCustomState{

  int _count = 0;
  /// 自定义状态显示。基类监听，不需要自己处理
  Rx<CustomState> customState = CustomState().obs;

  /// 显示自定义的事件,需要自定义事件或者传参数，用这个方法
  /// *注 只有StatefulWidget的base用到。StatelessWidget不用这个方法，直接在controller
  ///
  /// [state] 事件类型。
  /// [data] 参数
  /// [data1] 参数
  void showCustomState({dynamic state, dynamic data, dynamic data1}){
    _count++;
    customState.update((val) {
      val!.count = _count;
      val.state = state;
      val.data = data;
      val.data1 = data1;
    });
  }
}

/// 空页面状态
class BaseEmptyState {

  bool showEmpty;
  EmptyViewType type;

  BaseEmptyState({this.showEmpty=false, this.type=EmptyViewType.EMPTY});
}

/// 自定义事件
class CustomState {

  dynamic state;
  dynamic data;
  dynamic data1;
  int count;

  CustomState({this.state, this.data, this.data1, this.count=0});
}