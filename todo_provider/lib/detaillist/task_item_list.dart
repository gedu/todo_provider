import 'package:flutter/material.dart';
import 'package:todo_provider/common/models/inner_list.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';

class TaskItemList extends StatelessWidget {
  final InnerList _task;
  final ThemeProvider _themeProvider;

  TaskItemList(this._task, this._themeProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: Base.mediumPadding),
      child: Row(
        children: <Widget>[
          _infoContainer(),
          _actionContainer(),
        ],
      ),
    );
  }

  Widget _infoContainer() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(right: Base.standardPadding),
        child: Column(
          children: <Widget>[
            _title(),
            _description(),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(bottom: Base.standardPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: Base.standardPadding),
            alignment: Alignment.centerLeft,
            child: Text(
              _task.title.toUpperCase(),
              style: _themeProvider.title.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Base.smallPadding),
              ),
              color: Colors.black38,
            ),
            child: Padding(
              padding: const EdgeInsets.all(Base.smallPadding),
              child: Text(
                _task.status,
                style: _themeProvider.body2.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.only(bottom: Base.standardPadding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _task.description,
              style: _themeProvider.body1.copyWith(color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        _task.creationDate,
        style: _themeProvider.body2.copyWith(color: Colors.black38),
      ),
    );
  }

  Widget _actionContainer() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_circle_outline,
                color: AppColors.mainAccentColor,
                size: 56,
              ),
            ),
          )
        ],
      ),
    );
  }
}
