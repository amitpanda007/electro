import 'package:electro/services/NearByPlacesManager.dart';
import 'package:electro/widget/ChargingStationTile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSelected = false;
  NearByPlacesManager manager = NearByPlacesManager();
  Stream activeStream;

  @override
  Widget build(BuildContext context) {
    activeStream = _isSelected ? manager.placesListViewMax : manager.placesListView;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: Text("Expand Search (Max 5KM)"),
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
            ),
            Container(
              height: 500,
              child: ChargingStationTile(
                stream: activeStream,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
