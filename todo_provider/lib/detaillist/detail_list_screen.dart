import 'package:flutter/material.dart';
import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/inner_list.dart';
import 'package:todo_provider/common/models/user.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/common/utils/hero_utils.dart';
import 'package:todo_provider/common/widgets/big_title_header.dart';
import 'package:todo_provider/common/widgets/scaffold_screen.dart';
import 'package:todo_provider/detaillist/detail_list_view_model.dart';
import 'package:todo_provider/detaillist/task_item_list.dart';

import 'bottomsheetform/bottom_sheet_item_creation.dart';

class DetailListScreen extends StatefulWidget {
  final String _title;
  final int _selectedListIndex;
  final DetailListViewModel _detailViewModel;
  final ThemeProvider _themeProvider;

  DetailListScreen(
    this._title,
    this._selectedListIndex,
    this._detailViewModel,
    this._themeProvider,
  );

  @override
  _DetailListScreenState createState() => _DetailListScreenState();
}

class _DetailListScreenState extends State<DetailListScreen> {
  List<InnerList> _currentList;

  @override
  void initState() {
    _currentList = widget._detailViewModel.user.value
        .mainList[widget._selectedListIndex].innerList;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('DETAIL');
    return ScaffoldScreen(
      child: _body(),
      floatingActionButton: _addItemButton(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        _background(),
        _content(),
      ],
    );
  }

  Widget _background() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Hero(
            tag: HeroUtils.backgroundItemTag(
                widget._title, widget._selectedListIndex),
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _content() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Base.standardPadding),
      child: Column(
        children: <Widget>[
          BigTitleHeader(
            title: widget._title,
            titleColor: Colors.black54,
            tag: HeroUtils.titleItemTag(
                widget._title, widget._selectedListIndex),
            themeProvider: widget._themeProvider,
          ),
          Expanded(
            child: HolderBuilder<User>(
              holder: widget._detailViewModel.user,
              builder: (context, holder) {
                return _handleHolder(holder);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _handleHolder(ImmutableHolder<User> holder) {
    return _list();
  }

  Widget _list() {
    return ListView.builder(
      addSemanticIndexes: false,
      padding: const EdgeInsets.only(bottom: Base.mediumPadding),
      itemCount: _currentList.length,
      itemBuilder: (context, index) {
        final taskItem = _currentList[index];
        return IndexedSemantics(
          index: index,
          child: TaskItemList(
            taskItem,
            widget._themeProvider,
          ),
        );
      },
    );
  }

  Widget _addItemButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        ItemCreationModal.showForm(
          widget._themeProvider,
          context,
        );
      },
      label: Text(
        "Agregar Item",
        style: widget._themeProvider.title.copyWith(color: Colors.white),
      ),
      icon: Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
      backgroundColor: Colors.black,
    );
  }
}
