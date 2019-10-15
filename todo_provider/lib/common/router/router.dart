import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/authscreens/signin/sign_in_screen.dart';
import 'package:todo_provider/authscreens/signin/sign_in_view_model.dart';
import 'package:todo_provider/common/router/main_list_argument.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/detaillist/detail_list_screen.dart';
import 'package:todo_provider/detaillist/detail_list_view_model.dart';
import 'package:todo_provider/home/home_screen.dart';
import 'package:todo_provider/home/home_view_model.dart';

class Routes {
  static const root = "signIn";
  static const signIn = "signIn";
  static const home = "home";
  static const detailList = "detailList";
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.root:
      return _toSignInScreen();
    case Routes.home:
      return _toHome();
    case Routes.detailList:
      {
        final MainListArgument arguments = settings.arguments;
        return _toDetailList(arguments.title, arguments.index);
      }
    default:
      return _toSignInScreen();
  }
}

MaterialPageRoute _to(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}

MaterialPageRoute _toSignInScreen() {
  return _to(Consumer2<SignInViewModel, ThemeProvider>(
    builder: (context, viewModel, themeProvider, _) {
      return SignInScreen(viewModel, themeProvider);
    },
  ));
}

MaterialPageRoute _toHome() {
  return _to(Consumer2<HomeViewModel, ThemeProvider>(
    builder: (context, viewModel, themeProvider, _) {
      return HomeScreen(viewModel, themeProvider);
    },
  ));
}

MaterialPageRoute _toDetailList(String mainListTitle, int selectedListIndex) {
  return _to(Consumer2<DetailListViewModel, ThemeProvider>(
    builder: (context, viewModel, themeProvider, _) {
      return DetailListScreen(
          mainListTitle, selectedListIndex, viewModel, themeProvider);
    },
  ));
}
