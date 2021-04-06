class Talk {
  String _name;
  String _mensage;
  String _photo;

  Talk(this._name, this._mensage, this._photo);

  // ignore: unnecessary_getters_setters
  String get name => _name;

  // ignore: unnecessary_getters_setters
  set name(String value) {
    _name = value;
  }

  // ignore: unnecessary_getters_setters
  String get message => _mensage;

  // ignore: unnecessary_getters_setters
  set message(String value) {
    _mensage = value;
  }

  // ignore: unnecessary_getters_setters
  String get photo => _photo;

  // ignore: unnecessary_getters_setters
  set photo(String value) {
    _photo = value;
  }
}
