import 'package:flutter/material.dart';

import 'hy_base_page_controller.dart';
import 'hy_base_tabbar_page_properties.dart';
import 'hy_get_base_page.dart';

/// Created by wdx
/// on 2022/7/6
/// page xfs_get_base_tabbar_page
/// tabbar基类

abstract class HYGetBaseTabbarPage extends HYGetBasePage{

  HYGetBaseTabbarPage({Key? key}): super(key: key);

  @override
  HYGetBaseTabbarPageState createState() => getState();

  /// 子类实现
  HYGetBaseTabbarPageState getState();

}
abstract class HYGetBaseTabbarPageState<T extends HYGetBaseTabbarPage, O extends Object, C extends HYBaseController> extends HYGetBasePageState<T, O, C> with SingleTickerProviderStateMixin, HYBaseTabbarPageProperties{



  @override
  bool get useController => false;

  @override
  void initState() {

    super.initState();
    
    initTabController(this);

    doInit();
  }

  @override
  Widget buildWidget(BuildContext? context, O? object) {
    return createTabbarView();
  }

  @override
  PreferredSizeWidget buildAppBarBottomView() {
    return buildTabbar();
  }


  @override
  void dispose() {
    super.dispose();

    hyTabbarDispose();
  }
}

