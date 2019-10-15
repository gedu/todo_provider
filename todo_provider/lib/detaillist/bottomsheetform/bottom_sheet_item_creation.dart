import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/user.dart';
import 'package:todo_provider/common/repositories/user/user_repository.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/common/widgets/button.dart';
import 'package:todo_provider/common/widgets/input_field.dart';
import 'package:todo_provider/common/widgets/ring_loading.dart';
import 'package:todo_provider/common/widgets/selectablebutton/border_selectable_button.dart';
import 'package:todo_provider/common/widgets/selectablebutton/selectable_button_controller.dart';
import 'package:todo_provider/detaillist/bottomsheetform/sheet_view_model.dart';

class ItemCreationModal {
  static showForm(ThemeProvider themeProvider, BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Base.mediumPadding),
          topRight: Radius.circular(Base.mediumPadding),
        ),
      ),
      context: context,
      builder: (context) {
        return Consumer2<Holder<User>, UserRepository>(
          builder: (context, viewModel, repository, _) {
            return _BottomSheetItemCreation(
              SheetViewModel(viewModel, repository),
              themeProvider,
              MediaQuery.of(context),
            );
          },
        );
      },
    );
  }
}

class _BottomSheetItemCreation extends StatefulWidget {
  final SheetViewModel viewModel;
  final ThemeProvider themeProvider;
  final MediaQueryData mediaQuery;

  _BottomSheetItemCreation(this.viewModel, this.themeProvider, this.mediaQuery);

  @override
  __BottomSheetItemCreationState createState() =>
      __BottomSheetItemCreationState();
}

class __BottomSheetItemCreationState extends State<_BottomSheetItemCreation> {
  final _detailListFormKey = GlobalKey<FormState>();

  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  FocusNode _descriptionNode;
  String selectedState = "";

  @override
  void initState() {
    _descriptionNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionNode.dispose();
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: (widget.mediaQuery.viewInsets.bottom + Base.bigPadding),
        ),
        child: Form(
          key: _detailListFormKey,
          child: Column(
            children: <Widget>[
              InputField(
                hint: 'Titulo',
                keyboardType: TextInputType.text,
                controller: _titleTextController,
                nextFocusNode: _descriptionNode,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Completar Titulo.";
                  }

                  return null;
                },
              ),
              InputField(
                hint: 'Descripcion',
                keyboardType: TextInputType.text,
                focusNode: _descriptionNode,
                controller: _descriptionTextController,
                validator: (text) {
                  if (text.isEmpty) {
                    return "Completar Descripcion.";
                  }

                  return null;
                },
              ),
              _itemStatusOptions(),
              HolderBuilder<User>(
                holder: widget.viewModel.user,
                builder: (context, holder) {
                  return _handleHolder(holder);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemStatusOptions() {
    return ChangeNotifierProvider<SelectableButtonController>(
      builder: (_) => SelectableButtonController(),
      child: Container(
        padding: const EdgeInsets.only(
          left: Base.standardPadding,
          top: Base.standardPadding,
          bottom: Base.bigPadding,
        ),
        child: Row(
          children: <Widget>[
            Text(
              "Estado",
              style: widget.themeProvider.body1.copyWith(color: Colors.black87),
            ),
            ExcludeSemantics(
              child: Container(
                width: Base.mediumPadding,
              ),
            ),
            BorderSelectableButton(
              title: "Pendiente",
              themeProvider: widget.themeProvider,
              onCheck: (title, state) {
                selectedState = title;
              },
            ),
            ExcludeSemantics(
              child: Container(
                width: Base.mediumPadding,
              ),
            ),
            BorderSelectableButton(
              title: "Finalizado",
              themeProvider: widget.themeProvider,
              onCheck: (title, state) {
                selectedState = title;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _handleHolder(ImmutableHolder<User> holder) {
    print('SHEET HOLDER: ${holder.isLoading}');
    if (holder.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(Base.regularPadding),
        child: RingLoading(color: AppColors.mainAccentColor, size: 60),
      );
    }

    if (holder.hasError) {
      return _showSignInError(holder.errorMsg);
    }

    //todo move it into an addListener fun
    if (holder.requestSuccess) {
      Navigator.pop(context);
    }

    return _createListButton();
  }

  Widget _showSignInError(String errorMessage) {
    return Column(
      children: <Widget>[
        _createListButton(),
        Padding(
          padding: const EdgeInsets.only(top: Base.mainHorizontalPadding),
          child: Text(
            errorMessage,
            style: widget.themeProvider.bodyError,
          ),
        ),
      ],
    );
  }

  Widget _createListButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Base.standardPadding),
      child: Button(
        title: 'AGREGAR ITEM',
        onPress: () {
          if (_detailListFormKey.currentState.validate() &&
              selectedState.isNotEmpty) {
            widget.viewModel.addItem(
              _titleTextController.text,
              _descriptionTextController.text,
              selectedState,
            );
          }
        },
        themeProvider: widget.themeProvider,
      ),
    );
  }
}
