import 'package:flutter/material.dart';

import 'package:client/screens/splash.dart';
import 'package:client/screens/login.dart';
import 'package:client/screens/signup.dart';

var routes = <String, WidgetBuilder>{
  '/signup': (BuildContext context) => new SignupPage(),
  '/login': (BuildContext context) => new LoginPage(),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Buku',
      routes: routes,
      theme: ThemeData(primaryColor: Colors.white),
      home: SplashPage(),
    );
  }
}
