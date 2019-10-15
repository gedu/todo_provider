import 'package:flutter/material.dart';

class ScaffoldScreen extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Widget floatingActionButton;
  final bool resizeToAvoidBottomInset;

  ScaffoldScreen({
    this.child,
    this.backgroundColor,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
