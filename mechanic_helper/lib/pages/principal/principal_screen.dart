import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/pages/history/history_screen.dart';
import 'package:mechanic_helper/pages/homepage/homepage_screen.dart';
import 'package:mechanic_helper/pages/profile/profile_screen.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomAppbar();
}

class CustomAppbar extends State<PrincipalScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePageScreen(),
    HistoryScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('selected');
  }

  int getSelectedIndex() {
    return _selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}