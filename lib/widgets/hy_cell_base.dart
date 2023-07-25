import 'package:base_moudle/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/hy_text_editing_controller.dart';

class HYSelectCell extends StatefulWidget {
  String? title;
  bool? necessary;
  bool? hidden;
  bool? orientation;
  WidgetBuilder? valueWidgetBuilder;

  HYSelectCell(
      {required this.title,
      this.necessary = false,
      this.hidden = false,
      this.orientation = true,
      required this.valueWidgetBuilder});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectCellState();
  }
}

class _SelectCellState extends State<HYSelectCell> {
  @override
  Widget build(BuildContext context) {
    if (widget.hidden == true) return Container();
    return widget.orientation??true?Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(),
        widget.valueWidgetBuilder!(context)
            .intoContainer(margin: const EdgeInsets.only(left: 20))
            .intoFlexible(flex: 3)
      ],
    ).intoContainer(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
        color: Colors.white):
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget(),
        widget.valueWidgetBuilder!(context)
            .intoContainer(margin: const EdgeInsets.only(top: 10))
      ],
    ).intoContainer(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
    color: Colors.white);
  }

  //标题
  RichText _titleWidget() {
    return RichText(
        text: TextSpan(children: [
      if (widget.necessary!)
        const TextSpan(
            text: '* ',
            style: TextStyle(
                color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold))
      else
        const TextSpan(
          text: '',
        ),
      TextSpan(
          text: '${widget.title}',
          style: TextStyle(
              color: zs_black_666, fontSize: 14, fontWeight: FontWeight.bold))
    ]));
  }
}

typedef InputCallback = Function(String text);

class HYInputEditWidget extends StatefulWidget {
  String? value;
  String? placeholder;
  InputCallback? callback;
  InputCallback? onSubmitted;
  Color? color = zs_black_666;
  Color? backColor = zs_black_999;
  double? fontSize;
  TextInputType? keyboardType;
  int? maxLines;
  int? minLines;
  List<TextInputFormatter>? inputFormatters;
  FocusNode? focusNode;
  bool autofocus;

  HYInputEditWidget({
    this.value,
    this.placeholder,
    required this.callback,
    this.color,
    this.backColor,
    this.fontSize = 14,
    this.keyboardType = TextInputType.text,
    this.maxLines = 10,
    this.minLines = 2,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = true,
    this.onSubmitted,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputWidgetState();
  }
}

class _InputWidgetState extends State<HYInputEditWidget> {
  late HYTextEditController _textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = HYTextEditController();
    // _textEditingController.addListener(() {
    //   if (widget.value != _textEditingController.text)
    //     widget.callback!(_textEditingController.text);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: TextField(
        controller: _textEditingController..updateText(widget.value ?? ''),
        keyboardType: widget.keyboardType,
        cursorColor: zs_mainColor,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        style: TextStyle(
            color: widget.color, fontSize: widget.fontSize, height: 1.5),
        onChanged: (str) {
          if (widget.callback != null) {
            widget.callback!(str);
          }
        },
        onSubmitted: (str) {
          if (widget.onSubmitted != null) {
            widget.onSubmitted!(str);
          }
        },
        decoration: InputDecoration.collapsed(
            hintText: widget.placeholder ?? '请输入',
            hintStyle:
                TextStyle(color: widget.backColor, fontSize: widget.fontSize)),
      ),
    );
  }
}

class HYSelectWidget extends StatelessWidget {
  String? value;
  String? placeholder;
  VoidCallback? onTap;
  MainAxisAlignment? mainAxisAlignment;
  bool? showArrow;

  HYSelectWidget({this.placeholder, this.value, this.mainAxisAlignment,this.showArrow, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment?? MainAxisAlignment.end,
      children: [
        Flexible(
          flex: 3,
          child: value != null && value != ''
              ? ZsText(
                  value!,
                  color: zs_black_666,
                )
              : ZsText(
                  placeholder!,
                  color: zs_black_999,
                ),
        ),
        Visibility(
          visible: showArrow??true,
          child: Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 16,
            color: zs_black_999,
          ),
        )
      ],
    ).intoGestureDetector(onTap: onTap);
  }
}
