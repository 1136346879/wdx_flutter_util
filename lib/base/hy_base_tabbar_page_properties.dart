import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/define/hy_config.dart';
import 'package:hy_flutter_utils/extension/hy_extension.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_base_tabbar_page_properties
/// desc

/// tabbar配置
class HYTabbarTheme{

  final Color backgroundColor;
  final EdgeInsetsGeometry indicatorPadding;
  final bool isScrollable;
  final EdgeInsetsGeometry tabbarPadding;
  final TabBarIndicatorSize indicatorSize;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final Color indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry? labelPadding;
  final Decoration? indicator;

  HYTabbarTheme({
    this.backgroundColor=Colors.white,
    this.isScrollable=false,
    this.indicatorPadding=const EdgeInsets.all(0),
    this.indicatorSize=TabBarIndicatorSize.label,
    this.labelColor=Config.color333333,
    this.unselectedLabelColor=Config.colorCCCCCC,
    this.labelStyle=const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    this.unselectedLabelStyle=const TextStyle(fontSize:14, fontWeight: FontWeight.bold),
    this.indicatorColor=Config.colorFF7D22,
    this.indicatorWeight=3,
    this.tabbarPadding=const EdgeInsets.only(bottom: 5),
    this.indicator,
    this.labelPadding
  });
}

mixin HYBaseTabbarPageProperties<O> {
  TabController? _tabController;
  TabController? get tabController => _tabController;

  PageController? _pageController;
  PageController? get pageController => _pageController;

  /// 初始化index
  int get initialIndex => 0;

  /// 当前index
  int? _currentTabIndex;
  int? get currentTabIndex => _currentTabIndex;

  /// tabbar相关配置
  HYTabbarTheme get theme => HYTabbarTheme();

  /// 是否使用pageview，false的话，tabbar对应的滚动页面是tabview，
  bool get usePageView => true;

  /// 自定义的标题，
  List get tabs;

  /// tabbar
  List<Widget> buildTabs();

  /// views
  List<Widget> buildTabViews();

  /// 滑动样式
  ScrollPhysics get configureScrollPhysics => ClampingScrollPhysics();

  /// 是否动态加载tabbar的数据
  bool isDynamic = false;

  /// 初始化controller, 在initState中调用
  void initTabController(TickerProvider vsync){
    if (!isDynamic){
      _tabController = TabController(length: buildTabs().length, vsync: vsync, initialIndex: initialIndex);
    }
    _pageController = PageController(initialPage: initialIndex);

  }

  /// 创建view
  Widget createTabbarView(){

    return tabView();
  }

  PreferredSizeWidget buildTabbar(){
    /// 动态加载tabbar
    if (isDynamic){
      if (tabs.isNullOrEmpty()){
        return PreferredSize(
          child: Container(),
          preferredSize: Size(0, 0),
        );
      }
      _tabController = buildTabbarController();
    }

    return TabBar(
      tabs: buildTabs(),
      controller: _tabController,
      labelPadding: theme.labelPadding,
      isScrollable: theme.isScrollable,
      indicatorSize: theme.indicatorSize,
      indicatorPadding: theme.indicatorPadding,
      labelColor: theme.labelColor,
      unselectedLabelColor: theme.unselectedLabelColor,
      labelStyle: theme.labelStyle,
      unselectedLabelStyle: theme.unselectedLabelStyle,
      indicatorColor: theme.indicatorColor,
      indicatorWeight: theme.indicatorWeight,
      onTap: (index){
        _currentTabIndex = index;
        _pageController!.jumpToPage(index);
        pageChange(index);
      },
    );

  }

  Widget tabView(){
    if (usePageView){
      return PageView(
        controller: _pageController,
        children: buildTabViews(),
        onPageChanged: (index){
          _currentTabIndex = index;
          _tabController!.animateTo(index);
          pageChange(index);
        },
        physics: configureScrollPhysics,
      );
    }
    return TabBarView(
      controller: _tabController,
      children: buildTabViews(),
      physics: configureScrollPhysics,
    );
  }

  /// 动态构建tabbarController
  /// [isDynamic] 为true时候必须实现
  TabController? buildTabbarController(){
    return null;
  }

  /// 页面切换
  void pageChange(int index){}

  void hyTabbarDispose(){
    _tabController!.dispose();
    _pageController!.dispose();
  }

}