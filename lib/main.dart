import 'package:electro/services/PreferenceManager.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final preferenceManager = PreferenceManager();
  runApp(MyApp(preferenceManager: preferenceManager,));
}

class MyApp extends StatelessWidget {
  final PreferenceManager preferenceManager;

  MyApp({Key key, this.preferenceManager}) : super(key: key); // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PreferenceState>(
      stream: preferenceManager.currentPrefs,
      builder: (context, snapshot) {
        return snapshot.hasData ? MaterialApp(
          title: 'Flutter Demo',
          theme: snapshot.data.isDarkMode ? ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.cyan[400],
            accentColor: Colors.deepOrange[200],
            cardColor: Colors.blueGrey.shade800,
            primaryColorDark: Colors.amber,
            primaryColorLight: Colors.pink,
            textTheme: TextTheme(
              headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline3: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ) : ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.blue[700],
            accentColor: Colors.yellow[500],
            cardColor: Colors.grey.shade100,
            primaryColorDark: Colors.redAccent,
            primaryColorLight: Colors.deepPurple,
            textTheme: TextTheme(
              headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline3: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Home(preferenceManager: preferenceManager,),
        ) : Scaffold();
      }
    );
  }
}