import 'package:flutter/material.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/common/utils/hero_utils.dart';

typedef ListSelectedCallback = void Function(String title, int index);

class TodoItemList extends StatelessWidget {
  final String title;
  final String description;
  final String creationDate;
  final String actionNotes;
  final int index;
  final ThemeProvider themeProvider;
  final ListSelectedCallback onTap;

  TodoItemList({
    this.title,
    this.description,
    this.creationDate,
    this.actionNotes,
    this.index,
    this.themeProvider,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Stack(
        children: <Widget>[
          Hero(
              tag: HeroUtils.backgroundItemTag(title, index),
              child: Container(color: Colors.white)),
          InkWell(
            onTap: () {
              onTap(title, index);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Base.standardPadding,
                vertical: Base.standardPadding,
              ),
              child: Column(
                children: <Widget>[
                  _title(),
                  _description(),
                  _footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Hero(
      tag: HeroUtils.titleItemTag(title, index),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(bottom: Base.standardPadding),
        child: Text(
          title,
          style: themeProvider.title.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              description,
              style: themeProvider.body1.copyWith(color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            creationDate,
            style: themeProvider.body2.copyWith(color: Colors.black38),
          ),
          Text(
            actionNotes,
            style: themeProvider.body2.copyWith(color: Colors.black38),
          )
        ],
      ),
    );
  }
}
