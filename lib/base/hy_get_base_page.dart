import 'dart:async';
import 'package:base_moudle/uitils/hy_log_util.dart';
import 'package:flutter/material.dart';

import '../hy_flutter_utils.dart';
import 'hy_base.dart';
import 'hy_base_page_controller.dart';

/// Created by wdx
/// on 2022/07/6
/// page xfs_get_base_page
/// 基于get库封装的basePage

abstract class HYGetBasePage extends StatefulWidget {

  HYGetBasePage({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => getState();

  HYGetBasePageState getState();

}

abstract class HYGetBasePageState <T extends HYGetBasePage, O extends Object, C extends HYBaseController> extends State<T>  with HYGetXBasePageUI<O?>, AutomaticKeepAliveClientMixin, HYStateUpdaterMixin{

  /// toast
  StreamSubscription? _toastStateSub;
  /// 自定义事件
  StreamSubscription? _customStateSub;
  /// 页面级的loading框
  StreamSubscription? _pageLoadStateSub;

  /// controller 的tag
  String? tag;

  VoidCallback? _remove;

  bool get autoRemove => true;

  /// 如果页面不需要controller则设置为false。因为如果为true的时候回自动在缓存里面查找，并放入缓存
  bool get useController => true;

  /// 控制器
  C? _c;
  C? get baseC => _c;

  /// 页面数据
  O? get pageData => _c?.pageData;

  /// 是否创建
  late bool _isCreator;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // 页面创建的时候调用一下 作为对外开放的生命周期方法
    super.initState();


    doInit();

    if (isUseScaffold){
      HYLogUtil.info('-----------------------进入页面${widget.runtimeType.toString()}-----------------------');
    }

    if (useController){

      final isPrepared = GetInstance().isPrepared<C>(tag: tag);
      final isRegistered = GetInstance().isRegistered<C>(tag: tag);

      if (isPrepared) {
        if (Get.smartManagement != SmartManagement.keepFactory) {
          _isCreator = true;
        }
        _c = GetInstance().find<C>(tag: tag);
      } else if (isRegistered) {
        _c = GetInstance().find<C>(tag: tag);
        _isCreator = false;
      } else {
        _c = initController();
        _isCreator = true;
        GetInstance().put<C>(_c!, tag: tag);
      }
      _subscribeToController();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return createWidget(context, _c?.pageData);
  }

  /// 监听通知
  void _subscribeToController(){

    _customStateSub = _c!.customState.listen((state) {
      if (state.state == -1){
        return;
      }
      showCustomState(state.state, state.data, state.data1);
    });

    _remove?.call();
    _remove = _c?.addListener(getUpdate);
  }

  /// 初始化控制器
  C? initController();

  @override
  void emptyViewAction() {
    _c?.emptyViewAction();
  }

  @override
  void errorViewAction() {
    _c?.errorViewAction();
  }

  @override
  buildChild(O? data) {
    return useController ? _c?.obx(
          (state) => super.buildChild( _c?.pageData),
      onError: (msg)=> buildErrorView(errorString: msg),
      onEmpty: buildEmptyView(),
      onLoading: buildProgressView(),
    ) : super.buildChild(data);
  }


  /// 自定义事件
  void showCustomState(dynamic state, dynamic data, dynamic data1){}

  @override
  void dispose() {

    super.dispose();

    if (isUseScaffold){
      HYLogUtil.info('-----------------------页面消失${widget.runtimeType.toString()}-----------------------');
    }

    bool isRegistered = GetInstance().isRegistered<C>(tag: tag);
    if (useController && _isCreator && autoRemove && isRegistered) {
      GetInstance().delete<C>(tag: tag);
    }

    if (_toastStateSub != null){
      _toastStateSub?.cancel();
      _toastStateSub = null;
    }

    if (_customStateSub != null){
      _customStateSub?.cancel();
      _customStateSub = null;
    }

    if (_pageLoadStateSub != null){
      _pageLoadStateSub?.cancel();
      _pageLoadStateSub = null;
    }

    _remove?.call();

    hyBasePageDispose();
  }

}