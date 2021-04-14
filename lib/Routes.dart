import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/pages/Login.dart';
import 'package:flutter_whatsapp/pages/Register.dart';
import 'package:flutter_whatsapp/pages/autenticated/Configurations.dart';
import 'package:flutter_whatsapp/pages/autenticated/Home.dart';
import 'package:flutter_whatsapp/pages/autenticated/Mesages.dart';

class Routers {
  static const String ROUTE_BASE = '/';
  static const String ROUTE_LOGIN = '/login';
  static const String ROUTE_RISTER = '/register';
  static const String ROUTE_HOME = '/home';
  static const String ROUTE_CONFIG = '/configurations';
  static const String ROUTE_MSG = '/msg';

  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case ROUTE_BASE:
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case ROUTE_LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case ROUTE_RISTER:
        return MaterialPageRoute(builder: (_) => Register());
        break;
      case ROUTE_HOME:
        return MaterialPageRoute(builder: (_) => Home());
        break;
      case ROUTE_CONFIG:
        return MaterialPageRoute(builder: (_) => Configurations());
      case ROUTE_MSG:
        return MaterialPageRoute(builder: (_) => Mesage(args));
        break;
      default:
        _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tela não encontrada'),
          ),
          body: Center(
            child: Text('Tela não encontrada'),
          ),
        );
      },
    );
  }
}
