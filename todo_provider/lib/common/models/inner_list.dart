class InnerList {
  final String _title;
  final String _description;
  final String _creationDate;
  final String _status;

  String get title => _title;
  String get description => _description;
  String get creationDate => _creationDate;
  String get status => _status;

  InnerList(this._title, this._description, this._creationDate, this._status);

  InnerList updateStatus(String status) {
    return InnerList(
        this._title, this._description, this._creationDate, status);
  }
}
