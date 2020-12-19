import 'package:electro/services/PreferenceManager.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  final PreferenceManager preferenceManager;

  NavigationScreen({this.preferenceManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation"),
      ),
      body: Center(
        child: Text(
          "More info coming soon.",
        ),
      ),
    );
  }
}
