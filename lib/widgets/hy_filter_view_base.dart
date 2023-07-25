import 'package:base_moudle/tools/enums.dart';
import 'package:base_moudle/tools/zs_color_extension.dart';
import 'package:base_moudle/tools/zs_widget_extension.dart';
import 'package:base_moudle/widgets/base_text.dart';
import 'package:base_moudle/widgets/zs_page_farmat.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hy_flutter_utils/define/hy_config.dart';

import 'hy_button.dart';
import 'hy_container.dart';
import 'hy_pop_filter_view.dart';

class HYPageViewFilterBase extends StatefulWidget {
  String get arrorwDown => "packages/hy_flutter_utils/images/arrorw_down.png";
  VoidCallback? onRetry;

  PageStatus status;

  String? errMesage;

  Image? placeholdImage;
  double? filterHeaderHeight;
  final BoxDecoration? decoration;

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;

  ///所有的筛选项
  final List<HYFilterViewItem>? filterViewItems;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  final List<Widget>? persistentFooterButtons;

  final Widget? drawer;

  final DrawerCallback? onDrawerChanged;

  final Widget? endDrawer;

  final DrawerCallback? onEndDrawerChanged;

  final Color? drawerScrimColor;

  final Color? backgroundColor;

  final Widget? bottomNavigationBar;

  final Widget? bottomSheet;

  final bool extendBody;

  final bool extendBodyBehindAppBar;

  final bool? resizeToAvoidBottomInset;

  final bool primary;

  final DragStartBehavior drawerDragStartBehavior;

  final double? drawerEdgeDragWidth;

  final bool drawerEnableOpenDragGesture;

  final bool endDrawerEnableOpenDragGesture;
  bool isShow;

  final String? restorationId;

  HYPageViewFilterBase(
      {this.status = PageStatus.normal,
      this.appBar,
      this.body,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator,
      this.persistentFooterButtons,
      this.drawer,
      this.onDrawerChanged,
      this.endDrawer,
      this.onEndDrawerChanged,
      this.bottomNavigationBar,
      this.bottomSheet,
      this.backgroundColor,
      this.resizeToAvoidBottomInset,
      this.primary = true,
      this.drawerDragStartBehavior = DragStartBehavior.start,
      this.extendBody = false,
      this.extendBodyBehindAppBar = false,
      this.drawerScrimColor,
      this.drawerEdgeDragWidth,
      this.drawerEnableOpenDragGesture = true,
      this.endDrawerEnableOpenDragGesture = true,
      this.restorationId,
      this.errMesage,
      this.placeholdImage,
      this.filterViewItems,
      this.onRetry,
      this.decoration,
      this.isShow = false,
      this.filterHeaderHeight = 44});

  @override
  State<StatefulWidget> createState() {
    return _HYPageViewFilterBaseState();
  }
}

class _HYPageViewFilterBaseState extends State<HYPageViewFilterBase> {
  int _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageViewBase(
      status: widget.status,
      errMesage: widget.errMesage,
      placeholdImage: widget.placeholdImage,
      onRetry: widget.onRetry,
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor ?? ColorHex('#F9F9F9'),
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      restorationId: widget.restorationId,
      body: Column(
        children: [
          widget.filterViewItems == null
              ? Container()
              : HYContainer(
                  backgroundColor: Colors.white,
                  height: widget.filterHeaderHeight,
                  border: Border(bottom: BorderSide(color: Config.colorEEEEEE, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: widget.filterViewItems!.map((HYFilterViewItem e) {
                      if (e.filterBody == null) {
                        return Flexible(
                          child: e.headerWidget ?? Container(),
                          flex: 3,
                        );
                      }
                      return TextButton(
                        style: e.buttonStyle,
                        onPressed: () {
                          if (!e.show) {
                            e.callback!();
                            widget.filterViewItems!.forEach((element) {
                              if (element != e) {
                                element.isSelect = false;
                              }
                            });
                            setState(() {
                              widget.isShow = e.isSelect && e.filterBody != null;
                            });
                          } else {
                            _filterIndex = widget.filterViewItems!.indexOf(e);
                            widget.filterViewItems!.forEach((element) {
                              if (element != e) {
                                element.isSelect = false;
                              }
                            });
                            e.isSelect = !e.isSelect;
                            setState(() {
                              widget.isShow = e.isSelect && e.filterBody != null;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            ZsText(e.itemName,color: Config.color333333,fontSize: 14,),
                            Image.asset(
                              widget.arrorwDown,
                              width: 12,
                              height: 12,
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
          Stack(
            children: [
              Container(
                child: widget.body!,
              ),
              _maskView(),
              _filterView()
            ],
          ).intoContainer(height: Get.height).intoExpanded()
        ],
      ),
    );
  }

  _filterView() {
    if (widget.isShow) {
      return widget.filterViewItems?[_filterIndex].filterBody ?? Container();
    } else {
      return Container();
    }
  }

  _maskView() {
    if (widget.isShow) {
      return Container(
        width: Get.width,
        color: Color(0x66333333),
      ).intoGestureDetector(
          onTap: () {
            setState(() {
              widget.isShow = !widget.isShow;
            });
          },
          behavior: HitTestBehavior.opaque);
    } else {
      return Container();
    }
  }
}

class HYFilterViewItem {
  String itemName;
  bool isSelect;
  bool show;
  HYPopFilterView? filterBody;
  Widget? headerWidget;
  ButtonStyle? buttonStyle;
  VoidCallback? callback;

  HYFilterViewItem(
      {this.itemName = '',
      this.isSelect = false,
      this.show = true,
      this.filterBody,
      this.buttonStyle,
      this.callback,
      this.headerWidget});
}
