class Mensage {
  String _idUser;
  String _mensage;
  String _urlImage;
  String _type;

  Mensage();

  get idUser => this._idUser;

  set idUser(value) => this._idUser = value;

  get mensage => this._mensage;

  set mensage(value) => this._mensage = value;

  get urlImage => this._urlImage;

  set urlImage(value) => this._urlImage = value;

  get type => this._type;

  set type(value) => this._type = value;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUser": this.idUser,
      "mensage": this.mensage,
      "urlImage": this.urlImage,
      "type": this.type
    };
    return map;
  }
}
