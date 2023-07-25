import 'package:base_moudle/tools/enums.dart';
import 'package:base_moudle/tools/zs_color_extension.dart';
import 'package:base_moudle/widgets/zs_page_farmat.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

typedef DownItemTap<T> = void Function(T value);

class HYPageViewDownFilterBase extends StatefulWidget {
  String get arrorwDown => "packages/hy_flutter_utils/images/arrorw_down.png";
  VoidCallback? onRetry;

  PageStatus status;

  String? errMesage;

  Image? placeholdImage;
  final BoxDecoration? decoration;

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;

  ///所有的筛选项
  final List<GZXDropDownHeaderItem>? filterHeaderItems;
  final GZXDropdownMenuController? dropdownMenuController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _stackKey = GlobalKey();

  final DownItemTap? selectCallback;

  final List<GZXDropdownMenuBuilder>? filterMenuBuilders;

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

  HYPageViewDownFilterBase({
    this.status = PageStatus.normal,
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
    this.filterHeaderItems,
    this.onRetry,
    this.decoration,
    this.isShow = false,
    this.selectCallback,
    this.filterMenuBuilders,
    this.dropdownMenuController ,
  });

  @override
  State<StatefulWidget> createState() {
    return _HYPageViewDownFilterBaseState();
  }
}

class _HYPageViewDownFilterBaseState extends State<HYPageViewDownFilterBase> {
  int _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageViewBase(
      okey: widget._scaffoldKey,
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
      body: Stack(
        key: widget._stackKey,
        children: [
          Column(
            children: [
              widget.filterHeaderItems == null
                  ? Container()
                  : GZXDropDownHeader(
                      items: widget.filterHeaderItems!,
                      controller: widget.dropdownMenuController!,
                      stackKey: widget._scaffoldKey,
                      onItemTap: widget.selectCallback ??
                          (e) {
                            print(e);
                          },
                    ),
              Expanded(child: widget.body!)
            ],
          ),
          widget.filterMenuBuilders == null
              ? Container()
              : GZXDropDownMenu(
                  controller: widget.dropdownMenuController!,
                  menus: widget.filterMenuBuilders ?? [])
        ],
      ),
    );
  }
}
