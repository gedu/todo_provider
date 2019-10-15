import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/user_auth.dart';
import 'package:todo_provider/common/repositories/user/user_repository.dart';

class SignInViewModel {
  final ImmutableHolder<UserAuth> user;
  final UserRepository _repository;

  SignInViewModel(this.user, this._repository);

  void signInWith(String email, String password) {
    _repository.signInWith(email, password);
  }
}
