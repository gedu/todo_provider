import 'package:provider/provider.dart';
import 'package:todo_provider/authscreens/signin/sign_in_view_model.dart';
import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/user.dart';
import 'package:todo_provider/common/models/user_auth.dart';
import 'package:todo_provider/common/repositories/user/user_remote_data_source.dart';
import 'package:todo_provider/common/repositories/user/user_repository.dart';
import 'package:todo_provider/common/theme/theme_provider.dart';
import 'package:todo_provider/detaillist/detail_list_view_model.dart';
import 'package:todo_provider/home/home_view_model.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...bridgeServices,
  ...dependentServices,
  ...uiProviders,
];

//When gets bigger split into many files

List<SingleChildCloneableWidget> independentServices = [
  Provider<ThemeProvider>(builder: (context) => ThemeProvider(context)),
  ChangeNotifierProvider<Holder<User>>(builder: (_) => Holder<User>()),
  ChangeNotifierProvider<Holder<UserAuth>>(builder: (_) => Holder<UserAuth>()),
];

List<SingleChildCloneableWidget> bridgeServices = [
  ProxyProvider2<Holder<User>, Holder<UserAuth>, UserRemoteDataSource>(
    builder: (context, userHolder, authHolder, _) =>
        UserRemoteDataSource(userHolder, authHolder),
  ),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<UserRemoteDataSource, UserRepository>(
    builder: (context, userRemoteDataSource, repository) =>
        UserRepository(userRemoteDataSource),
  ),
];

List<SingleChildCloneableWidget> uiProviders = [
  ProxyProvider2<Holder<UserAuth>, UserRepository, SignInViewModel>(
    builder: (context, authHolder, preference, _) =>
        SignInViewModel(authHolder, preference),
  ),
  ProxyProvider2<Holder<User>, UserRepository, HomeViewModel>(
    builder: (context, userHolder, userRepository, _) =>
        HomeViewModel(userHolder, userRepository),
  ),
  ProxyProvider2<Holder<User>, UserRepository, DetailListViewModel>(
    builder: (context, userHolder, userRepository, _) =>
        DetailListViewModel(userHolder, userRepository),
  ),
];
