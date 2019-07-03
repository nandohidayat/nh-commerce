import 'package:flutter/material.dart';
import 'package:client/screens/setting.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text(
          'Akun Saya',
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.grey,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
          )
        ],
      ),
    );
  }
}
