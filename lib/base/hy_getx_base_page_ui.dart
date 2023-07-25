import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hy_flutter_utils/define/hy_config.dart';
import 'package:hy_flutter_utils/hy_flutter_utils.dart';
import 'package:hy_flutter_utils/utils/hy_px_density.dart';
import 'package:hy_flutter_utils/utils/hy_screen_utils.dart';
import 'package:hy_flutter_utils/widgets/hy_container.dart';
import 'package:hy_flutter_utils/widgets/hy_page_state_view.dart';
import 'package:hy_flutter_utils/widgets/hy_progress.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_base_page_properties
/// 纯UI

abstract class HYGetXBasePageUI<O>{

  /// 是否用到GlobalKey
  bool get isUseGlobalKey => false;

  /// 初始化方法 GlobalKey<ScaffoldState>(), 暂时在侧滑栏显示的时候用到
  GlobalKey<ScaffoldState>? _scaffoldKey = null;

  /// 页面数据
  final O? pageData = null;

  late BuildContext _baseContext;
  BuildContext get baseContext => _baseContext;

  /// 因为evenbus会多次订阅，之前订阅的不会消失，导致调用页面属性为null，所以得disposs时候手动取消，
  StreamSubscription? _eventbusSub;

  // 是否显示导航视图
  bool get isShowHeader => true;
  /// 是否使用嵌套时候不使用Scaffold,如果上一层是basePage，则下层设置为false，保证Scaffold只有一层
  bool get isUseScaffold => true;
  /// 是否使用安全区域
  bool get isUseSafeArea => false;
  /// 是否可以滑动返回
  bool get onWillPop => Navigator.canPop(_baseContext) ? true : false;
  /// 安全区域背景颜色
  Color get safeAreaBgColor => Colors.white;
  /// 导航背景色
  Color get navBarColor => Colors.cyan;
  /// 背景颜色
  Color get backgroundColor => Config.colorF5F5F5;
  /// appBar背景颜色
  Color get appBarBackgroundColor => Colors.white;

  /// 返回键色值
  Color get backButtonColor => Colors.black;

  /// appBar标题色值
  Color get appTextColor => Config.color333333;
  /// appBar标题字重
  FontWeight get appTextFontWeight => FontWeight.w600;
  /// 是否显示返回按钮
  bool get isShowBackButton => true;
  /// 标题名称
  String get naviTitle => '';
  /// 左侧按钮样式 暂时支持关闭和返回两种样式 如有别的样式 再加 true:返回 false: 关闭
  bool get isLeftBackStyle => true;
  /// 加载框文字
  String get pageProgressViewTitle => '';
  /// 加载框高。1：1
  double get pageProgressViewHeight => dp60;
  /// 空页面距离顶部
  double get emptyMarginTop => 0;
  /// 空页面距离顶部
  double get emptyPaddingTop => 0;
  /// 空页面背景颜色
  Color get emptyBackgroundColor => Colors.white;
  /// 空页面对齐方式
  Alignment get emptyAlignment => Alignment.center;
  /// 空数据页面提示
  String get emptyTitle => '矮油，这里空空如也~';
  /// 错误页面提示页面提示
  String get errorTitle => '没有网络';
  /// 没有数据显示的图片
  String get noDataPageImage => "assets/images/empty_data.png";
  /// 错误页面显示的图片
  String get errorPageImage => "packages/hy_flutter_utils/images/no_internet.png";
  /// 返回按钮图标
  String get backButtonImage => "packages/hy_flutter_utils/images/back_black.png";

  /// 空数据页面提示
  String get emptyBtnTitle => '';
  /// 错误页面提示页面提示
  String get errorBtnTitle => '重新加载';
  /// 页面
  EdgeInsetsGeometry? get padding => null;
  /// 页面
  EdgeInsetsGeometry? get margin => null;
  /// 自定义状态栏颜色
  SystemUiOverlayStyle? get systemOverlayStyle => null;
  /// 键盘弹出页面是否跟着滑动
  bool get resizeToAvoidBottomPadding => true;
  /// 返回按钮图片。默认是关闭
  IconData get backIcon => Icons.close;
  /// 导航栏titileView 水平间隔
  double get titleSpacing => 0;
  /// 顶部导航栏阴影，默认是1
  double get naviElevation => 1;
  /// 顶部导航栏阴影颜色
  Color? get naviShadowColor => null;
  /// 页面布局方向
  AlignmentGeometry? get pageAlignment => null;
  /// 导航是否可以返回，如果为true则表示有flutter导航存在
  bool get canPop => Navigator.canPop(_baseContext);
///是否自动关闭键盘
  bool get isAutoCloseCritical => true;

