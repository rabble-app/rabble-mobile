class ContactData {
   String? _heading;
   String? _subHeading;
  bool? _isSelected;

  ContactData(this._heading, this._subHeading, this._isSelected);

  bool? get isSelected => _isSelected;

  set isSelected(bool? value) {
    _isSelected = value;
  }

  String? get subHeading => _subHeading;

  set subHeading(String? value) {
    _subHeading = value;
  }

  String? get heading => _heading;

  set heading(String? value) {
    _heading = value;
  }
}
