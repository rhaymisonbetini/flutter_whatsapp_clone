import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/pages/Login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366),
      ),
      builder: EasyLoading.init(),
    ),
  );
}
