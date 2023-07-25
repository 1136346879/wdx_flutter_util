import 'package:flutter/cupertino.dart';

class HYTextEditController extends TextEditingController {
  ///输入完成的文字
  var completeText = '';

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return super.buildTextSpan(
        context: context, withComposing: withComposing, style: style);
  }

  void updateText(String string) {
    if (text == string) return;
    text = string;
    // TextSelection.collapsed(offset: text.length);
    selection = TextSelection.fromPosition(
        TextPosition(affinity: TextAffinity.downstream, offset: string.length));
    // text = string;
  }
}
