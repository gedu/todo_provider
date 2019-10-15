import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/user.dart';
import 'package:todo_provider/common/router/main_list_argument.dart';
import 'package:todo_provider/common/router/router.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/common/widgets/big_title_header.dart';
import 'package:todo_provider/common/widgets/ring_loading.dart';
import 'package:todo_provider/common/widgets/scaffold_screen.dart';
import 'package:todo_provider/home/home_view_model.dart';
import 'package:todo_provider/home/todo_item_list.dart';

class HomeScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final HomeViewModel homeViewModel;

  HomeScreen(this.homeViewModel, this.themeProvider);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double actionBarHeight = 100;

  @override
  Widget build(BuildContext context) {
    return ScaffoldScreen(child: _body());
  }

  @override
  initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      widget.homeViewModel.fetchTodoItems();
    });
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Base.standardPadding),
          child: _mainContent(),
        ),
      ],
    );
  }

  Widget _mainContent() {
    return Column(
      children: <Widget>[
        BigTitleHeader(
          title: "Lista Principal",
          autoFocus: true,
          themeProvider: widget.themeProvider,
        ),
        Expanded(
          child: HolderBuilder<User>(
            holder: widget.homeViewModel.user,
            builder: (context, holder) {
              return _handleHolder(holder);
            },
          ),
        ),
      ],
    );
  }

  Widget _handleHolder(ImmutableHolder<User> holder) {
    if (holder.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RingLoading(color: AppColors.mainAccentColor, size: 60),
      );
    }

    return _itemList();
  }

  Widget _itemList() {
    return Column(
      children: <Widget>[
        _listSubTitle(),
        Expanded(child: _list()),
      ],
    );
  }

  Widget _listSubTitle() {
    final amountOfItems = widget.homeViewModel.user.value.mainList.length;
    final listWord = amountOfItems == 1 ? "lista" : "listas";

    return Container(
      padding: const EdgeInsets.only(
        top: Base.standardPadding,
        bottom: Base.standardPadding,
      ),
      child: Text(
        "Tenes $amountOfItems $listWord",
        style: widget.themeProvider.body1.copyWith(color: Colors.white54),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      addSemanticIndexes: false,
      padding: const EdgeInsets.only(
        bottom: (Base.mediumPadding + actionBarHeight),
      ),
      itemCount: widget.homeViewModel.user.value.mainList.length,
      itemBuilder: (context, index) {
        final todoItem = widget.homeViewModel.user.value.mainList[index];
        return IndexedSemantics(
          index: index,
          child: TodoItemList(
            title: todoItem.title,
            description: todoItem.description,
            creationDate: todoItem.creationDate,
            actionNotes: todoItem.lastActions,
            themeProvider: widget.themeProvider,
            index: index,
            onTap: (title, index) {
              Navigator.pushNamed(context, Routes.detailList,
                  arguments: MainListArgument(title, index));
            },
          ),
        );
      },
    );
  }
}
