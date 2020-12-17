import 'package:electro/services/NearByPlacesManager.dart';
import 'package:electro/services/PreferenceManager.dart';
import 'package:electro/widget/ChargingStationTile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final PreferenceManager preferenceManager;

  HomeScreen({this.preferenceManager});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _isSelected = false;
  NearByPlacesManager manager = NearByPlacesManager();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // activeStream = _isSelected ? manager.placesListViewMax : manager.placesListView;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<PreferenceState>(
                stream: widget.preferenceManager.currentPrefs,
                builder: (context, snapshot) {
                  if(snapshot.data?.isLargeSearch == true) {
                    return ChargingStationTile(
                      stream: manager.placesListViewMax,
                    );
                  }else {
                    return ChargingStationTile(
                      stream: manager.placesListView,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream activeStream;
}
