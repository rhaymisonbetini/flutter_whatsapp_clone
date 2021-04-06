import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/pages/widgets/Contacts.dart';
import 'package:flutter_whatsapp/pages/widgets/Talks.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  String email = '';

  @override
  void initState() {
    super.initState();
    _currentUser();

    _tabController = TabController(length: 2, vsync: this);
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
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Conversas",
            ),
            Tab(
              text: "Contatos",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Talks(),
          Contacts(),
        ],
      ),
    );
  }
}