  /// The color to use for the scrim that obscures primary content while a drawer is open.
  ///
  /// If this is null, then [DrawerThemeData.scrimColor] is used. If that
  /// is also null, then it defaults to [Colors.black54].
  Color? get drawerScrimColor => null;

  /// {@template flutter.material.appbar.leadingWidth}
  /// Defines the width of [leading] widget.
  ///
  /// By default, the value of `leadingWidth` is 56.0.
  /// {@endtemplate}
  double? get leadingWidth => null;

  /// Determines if the [Scaffold.drawer] can be opened with a drag
  /// gesture.
  ///
  /// By default, the drag gesture is enabled.
  bool get drawerEnableOpenDragGesture => true;

  /// Determines if the [Scaffold.endDrawer] can be opened with a
  /// drag gesture.
  ///
  /// By default, the drag gesture is enabled.
  bool get endDrawerEnableOpenDragGesture => true;

  /// 初始化，在initState中调用，在initController之前调用，可以解析传参用
  void doInit(){}

  Widget createWidget(BuildContext context, O? data){
    _baseContext = context;

    /// 创建监听
    if (_eventbusSub == null){
      _eventbusSub = createEventbus();
    }

    if(isUseGlobalKey && _scaffoldKey == null){
      _scaffoldKey = GlobalKey<ScaffoldState>();
    }
    

    return isUseScaffold ? WillPopScope(
      child: Scaffold(
        drawer: initDrawer(),
        endDrawer: initEndDrawer(),
        drawerEnableOpenDragGesture:drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture:endDrawerEnableOpenDragGesture,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
        appBar: isShowHeader ? _buildHeader() : null,
        body: buildChild(data),
        backgroundColor: safeAreaBgColor,
        floatingActionButton: buildFloatingActionButton(),
        drawerScrimColor: drawerScrimColor,
      ),
      onWillPop: onWillPop ? null : () async{
        _backAction();
        return false;
      },
    ) : buildChild(data);

  }

  /// 构建页面
  buildChild(O? data){
    return _initView(data);
  }

  /// 初始化页面
  Widget _initView(O? data){
    return Listener(
      child: isUseSafeArea ? SafeArea(child: _buildContentView(data)) : _buildContentView(data),
      onPointerDown: (_){
        if(isAutoCloseCritical)
        viewOnPointerDown();
      },
      onPointerMove: (PointerMoveEvent event){
        viewonPointerMove(event);
      },
    );
  }

  /// 主视图
  Widget _buildContentView(O? data) {

    return Container(
      color: backgroundColor,
      child: Column(
        children: <Widget>[
          if (buildTopView(data) != null) buildTopView(data)!,
          Expanded(
            child: Container(
              alignment: pageAlignment??Alignment.topLeft,
              padding: padding,
              margin: margin,
              child: buildWidget(_baseContext, data),
            ),
          ),
          if (buildBottom(data) != null) buildBottom(data)!,
        ],
      ),
    );
  }

  /// 顶部导航栏
  _buildHeader() {
    return AppBar(
      title: buildAppBarTitleView()?? Text(naviTitle ,style: TextStyle(fontWeight: appTextFontWeight, fontSize: sp18,color: appTextColor),),
      centerTitle: true,
      elevation: naviElevation,
      titleSpacing: titleSpacing,
      shadowColor: naviShadowColor,
      leading: isShowBackButton ? buildAppBarLeading()??_backButton() : Container(),
      leadingWidth: leadingWidth,
      backgroundColor: appBarBackgroundColor,
      actions: actions(),
      systemOverlayStyle: systemOverlayStyle,
      bottom: buildAppBarBottomView(),
    );
  }

  /// 返回按钮
  Widget _backButton(){

    return IconButton(
      // highlightColor: Colors.transparent,
      // splashColor: Colors.transparent,
      icon: isLeftBackStyle ? Image.asset(backButtonImage, width: dp24, height: dp24,color: backButtonColor,) : Icon(backIcon,),
      onPressed: ()=> _backAction(),
    );
  }

  Widget buildProgressView(){
    return HYContainer(
      alignment: Alignment.topCenter,
      backgroundColor: emptyBackgroundColor,
      padding: EdgeInsets.only(top: HYScreenUtil.getScreenW(_baseContext) / 2 + pageProgressViewHeight / 2),
      child: buildLoadingView(),
    );
  }

