import 'package:electro/services/PreferenceManager.dart';
import 'package:electro/widget/ColorTheme.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final preferenceManager = PreferenceManager();
  runApp(MyApp(
    preferenceManager: preferenceManager,
  ));
}

class MyApp extends StatelessWidget {
  final PreferenceManager preferenceManager;

  MyApp({Key key, this.preferenceManager})
      : super(key: key); // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PreferenceState>(
        stream: preferenceManager.currentPrefs,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? MaterialApp(
                  title: 'Flutter Demo',
                  theme: snapshot.data.isDarkMode
                      ? ColorTheme.darkTheme()
                      : ColorTheme.lightTheme(),
                  home: Home(
                    preferenceManager: preferenceManager,
                  ),
                )
              : Scaffold();
        });
  }
}
