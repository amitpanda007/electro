import 'package:electro/screens/HomeScreen.dart';
import 'package:electro/screens/NavigationScreen.dart';
import 'package:electro/services/PreferenceManager.dart';
import 'package:electro/widget/PreferenceModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final PreferenceManager preferenceManager;

  Home({
    this.preferenceManager,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTap(int value) {
    if (value == 2) {
      PreferenceModal.showPreferenceSheet(context, widget.preferenceManager);
      return;
    }
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Preference",
          ),
        ],
        onTap: _onItemTap,
        currentIndex: _selectedIndex,
      ),
      body: [
        HomeScreen(
          preferenceManager: widget.preferenceManager,
        ),
        NavigationScreen(
          preferenceManager: widget.preferenceManager,
        ),
      ].elementAt(_selectedIndex),
    );
  }
}
