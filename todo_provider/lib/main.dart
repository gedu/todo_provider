import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/common/router/router.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';

import 'common/provider/provider_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return _app(themeProvider);
      }),
    );
  }

  Widget _app(ThemeProvider themeProvider) {
    return MaterialApp(
      title: 'Todo',
      showSemanticsDebugger: false,
      theme: themeProvider.mainTheme,
      onGenerateRoute: generateRoute,
      initialRoute: Routes.root,
    );
  }
}
