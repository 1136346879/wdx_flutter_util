import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hy_flutter_utils/extension/hy_extension.dart';
import 'package:hy_flutter_utils/utils/hy_px_density.dart';
import 'package:hy_flutter_utils/utils/hy_utils.dart';

/// 加载提示框
class HYProgress{

  static bool _isShowing = false;

  static void show(BuildContext context, {String? title}) {
    if (!_isShowing) {
      _isShowing = true;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return LoadingDialog(
              text: title,
              width: dp100,
            );
          }
      );

    }
  }

  static void hide(BuildContext? context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context!).pop();
    }
  }

  /// 展示
  static void showLoading(context, {
    String? title
  }) {
    if(!_isShowing) {
      _isShowing = true;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return LoadingDialog(
              text: title,
            );
          }
      );
    }
  }

  /// 隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}

class HYLoadingView extends StatelessWidget {

  /// 宽
  final double width;
  /// 标题
  final String? title;
  /// 背景颜色
  final Color? color;
  /// 标题字颜色
  final Color? textColor;

  const HYLoadingView({
    Key? key,
    this.width = 100,
    this.title,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: width,
        height: width,
        decoration: ShapeDecoration(
          color: color??Color(0xFF333333,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _loadingWidget(),
            title.isNullOrEmpty()
                ? SizedBox(width: 0,)
                : Padding(
              padding: EdgeInsets.only(top: dp10),
              child: Text(
                title ?? "",
                style: TextStyle(
                    fontSize: sp12,
                    color: textColor??Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget(){
    return SizedBox(
        width: width*0.3,
        height: width*0.3,
        child: Theme(
          data: ThemeData(
            cupertinoOverrideTheme: CupertinoThemeData(
              brightness: HyUtils.isWindowDart() ? Brightness.light : Brightness.dark,
            ),
          ),
          child: CupertinoActivityIndicator(
            radius: dp15,
          ),
        ),
    );
  }

}


class LoadingDialog extends Dialog {
  final Function()? onTap;
  final String? text;
  const LoadingDialog({
    Key? key,
    this.text,
    this.onTap,
    this.width = 80,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        type: MaterialType.canvas,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: HYLoadingView(width: width, title: text,),
          ),
        ),
      ),
      onWillPop: ()async{
        return false;
      },
    );
  }


}