import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/Routes.dart';
import 'package:flutter_whatsapp/pages/widgets/Contacts.dart';
import 'package:flutter_whatsapp/pages/widgets/Talks.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabMenu = ['Configurações', 'Sair'];

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

  _choiceMenu(String choice) {
    switch (choice) {
      case 'Configurações':
        break;

      case 'Sair':
        _logout();
        break;
      default:
        return;
    }
  }

  _logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, Routers.ROUTE_LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp'),
        backgroundColor: Color(0xff075E54),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _choiceMenu,
            itemBuilder: (context) {
              return tabMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
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
