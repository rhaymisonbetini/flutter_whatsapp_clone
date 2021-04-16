class Talk {
  String _name;
  String _mensage;
  String _photo;

  get name => this._name;

  set name(value) => this._name = value;

  get mensage => this._mensage;

  set mensage(value) => this._mensage = value;

  get photo => this._photo;

  set photo(value) => this._photo = value;

  Talk(this._name, this._mensage, this._photo);
}
