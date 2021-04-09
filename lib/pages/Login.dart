import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_whatsapp/Routes.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verifyLogedUser();
  }

  Future _verifyLogedUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser logedUser = await auth.currentUser();
    if (logedUser != null) {
      Navigator.pushReplacementNamed(context, Routers.ROUTE_HOME);
    }
  }

  Future _onLogin() async {
    bool validator = await _validator();
    if (validator) {
      FirebaseAuth auth = FirebaseAuth.instance;
      auth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then(
            (value) =>
                {Navigator.pushReplacementNamed(context, Routers.ROUTE_HOME)},
          )
          .catchError(
            // ignore: return_of_invalid_type_from_catch_error
            (error) => {
              _callSnackBar('Erro ao realizar o login'),
            },
          );
    }
  }

  _validator() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || !email.contains('@') || password.isEmpty) {
      _callSnackBar('Ops! Email ou senha inválidos!');
      return false;
    } else {
      return true;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff075E54),
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
                    'assets/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
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
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
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
                      _onLogin();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      'Não possui conta? Cadastre-se!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routers.ROUTE_RISTER);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
