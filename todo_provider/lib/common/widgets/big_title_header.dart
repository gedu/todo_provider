import 'package:flutter/material.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/common/widgets/header_line_divider.dart';

class BigTitleHeader extends StatelessWidget {
  final String title;
  final bool autoFocus;
  final Color titleColor;
  final String tag;
  final ThemeProvider themeProvider;

  BigTitleHeader({
    this.title,
    this.autoFocus = false,
    this.titleColor,
    this.themeProvider,
    this.tag = "BigTitleHeader",
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = this.titleColor == null
        ? themeProvider.display3
        : themeProvider.display3.copyWith(color: titleColor);
    return Container(
      padding: const EdgeInsets.only(top: Base.bigPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Hero(
            tag: tag,
            child: Text(
              title,
              style: titleStyle,
            ),
          ),
          Container(height: Base.mediumPadding),
          HeaderLineDivider()
        ],
      ),
    );
  }
}
