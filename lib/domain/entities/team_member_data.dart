class TeamMemberData {
   String? _heading;
  bool? _isSelected;

  TeamMemberData(this._heading,  this._isSelected);

  bool? get isSelected => _isSelected;

  set isSelected(bool? value) {
    _isSelected = value;
  }

  String? get heading => _heading;

  set heading(String? value) {
    _heading = value;
  }
}
