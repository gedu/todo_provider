import 'package:flutter/material.dart';
import 'package:todo_provider/common/theme/styles.dart';

class HeaderLineDivider extends StatelessWidget {
  final double width;

  HeaderLineDivider({this.width = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: Base.standardPadding),
      height: 6,
      width: width,
      color: AppColors.mainAccentColor,
    );
  }
}
