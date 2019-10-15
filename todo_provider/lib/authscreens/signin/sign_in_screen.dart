import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_provider/authscreens/signin/sign_in_view_model.dart';
import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/user_auth.dart';
import 'package:todo_provider/common/router/router.dart';
import 'package:todo_provider/common/theme/styles.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/common/widgets/big_title_header.dart';
import 'package:todo_provider/common/widgets/button.dart';
import 'package:todo_provider/common/widgets/input_field.dart';
import 'package:todo_provider/common/widgets/ring_loading.dart';
import 'package:todo_provider/common/widgets/scaffold_screen.dart';

class SignInScreen extends StatefulWidget {
  final SignInViewModel signInViewModel;
  final ThemeProvider themeProvider;

  SignInScreen(this.signInViewModel, this.themeProvider);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signInformKey = GlobalKey<FormState>();

  final _mailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  FocusNode _passwordNode;
  FocusNode _loadingNode;

  @override
  void initState() {
    _passwordNode = FocusNode();
    _loadingNode = FocusNode();
    widget.signInViewModel.user.addListener(_listenOnSuccessSignIn);
    super.initState();
  }

  @override
  void dispose() {
    widget.signInViewModel.user.removeListener(_listenOnSuccessSignIn);
    _passwordNode.dispose();
    _loadingNode.dispose();
    _mailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _listenOnSuccessSignIn() {
    if (widget.signInViewModel.user.isValueValid) {
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldScreen(
      child: _body(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Base.standardPadding),
      child: Form(
        key: _signInformKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BigTitleHeader(
                title: "Iniciar Sesión",
                themeProvider: widget.themeProvider,
              ),
              Container(height: Base.bigPadding * 2),
              _inputFields(),
              Container(height: Base.superBigPadding),
              HolderBuilder<UserAuth>(
                holder: widget.signInViewModel.user,
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

  Widget _inputFields() {
    return Column(
      children: <Widget>[
        InputField(
          hint: 'Mail',
          keyboardType: TextInputType.emailAddress,
          controller: _mailTextController,
          nextFocusNode: _passwordNode,
          validator: (text) {
            if (text.isEmpty) {
              return "Completar mail.";
            }
            if (!EmailValidator.validate(text)) {
              return "Formato no valido.";
            }
            return null;
          },
        ),
        InputField(
          hint: 'Contraseña',
          obscured: true,
          focusNode: _passwordNode,
          controller: _passwordTextController,
          validator: (text) => text.isEmpty ? "Completar contraseña." : null,
        ),
      ],
    );
  }

  Widget _handleHolder(ImmutableHolder<UserAuth> holder) {
    if (holder.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RingLoading(color: AppColors.mainAccentColor, size: 60),
      );
    }

    if (holder.hasError) {
      return _showSignInError(holder.errorMsg);
    }

    return _signInButton();
  }

  Widget _showSignInError(String errorMessage) {
    return Column(
      children: <Widget>[
        _signInButton(),
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

  Widget _signInButton() {
    return Button(
      title: 'INICIAR SESIÓN',
      onPress: () {
        if (_signInformKey.currentState.validate()) {
          widget.signInViewModel.signInWith(
            _mailTextController.text,
            _passwordTextController.text,
          );
        }
      },
      themeProvider: widget.themeProvider,
    );
  }
}
