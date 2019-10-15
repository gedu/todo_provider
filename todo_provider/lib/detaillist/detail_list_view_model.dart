import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/user.dart';
import 'package:todo_provider/common/repositories/user/user_repository.dart';

class DetailListViewModel {
  final ImmutableHolder<User> user;
  final UserRepository _repository;

  DetailListViewModel(this.user, this._repository);
}
