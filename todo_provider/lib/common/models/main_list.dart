import 'package:todo_provider/common/models/inner_list.dart';

class MainList {
  final String _title;
  final String _description;
  final String _creationDate;
  final String _lastActions;
  List<InnerList> innerList = [];

  String get title => _title;
  String get description => _description;
  String get creationDate => _creationDate;
  String get lastActions => _lastActions;

  MainList(this._title, this._description, this._creationDate,
      this._lastActions, this.innerList);

  addItem(
    String title,
    String description,
    String creationDate,
    String status,
  ) {
    innerList.add(InnerList(title, description, creationDate, status));
  }
}
