import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/models/User.dart';

class Contacts extends StatefulWidget {
  @override
  _Contacts createState() => _Contacts();
}

class _Contacts extends State<Contacts> {
  Future<List<User>> _contacts() async {
    Firestore db = Firestore.instance;
    QuerySnapshot querySnapshot =
        await db.collection('usuarios').getDocuments();

    List<User> userList = [];
    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
      if (dados.length > 0) {
        User user = User();
        user.email = dados["email"];
        user.name = dados["name"];
        user.urlImage = dados["urlImage"];
        print(dados);

        userList.add(user);
      }
    }

    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _contacts(),
      // ignore: missing_return
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: [
                  Text('Carregando contatos'),
                  CircularProgressIndicator(),
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                List<User> lUser = snapshot.data;
                User user = lUser[index];
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: user.urlImage != null
                        ? NetworkImage(user.urlImage)
                        : null,
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                );
              },
            );
            break;
        }
      },
    );
  }
}
