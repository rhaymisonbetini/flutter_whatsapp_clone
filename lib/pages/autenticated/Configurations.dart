import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Configurations extends StatefulWidget {
  @override
  _Configurations createState() => _Configurations();
}

class _Configurations extends State<Configurations> {
  TextEditingController _controllerName = TextEditingController();

  Future _getImage(String origim) async {
    File _imagem;
    File selectedImage;

    switch (origim) {
      case "cam":
        // ignore: deprecated_member_use
        selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "storage":
        selectedImage =
            // ignore: deprecated_member_use
            await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
      default:
        return null;
    }

    setState(() {
      _imagem = selectedImage;
    });
  }

  _register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Color(0xff075E54),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () => _getImage('cam'),
                      child: Text('Câmera'),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () => _getImage('storage'),
                      child: Text('Galeria'),
                    )
                  ],
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
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () {
                      _register();
                    },
                    child: Text(
                      'Salvar',
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
