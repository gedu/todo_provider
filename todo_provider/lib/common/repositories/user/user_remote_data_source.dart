import 'package:todo_provider/common/holder/base_holder.dart';
import 'package:todo_provider/common/models/inner_list.dart';
import 'package:todo_provider/common/models/main_list.dart';
import 'package:todo_provider/common/models/user.dart';
import 'package:todo_provider/common/models/user_auth.dart';
import 'package:todo_provider/common/utils/date_utils.dart';

final mockList = [
  MainList("Compras", "Antes de fin de mes", "11/11/11", "0 items", [
    InnerList('_title', "Una descripcion muy buerna para ver como queda",
        "11/11/1111", "Pendiente")
  ]),
];

class UserRemoteDataSource {
  final Holder<User> _userHolder;
  final Holder<UserAuth> _authHolder;

  UserRemoteDataSource(this._userHolder, this._authHolder);

  void signInWith(String email, String password) {
    _authHolder.isLoading = true;

    //todo: when the sign in is done, has to fetch user info
    Future.delayed(Duration(seconds: 2), () {
      _authHolder.value = UserAuth("token");
      _userHolder.value = User.ini();
    });
  }

  void createAccountWith(
      String firstName, String lastName, String email, String password) {
    _authHolder.isLoading = true;

    Future.delayed(Duration(seconds: 2), () {
      _authHolder.value = UserAuth("token");
    });
  }

  void fetchTodoItems() {
    _userHolder.isLoading = true;

    Future.delayed(Duration(seconds: 2), () {
      final user = User.ini();
      user.mainList = mockList;
      _userHolder.value = user;
    });
  }

  void createList(String title, String description) {
    _userHolder.isLoading = true;

    Future.delayed(Duration(seconds: 2), () {
      final currentUser = _userHolder.value;
      currentUser.addList(title, description);
      _userHolder.value = currentUser;
    });
  }

  void addItem(String title, String description, String status) {
    _userHolder.isLoading = true;

    Future.delayed(Duration(seconds: 2), () {
      final currentUser = _userHolder.value;
      currentUser.mainList
          .elementAt(0)
          .addItem(title, description, DateUtils.formattedNow(), status);
      _userHolder.value = currentUser;
    });
  }
}
