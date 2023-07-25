import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hy_flutter_utils/utils/hy_utils.dart';

/// Created by wdx
/// on 2022/6/14
/// page hy_config
/// desc 配置

/// 空白视图
Widget hyZeroWidget = SizedBox(height: 0,);

class Config{

  static const Color colorFFA200 = Color(0xFFFFA200);
  static const Color color0DFFA200 = Color(0x0DFFA200);
  static const Color colorF2F2F2 = Color(0xFFF2F2F2);
  static const Color color666666 = Color(0xFF666666);
  static const Color color21666666 = Color(0x21666666);
  static const Color colorF4F4F4 = Color(0xFFF4F4F4);
  static const Color colorF6F6F6 = Color(0xFFF6F6F6);
  static const Color color333333 = Color(0xFF333333);
  static const Color color222222 = Color(0xFF222222);
  static const Color color999999 = Color(0xFF999999);
  static const Color colorFF7D22 = Color(0xFFFF7D22);
  static const Color color888888 = Color(0xFF888888);
  static const Color colorDDDDDD = Color(0xFFDDDDDD);
  static const Color colorD6D6D6 = Color(0xFFD6D6D6);
  static const Color colorD3D3D3 = Color(0xFFD3D3D3);
  static const Color colorD7D7D7 = Color(0xFFD7D7D7);
  static const Color colorF5F5F5 = Color(0XFFF5F5F5);
  static const Color colorFF8F1F = Color(0XFFFF8F1F);
  static const Color colorFFECE3 = Color(0XFFFFECE3);
  static const Color colorFF6010 = Color(0XFFFF6010);
  static const Color colorEFEFEF = Color(0XFFEFEFEF);
  static const Color colorEEEEEE = Color(0XFFEEEEEE);
  static const Color colorA8A8A8 = Color(0XFFA8A8A8);
  static const Color colorC6C6C6 = Color(0XFFC6C6C6);
  static const Color colorB2B22B2 = Color(0xFFB2B2B2);
  static const Color colorFFF9ED = Color(0xFFFFF9ED);
  static const Color colorFFEFDF = Color(0xFFFFEFDF);
  static const Color colorE5E5E5 = Color(0xFFE5E5E5);
  static const Color colorE8E8E8 = Color(0xFFE8E8E8);
  static const Color colorF9F9F9 = Color(0xFFF9F9F9);
  static const Color colorF6AB00 = Color(0xFFF6AB00);
  static const Color colorFF3B30 = Color(0xFFFF3B30);
  static const Color colorFF0010 = Color(0xFFFF0010);
  static const Color colorFAFAFA = Color(0xFFFAFAFA);
  static const Color color8F8F94 = Color(0xFF8f8f94);
  static const Color colorEFEFF4 = Color(0xFFefeff4);
  static const Color colorBBBBBB = Color(0xFFbbbbbb);
  static const Color colorC8C7CC = Color(0xFFc8c7cc);
  static const Color colorCCCCCC = Color(0xFFcccccc);
  static const Color colorE7E7E7 = Color(0xFFE7E7E7);
  static const Color color2E3034 = Color(0xFF2E3034);
  static const Color colorfdf2e9 = Color(0xFFfdf2e9);
  static const Color colorf1f1f1 = Color(0xFFf1f1f1);
  static const Color color18191A = Color(0xFF18191A);
  static const Color color2391EA = Color(0xFF2391EA);
  static const Color color34C759 = Color(0xFF34C759);
  static const Color color007AFF = Color(0xFF007AFF);
  static const Color colorECECEC = Color(0xFFECECEC);
  static const Color color207EFA = Color(0xFF207EFA);
  static const Color color1B63EB = Color(0xFF1B63EB);
  static const Color color0D1B63EB = Color(0x0D1B63EB);
  static const Color colorFFFFFF = Color(0xFFFFFFFF);
  static const Color color63D372 = Color(0xFF63D372);
  static const Color colorFF5252 = Color(0xFFFF5252);
  static const Color colorF7F6F9 = Color(0xFFF7F6F9);
}

/// 设置颜色
Color hyColor({required Color light, Color? dark}) {

  return HyUtils.isWindowDart() ? dark??light : light;
}

/// 抽象类。获取标题
abstract class HYTitle{
 String getTitle();
 /// 是否选中
 bool? isSelected;
}

/// 抽象类。
mixin HYSelected{
  /// 是否选中
  bool? isSelected;
}