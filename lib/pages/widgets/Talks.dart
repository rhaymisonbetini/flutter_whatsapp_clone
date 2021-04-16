import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/models/Talk.dart';

class Talks extends StatefulWidget {
  @override
  _Talks createState() => _Talks();
}

class _Talks extends State<Talks> {
  List<Talk> talks = [
    Talk('Cristian heleno', 'Fala jão',
        'https://firebasestorage.googleapis.com/v0/b/whatsapp-2e748.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=80ac1efd-238c-4a92-9e20-3f2de5b9b57e'),
    Talk('Thais Damaceno', 'Fala totoso',
        'https://firebasestorage.googleapis.com/v0/b/whatsapp-2e748.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=85c64f3d-21bd-41a6-b12d-cd49cdf795dd'),
    Talk('Jessica Cardoso', 'Cade o código caraio!',
        'https://firebasestorage.googleapis.com/v0/b/whatsapp-2e748.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=6e8a6a51-e9a1-4ca9-8d94-bfb571699414'),
    Talk('Jorge camarco', 'Bora fazer umas foto cuzao',
        'https://firebasestorage.googleapis.com/v0/b/whatsapp-2e748.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=a6e72cfd-aa29-4843-90b9-0b12e7a05e42'),
    Talk('Professor', 'Vai estudar viado',
        'https://firebasestorage.googleapis.com/v0/b/whatsapp-2e748.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=656e1a6e-66dc-471b-b2ac-ae43c2ff92ef'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: talks.length,
      itemBuilder: (context, index) {
        Talk tal = talks[index];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(tal.photo),
          ),
          title: Text(
            tal.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            tal.mensage,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        );
      },
    );
  }
}
