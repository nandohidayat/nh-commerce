import 'package:flutter/material.dart';
import 'package:client/screens/profile.dart';
import 'package:client/screens/list.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();

  NavigatorPage({this.fromLogin});

  final bool fromLogin;
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ListPage(),
    Text('Hai'),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Keranjang'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces),
            title: Text('Akun'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade400,
        onTap: _onItemTapped,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
    );
  }
}