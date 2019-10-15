import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/common/widgets/selectablebutton/selectable_button_controller.dart';

typedef OnCheckState = void Function(String title, bool cheked);

class BorderSelectableButton extends StatefulWidget {
  final ThemeProvider themeProvider;
  final String title;
  final OnCheckState onCheck;

  BorderSelectableButton({
    this.title,
    this.themeProvider,
    this.onCheck,
  });

  @override
  _BorderSelectableButtonState createState() => _BorderSelectableButtonState();
}

class _BorderSelectableButtonState extends State<BorderSelectableButton> {
  SelectableButtonController _controller;
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectableButtonController>(
        builder: (context, controller, _) {
      _controller = controller;
      return Container(
        child: _selectablePillButton(),
      );
    });
  }

  Widget _selectablePillButton() {
    _checked = _controller.value == widget.title;
    return Padding(
      padding: const EdgeInsets.all(Base.smallPadding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () {
              _controller.value = widget.title;
              widget.onCheck(widget.title, !_checked);
            },
            child: Container(
              decoration: BoxDecoration(
                color: _selectedBackgroundColor(_checked),
                borderRadius:
                    BorderRadius.all(Radius.circular(Base.regularPadding)),
                border: Border.all(
                  color: AppColors.mainAccentColor,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Base.regularPadding),
                child: Text(
                  widget.title,
                  style: widget.themeProvider.body1.copyWith(
                    color: _selectedTextColor(_checked),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _selectedBackgroundColor(bool isSelected) {
    if (isSelected) return AppColors.mainAccentColor;
    return Colors.transparent;
  }

  Color _selectedTextColor(bool isSelected) {
    if (isSelected) return Colors.white;
    return AppColors.mainAccentColor;
  }
}
