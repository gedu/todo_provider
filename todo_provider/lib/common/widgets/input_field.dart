import 'package:flutter/material.dart';
import 'package:todo_provider/common/theme/styles.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final FormFieldValidator<String> validator;
  final InputDecoration decoration;
  final bool obscured;
  final bool enabled;
  final EdgeInsets padding;
  TextInputAction textInputAction;

  InputField({
    @required this.hint,
    textInputAction,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.validator,
    this.decoration,
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Base.mainHorizontalPadding,
    ),
    this.obscured = false,
  }) {
    if (nextFocusNode != null) {
      this.textInputAction = TextInputAction.next;
    } else {
      this.textInputAction = textInputAction;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              obscureText: obscured,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              validator: validator,
              enabled: enabled,
              onFieldSubmitted: (_) {
                if (nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(nextFocusNode);
                }
              },
              decoration: InputDecoration(
                hintText: hint,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                hintStyle: TextStyle(color: Colors.black38),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
