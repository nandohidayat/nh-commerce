import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/screens/splash.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Pengaturan',
          style: TextStyle(
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.arrow_back_ios),
            title: Text('Keluar'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', '');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
