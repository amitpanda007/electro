import 'package:electro/screens/HomeScreen.dart';
import 'package:electro/screens/NavigationScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation_outlined),
            label: "Navigation",
          ),
        ],
        onTap: _onItemTap,
        currentIndex: _selectedIndex,
      ),
      body: [
        HomeScreen(),
        NavigationScreen(),
      ].elementAt(_selectedIndex),
    );
  }
}

