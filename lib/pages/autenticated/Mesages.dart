import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/models/User.dart';

class Mesage extends StatefulWidget {
  final User contact;
  Mesage(this.contact);

  @override
  _Mesage createState() => _Mesage();
}

class _Mesage extends State<Mesage> {
  TextEditingController _message = TextEditingController();

  _sendMessage() {}

  _sendPicture() {}

  @override
  Widget build(BuildContext context) {
    var boxMessage = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _message,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                  hintText: "Digite sua mensagem...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Color(0xff075E54),
                    ),
                    onPressed: () {
                      _sendPicture();
                    },
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              _sendMessage();
            },
            backgroundColor: Color(0xff075E54),
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
          )
        ],
      ),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 70,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
                CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: Colors.grey,
                  backgroundImage: widget.contact.urlImage != null
                      ? NetworkImage(widget.contact.urlImage)
                      : null,
                ),
              ],
            ),
          ),
          title: Text(widget.contact.name),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/bg.png',
              ),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[boxMessage],
          ),
        )),
      ),
    );
  }
}
