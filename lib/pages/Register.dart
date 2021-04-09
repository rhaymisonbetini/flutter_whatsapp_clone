import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whatsapp/Routes.dart';
import 'package:flutter_whatsapp/models/User.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _register() async {
    bool validate = await this._validate();
    if (validate) {
      await EasyLoading.show(
        status: 'Cadastrando usuário...',
        maskType: EasyLoadingMaskType.clear,
      );

      User user = User();
      user.name = _controllerName.text;
      user.email = _controllerEmail.text;
      user.password = _controllerPassword.text;

      FirebaseAuth auth = FirebaseAuth.instance;
      auth
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password)
          .then(
        (FirebaseUser firebaseUser) async {
          _callSuccessSnackBar('Usuário cadastrado com sucesso!');
          await _createUser(firebaseUser, user);
          _clearForm();
          EasyLoading.dismiss();
          Navigator.pushNamedAndRemoveUntil(
              context, Routers.ROUTE_LOGIN, (_) => false);
        },
      ).catchError(
        (error) => {
          _callSnackBar('Ops! algo inesperado aconteceu!'),
        },
      );
    }
  }

  _createUser(FirebaseUser firebaseUser, User user) async {
    Firestore db = Firestore.instance;
    db.collection('usuarios').document(firebaseUser.uid).setData(user.toMap());
    return;
  }

  _validate() {
    String name = _controllerName.text;
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (name.isEmpty ||
        email.isEmpty ||
        !email.contains("@") ||
        password.isEmpty) {
      _callSnackBar('Ops! formulário inválido!');
      return false;
    } else {
      return true;
    }
  }

  _clearForm() {
    _controllerName.text = null;
    _controllerEmail.text = null;
    _controllerPassword.text = null;
  }

  _callSnackBar(String erroMesage) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        erroMesage,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _callSuccessSnackBar(String erroMesage) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        erroMesage,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff075E54),
      appBar: AppBar(
        title: Text('cadastro'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    'assets/usuario.png',
                    width: 150,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerName,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _controllerPassword,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () {
                      _register();
                    },
                    child: Text(
                      'Cadastre-se',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
