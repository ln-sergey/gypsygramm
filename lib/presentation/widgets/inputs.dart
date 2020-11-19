import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gypsygramm/config/device_config.dart';

import '../../styles.dart';

class DefaultInput extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final Color hintColor;
  final void Function(String) onSubmitted;
  final bool enabled;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;

  DefaultInput(
      {Key key,
      @required this.controller,
      @required this.hint,
      this.hintColor,
      this.onSubmitted,
      this.enabled = true,
      this.maxLength,
      this.inputFormatters})
      : super(key: key);

  @override
  _DefaultInputState createState() => _DefaultInputState();
}

class _DefaultInputState extends State<DefaultInput> {
  var inputIsEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.text.isEmpty && !inputIsEmpty)
        setState(() {
          inputIsEmpty = false;
        });
      else if (widget.controller.text.isNotEmpty && inputIsEmpty)
        setState(() {
          inputIsEmpty = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          inputFormatters: widget.inputFormatters ?? [],
          maxLength: widget.maxLength,
          maxLengthEnforced: widget.maxLength == null ? false : true,
          controller: widget.controller,
          enabled: widget.enabled,
          style: title2,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: widget.hintColor == null
                  ? hint1
                  : hint1.apply(color: widget.hintColor),
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
      inputIsEmpty
          ? Expanded(
              flex: 0,
              child: GestureDetector(
                  onTap: () => widget.controller.clear(),
                  child: Icon(
                    Icons.cancel,
                    color: textColorDisabled,
                  )))
          : Container(),
    ]);
  }
}

class MessageInput extends StatelessWidget {
  final _controller = TextEditingController();
  final Function(String) onSubmit;
  final bool enabled;
  MessageInput(this.onSubmit, this.enabled, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Row(
        children: <Widget>[
          // Text input
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth / 40),
              child: TextField(
                style: title2,
                controller: _controller,
                onSubmitted: (value) => onSubmit(value),
                decoration: InputDecoration(
                  fillColor: primaryColorLight,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: primaryColorDark, width: 2),
                  ),
                  hintText: 'Message',
                  hintStyle: hint1,
                ),
              ),
            ),
          ),

          // Send Message Button
          Container(
            child: IconButton(
              icon: Icon(
                Icons.send,
                size: SizeConfig.screenWidth / 12,
              ),
              onPressed: enabled ? () {
                onSubmit(_controller.text);
                _controller.clear();
              } : () {},
              color: primaryColorLight,
            ),
          ),
        ],
      ),
    );
  }
}
