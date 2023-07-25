import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/define/hy_config.dart';
import 'package:hy_flutter_utils/utils/hy_px_density.dart';
import 'package:hy_flutter_utils/extension/hy_extension.dart';
import 'package:hy_flutter_utils/widgets/hy_text.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_page_state_view
/// 异常页面

class HYPageStateView extends StatelessWidget {

  /// 图片地址
  final String? imageAsset;
  /// 标题
  final String? title;
  /// 按钮标题
  final String? buttonTitle;
  /// 按钮背景颜色
  final Color? buttonBGColor;
  /// 按钮圆角
  final double? buttonRadius;
  /// 按钮宽
  final double? buttonWidth;
  /// 按钮高
  final double? buttonHeight;
  /// 按钮字体颜色
  final Color? buttonTextColor;
  /// 按钮字体大小
  final double? btnTitleFontSize;
  /// 背景颜色
  final Color backgroundColor;
  /// 标题字体大小
  final double? titileFontSize;
  /// 标题字体颜色
  final Color? titileTextColor;
  /// 图片地址
  final Function()? onTap;
  /// 决定主轴方向的尺寸
  final MainAxisSize? mainAxisSize;

  const HYPageStateView({
    Key? key,
    this.imageAsset,
    this.title,
    this.buttonTitle,
    this.buttonBGColor,
    this.buttonRadius,
    this.buttonTextColor,
    this.onTap,
    this.backgroundColor: Colors.white,
    this.buttonWidth,
    this.btnTitleFontSize,
    this.titileFontSize,
    this.titileTextColor,
    this.buttonHeight,
    this.mainAxisSize,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(imageAsset!, width: dp200, height: dp200,),
          ),
          HyText.container(title??"",
            fontSize: titileFontSize??sp15,
            textColor: titileTextColor??Config.color999999,
            margin: EdgeInsets.only(top: dp10, bottom: dp20),
            alignment: Alignment.center,
          ),
          buttonTitle.isNullOrEmpty() ? SizedBox(width: 0,) : HyText.container(buttonTitle??"",
            height: buttonHeight??dp30,
            width: buttonWidth??dp100,
            backgroudColor: buttonBGColor,
            textColor: buttonTextColor,
            fontSize: btnTitleFontSize,
            alignment: Alignment.center,
            borderRadius: buttonRadius.isNotNullOrEmpty() ? BorderRadius.circular(buttonRadius!) : null,
            border: Border.all(color: Config.colorCCCCCC),
            onTap: onTap,
            margin: EdgeInsets.only(top: dp110),
          )
        ],
      ),
    );
  }
}
