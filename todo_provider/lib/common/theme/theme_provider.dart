import 'package:flutter/material.dart';
import 'package:todo_provider/common/theme/styles.dart';

class ThemeProvider {
  ThemeData mainTheme;
  TextStyle display3;
  TextStyle display1;
  TextStyle headline;
  TextStyle title;
  TextStyle body1;
  TextStyle body2;
  TextStyle subhead;
  TextStyle bodyError;

  ButtonThemeData secondaryButtonTheme;

  //todo: split in core functions
  ThemeProvider(BuildContext context) {
    final base = Theme.of(context);
    mainTheme = base.copyWith(
      brightness: Brightness.light,
      primaryColor: AppColors.mainAccentColor,
      accentColor: AppColors.mainAccentColor,
      backgroundColor: AppColors.mainBackgroundColor[500],
      scaffoldBackgroundColor: AppColors.mainBackgroundColor[500],
      canvasColor: AppColors.mainBackgroundColor[500],
      iconTheme: base.iconTheme.copyWith(
        color: Colors.white54,
      ),
      dialogBackgroundColor: AppColors.mainBackgroundColor[500],
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: Colors.black87,
        textTheme: ButtonTextTheme.accent,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      toggleableActiveColor: AppColors.mainAccentColor,
      unselectedWidgetColor: Colors.white54,
      textTheme: base.textTheme.copyWith(
        button:
            base.textTheme.button.copyWith(color: AppColors.mainAccentColor),
        display3: base.textTheme.display3.copyWith(color: Colors.black87),
        display1: base.textTheme.display1.copyWith(color: Colors.black87),
        title: base.textTheme.title.copyWith(color: Colors.black87),
        body1: base.textTheme.body1.copyWith(color: Colors.black87),
        body2: base.textTheme.body2.copyWith(color: Colors.black87),
        headline: base.textTheme.headline.copyWith(color: Colors.black87),
        overline: base.textTheme.overline.copyWith(color: Colors.black87),
        subhead: base.textTheme.subhead.copyWith(color: Colors.black87),
      ),
    );

    display3 = mainTheme.textTheme.display3;
    display1 = mainTheme.textTheme.display1;
    headline = mainTheme.textTheme.headline;
    title = mainTheme.textTheme.title;
    body1 = mainTheme.textTheme.body1;
    body2 = mainTheme.textTheme.body2;
    subhead = mainTheme.textTheme.subhead;
    bodyError = mainTheme.textTheme.body1.copyWith(color: Colors.red);
    secondaryButtonTheme = base.buttonTheme.copyWith(
      buttonColor: Colors.white70,
      textTheme: ButtonTextTheme.primary,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    );
  }
}
