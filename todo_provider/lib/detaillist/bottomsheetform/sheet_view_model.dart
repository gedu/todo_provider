import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/user.dart';
import 'package:todo_provider/common/repositories/user/user_repository.dart';

class SheetViewModel {
  final ImmutableHolder<User> user;
  final UserRepository _repository;

  SheetViewModel(this.user, this._repository);

  void addItem(String title, String description, String status) {
    _repository.addItem(title, description, status);
  }
}
