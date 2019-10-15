import 'package:todo_provider/common/models/main_list.dart';
import 'package:todo_provider/common/utils/date_utils.dart';

class User {
  List<MainList> mainList = [];

  User.ini();

  void addList(String title, String description) {
    final creationDate = DateUtils.formattedNow();
    mainList.add(MainList(title, description, creationDate, 'new', []));
  }
}
