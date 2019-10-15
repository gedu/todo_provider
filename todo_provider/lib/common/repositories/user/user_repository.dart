import 'package:todo_provider/common/repositories/user/user_remote_data_source.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepository(this.remoteDataSource);

  void signInWith(String email, String password) {
    remoteDataSource.signInWith(email, password);
  }

  void createAccountWith(
      String firstName, String lastName, String email, String password) {
    remoteDataSource.createAccountWith(firstName, lastName, email, password);
  }

  void fetchTodoItems() {
    remoteDataSource.fetchTodoItems();
  }

  void createList(String title, String description) {
    remoteDataSource.createList(title, description);
  }

  void addItem(String title, String description, String status) {
    remoteDataSource.addItem(title, description, status);
  }
}
