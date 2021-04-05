import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  String email = '';

  @override
  void initState() {
    super.initState();
    _currentUser();
  }

  _currentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser logedUser = await auth.currentUser();
    email = logedUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        backgroundColor: Color(0xff075E54),
      ),
      body: Container(),
    );
  }
}
