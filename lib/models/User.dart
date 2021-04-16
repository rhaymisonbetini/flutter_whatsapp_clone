class User {
  String _idUser;
  String _name;
  String _email;
  String _password;
  String _urlImage;

  get idUser => this._idUser;

  set idUser(value) => this._idUser = value;

  get name => this._name;

  set name(value) => this._name = value;

  get email => this._email;

  set email(value) => this._email = value;

  get password => this._password;

  set password(value) => this._password = value;

  get urlImage => this._urlImage;

  set urlImage(value) => this._urlImage = value;

  User();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"name": this.name, "email": this.email};
    return map;
  }
}
