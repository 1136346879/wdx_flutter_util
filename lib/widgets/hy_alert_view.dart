import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/hy_flutter_utils.dart';

/// Created by wdx
/// on 2022-7-20
/// page HYAlertViewTheme
/// AlertView提示框

class HYAlertViewTheme {
  /// 左侧按钮颜色
  Color? leftBtnColor;
  /// 左侧自提重量
  FontWeight? leftFontWeight;
  /// 右侧按钮颜色
  Color? rightBtnColor;
  /// 右侧按钮重量
  FontWeight? rightFontWeight;

  HYAlertViewTheme({
    this.leftBtnColor,
    this.leftFontWeight,
    this.rightBtnColor,
    this.rightFontWeight,
  });
}

class HYAlertView {

  /// alertView
  /// [title] 标题
  /// [content] 内容
  /// [content2] 内容2
  /// [leftBtnTitle] 左侧按钮标题 如果不传怎不显示左侧按钮
  /// [rightBtnTitle] 右侧按钮标题 如果不传则不显示右侧按钮
  /// [leftOnClick] 左侧按钮点击事件
  /// [rightOnClick] 右侧按钮点击事件
  /// [alertViewTheme] AlertView样式
  static show(
    BuildContext context, {
    String? title,
    String? content,
    String? content2,
    String? leftBtnTitle,
    String? rightBtnTitle,
    Function? leftOnClick,
    Function? rightOnClick,
    HYAlertViewTheme? alertViewTheme,
  }) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: Container(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: Colors.white,
                  scaffoldBackgroundColor: Colors.white,
                ),
                child: CupertinoAlertDialog(
                    title: title.isNullOrEmpty()
                        ? null
                        : Column(
                          children: [
                             HyText.normal(
                                  title ?? "",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                          ],
                        ),
                    content: Column(
                      children: [
                        HyText.container(
                          content ?? '',
                          alignment: Alignment.center,
                          textAlign: TextAlign.center,
                          padding: EdgeInsets.only(top: dp10),
                          fontSize: 12,
                        ),
                        HyText.container(
                          content2 ?? '',
                          alignment: Alignment.center,
                          textAlign: TextAlign.center,
                          padding: EdgeInsets.only(top: dp10),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      Row(
                        children: [
                          leftBtnTitle.isNotNullOrEmpty()
                              ? Expanded(
                                  child: HYContainer(
                                    backgroundColor:
                                        alertViewTheme?.leftBtnColor,
                                    alignment: Alignment.center,
                                    height: dp45,
                                    border: Border(
                                        top: BorderSide(
                                            color: Config.colorF5F5F5,
                                            width: 0.5)),
                                    child: HyText.normal(
                                      leftBtnTitle ?? "",
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      fontWeight: alertViewTheme?.leftFontWeight,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (leftOnClick != null) {
                                        leftOnClick();
                                      }
                                    },
                                  ),
                                )
                              : SizedBox(
                                  width: 0,
                                ),
                          rightBtnTitle.isNotNullOrEmpty()
                              ? Expanded(
                                  child: HYContainer(
                                    alignment: Alignment.center,
                                    height: dp45,
                                    backgroundColor:
                                        alertViewTheme?.rightBtnColor ??
                                            Config.colorFFA200,
                                    child: HyText.normal(
                                      rightBtnTitle ?? "",
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      textColor: Colors.white,
                                      fontWeight: alertViewTheme?.rightFontWeight,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (rightOnClick != null) {
                                        rightOnClick();
                                      }
                                    },
                                  ),
                                )
                              : SizedBox(
                                  width: 0,
                                ),
                        ],
                      )
                    ],
                  ),
              ),
            ),
          );
        });
  }
}
