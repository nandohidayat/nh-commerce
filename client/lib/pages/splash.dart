import 'package:flutter/material.dart';
import 'dart:async';
import 'package:client/pages/login.dart';
import 'package:client/pages/signup.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  bool showButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    Timer(
//        Duration(seconds: 3), () => Navigator.of(context).pushNamed('/login'));
    Timer(
      Duration(seconds: 3),
      () {
        setState(
          () {
            showButton = true;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(seconds: 3),
                  curve: Curves.bounceIn,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'TOKO BUKU',
                        style: TextStyle(
                          fontFamily: 'MADE Coachella',
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'Bu Ratna',
                        style: TextStyle(
                          fontFamily: 'MADE Coachella',
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: showButton,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: EdgeInsets.all(
                            12,
                          ),
                          child: Center(
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black),
                          padding: EdgeInsets.all(
                            12,
                          ),
                          child: Center(
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
