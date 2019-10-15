import 'package:flutter/material.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';

class Button extends StatelessWidget {
  final ThemeProvider themeProvider;
  final VoidCallback onPress;
  final String title;

  Button({this.title, this.themeProvider, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: onPress,
            child: Text(
              title,
              style: themeProvider.title.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