  Widget buildEmptyView(){
    return HYContainer(
      height: double.infinity,
      alignment: emptyAlignment,
      backgroundColor: emptyBackgroundColor,
      margin: EdgeInsets.only(top: emptyMarginTop),
      padding: EdgeInsets.only(top: emptyPaddingTop),
      child: getNoDataPage(),
    );
  }

  Widget buildErrorView({String? errorString}){
    return HYContainer(
      height: double.infinity,
      alignment: emptyAlignment,
      backgroundColor: emptyBackgroundColor,
      margin: EdgeInsets.only(top: emptyMarginTop),
      padding: EdgeInsets.only(top: emptyPaddingTop),
      child: getBaseErrorPage(errorString: errorString),
    );
  }

  /// 创建通知
  StreamSubscription? createEventbus(){
    return null;
  }

  /// 创建导航栏左侧view
  Widget? buildAppBarLeading(){
    return null;
  }

  /// 创建导航栏title View
  Widget? buildAppBarTitleView(){
    return null;
  }

  /// 右侧按钮
  List<Widget>? actions() {
    return null;
  }

  /// 返回事件
  void _backAction() {
    // 判断是否有返回
    if (canPop) {
      Navigator.pop(_baseContext);
    } else {
      backAction();
    }
  }

  /// 默认返回按钮点击事件
  void backAction(){}

  /// 悬浮按钮
  Widget? buildFloatingActionButton() => null;

  /// 构建页面顶部view
  Widget? buildTopView(O? object) => null;

  /// 构建页面底部view
  Widget? buildBottom(O? object) => null;

  /// 加载框
  Widget buildLoadingView(){
    return HYLoadingView(
      title: pageProgressViewTitle,
      width: pageProgressViewHeight,
    );
  }

  /// 构建页面
  Widget buildWidget(BuildContext? context, O? object);

  /// 空页面按钮点击事件
  void emptyViewAction() {}

  /// 错误页面按钮点击事件
  void errorViewAction() {}

  /// 页面监听手指按下屏幕事件。
  void viewOnPointerDown(){
    FocusScopeNode currentFocus = FocusScope.of(baseContext);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      HyUtils.hideKeybaord();
    }
  }

  /// 页面监听滑动手势。
  void viewonPointerMove(PointerMoveEvent event){}

  /// 左侧弹出框
  Widget? initDrawer(){
    return null;
  }

  /// 右侧弹出框
  Widget? initEndDrawer(){
    return null;
  }

  /// 打开左侧弹出框
  void openDrawer(){
    if (initDrawer() != null){
      _scaffoldKey?.currentState?.openDrawer();
    }
  }

  /// 关闭弹出框
  void closeDrawer(){
    Navigator.pop(_baseContext);
  }

  /// 打开右侧弹出框
  void openEndDrawer(){
    if (initEndDrawer() != null){
      _scaffoldKey?.currentState?.openEndDrawer();
    }
  }

  // 错误页面
  Widget getBaseErrorPage({String? errorString}) {

    return HYPageStateView(
      imageAsset: errorPageImage,
      title: errorString??errorTitle,
      buttonRadius: dp3,
      buttonTitle: errorBtnTitle,
      buttonTextColor: Config.color333333,
      onTap: errorViewAction,
    );
  }

  // 无数据页面
  Widget getNoDataPage() {

    return HYPageStateView(
      imageAsset: noDataPageImage,
      title: emptyTitle,
      buttonRadius: dp3,
      buttonTitle: emptyBtnTitle,
      buttonTextColor: Config.color333333,
      onTap: emptyViewAction,
    );
  }

  // 自定义错误页面
  Widget getCustomErrorPage() {
    return Container();
  }

  /// 构建导航栏底部显示的view，可用于tabbar的显示等
  PreferredSizeWidget? buildAppBarBottomView() => null;

  // 显示loading
  void showLoading({String title='正在加载...'}) {
    HYProgress.show(_baseContext, title: title);
  }
  // 隐藏loading
  void hidenLoading() {
    HYProgress.hide(_baseContext);
  }

  /// 页面消失
  void hyBasePageDispose(){
    eventDispose();
  }

  /// 销毁event通知
  void eventDispose(){
    if (_eventbusSub != null){
      _eventbusSub?.cancel();
      _eventbusSub = null;
    }
  }
}
