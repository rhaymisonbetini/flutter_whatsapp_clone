import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Configurations extends StatefulWidget {
  @override
  _Configurations createState() => _Configurations();
}

class _Configurations extends State<Configurations> {
  TextEditingController _controllerName = TextEditingController();
  File _imagem;
  bool _uploadFile = false;
  String urlRecovered;
  String _idLoged;

  @override
  void initState() {
    super.initState();
    _recoverDatas();
  }

  _recoverDatas() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser loged = await auth.currentUser();

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection('usuarios').document(loged.uid).get();

    Map<String, dynamic> dados = snapshot.data;

    setState(() {
      _idLoged = loged.uid;
      urlRecovered = dados['urlImage'];
      _controllerName.text = dados['name'];
    });
  }

  Future _getImage(String origim) async {
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
      if (_imagem != null) {
        _uploadImage();
      }
    });
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference path = storage.ref();
    var child = path.child('perfil');
    StorageReference file = child.child(_idLoged + '.jpg');

    StorageUploadTask task = file.putFile(_imagem);

    task.events.listen(
      (StorageTaskEvent storageTaskEvent) {
        if (storageTaskEvent.type == StorageTaskEventType.progress) {
          setState(() {
            _uploadFile = true;
          });
        }
      },
    );
    task.onComplete.then(
      (StorageTaskSnapshot storageTaskSnapshot) {
        _recoverUrlImage(storageTaskSnapshot);
      },
    );
  }

  Future _recoverUrlImage(StorageTaskSnapshot storageTaskSnapshot) async {
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    _updateFireStore(url);
    setState(() {
      urlRecovered = url;
      _uploadFile = false;
    });
  }

  _updateFireStore(String url) {
    Firestore db = Firestore.instance;
    Map<String, dynamic> dados = {"urlImage": url};
    db.collection('usuarios').document(_idLoged).updateData(dados);
  }

  _register() {
    Firestore db = Firestore.instance;
    Map<String, dynamic> dados = {"name": _controllerName.text};
    db.collection('usuarios').document(_idLoged).updateData(dados);
  }

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
                _uploadFile
                    ? CircularProgressIndicator()
                    : CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey,
                        backgroundImage: urlRecovered != null
                            ? NetworkImage(urlRecovered)
                            : null,
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
