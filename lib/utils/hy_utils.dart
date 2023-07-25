import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:lpinyin/lpinyin.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_uitils
/// 工具类

/// model格式化，
typedef ModelBuilder<T> = T Function(dynamic value);

class HyUtils {
  /// 是否运用暗黑模式
  static bool _useWindowDart = false;
  static HyUtils? _instance;
  HyUtils._();

  /// 初始化，
  /// [useWindowDart] 是否运用暗黑模式
  static HyUtils? instance({
    bool? useWindowDart = true,
  }) {
    if (_instance == null) {
      _instance = HyUtils._();
      _useWindowDart = useWindowDart ?? false;
    }
  }

  /// 复制文字到剪切板
  static void copyData(String string) {
    ClipboardData data = new ClipboardData(text: string);
    Clipboard.setData(data);
  }

  /// 回收键盘
  static hideKeybaord() {
    // 触摸收起键盘
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// 是否暗黑模式
  /// 为了兼容不启用暗黑模式app。
  /// 如果需要启用则先调用初始化方法[instance]
  static bool isWindowDart() {
    if (!_useWindowDart) {
      return false;
    }
    Brightness hyBrightness = window.platformBrightness;
    return hyBrightness == Brightness.dark;
  }

  /// iOSstring转bool
  static bool iOSNSStringToBool(dynamic data) {
    if (data is String && Platform.isIOS) {
      return data == '0' ? false : true;
    } else if (data is bool) {
      return data;
    }
    return false;
  }

  /// string转pinyin
  static String stringToPinyin(String data) {
    return PinyinHelper.getPinyinE(data);
  }

  /// string转pinyin 首字母拼接（成都--cd）
  static String stringToPinyinSimpleFirst(String data) {
    return PinyinHelper.getShortPinyin(data);
  }

  /// jsonList数据转modelList
  /// [json] json 数据
  /// [ModelBuilder] model格式化，
  static List<T> jsonListToModelList<T>(
      dynamic json, ModelBuilder<T> modelBuilder) {
    List<T> list = [];
    if (json != null) {
      json.forEach((element) {
        list.add(modelBuilder(element));
      });
    }
    return list;
  }

  /// 文本是否超过最大行数
  ///
  /// [text] 文本
  /// [textStyle] 文本样式
  /// [maxLine] 最大行数
  /// [maxWidth] 最大宽度
  static bool textExceedMaxLines(
      String text, TextStyle textStyle, int maxLine, double maxWidth) {
    TextPainter textPainter =
        getTextPainter(text, textStyle, maxLine, maxWidth);
    if (textPainter.didExceedMaxLines) {
      return true;
    }
    return false;
  }

  /// 计算文本，返回[TextPainter]对象信息
  ///
  /// [text] 文本
  /// [textStyle] 文本样式
  /// [maxLine] 最大行数
  /// [maxWidth] 最大宽度
  static TextPainter getTextPainter(
      String? text, TextStyle textStyle, int maxLine, double maxWidth) {
    TextSpan textSpan = TextSpan(text: text, style: textStyle);
    TextPainter textPainter = TextPainter(
        text: textSpan, maxLines: maxLine, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: maxWidth);
    return textPainter;
  }

  /// Get返回到指定页面
  ///
  /// [page] 指定命名路由
  static void popUntilToName(String page) {
    Get.until((route) => Get.currentRoute == page);
  }
}

class HYColorUtils {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }
}
