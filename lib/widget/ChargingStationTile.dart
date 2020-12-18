import 'package:electro/models/NearByPlaces.dart';
import 'package:electro/models/PlaceDistance.dart';
import 'package:electro/services/NearByPlacesService.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ChargingStationTile extends StatelessWidget {
  final Stream<List<Result>> stream;
  // final Function builder;

  ChargingStationTile({this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Result>>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            // TODO: Remove print
            // print(snapshot);
            if (snapshot.hasError)
              return Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_sharp,
                        color: Colors.redAccent,
                        size: 40.0,
                      ),
                      Text(
                        "Error gathering data",
                        style: TextStyle(fontSize: 20.0),
                      )
                    ]),
              );
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Result place = snapshot.data[index];
                String latitude = place.geometry.location.lat.toString();
                String longitude = place.geometry.location.lng.toString();
                return Card(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: ListTile(
                    tileColor: Theme.of(context).cardColor,
                    contentPadding: EdgeInsets.all(15.0),
                    dense: true,
                    isThreeLine: true,
                    leading: Icon(
                      Icons.local_gas_station,
                      size: 50.0,
                    ),
                    title: Text(
                      place.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star_half,
                          size: 30.0,
                          color: Colors.amber,
                        ),
                        Text(
                          place.rating.toString(),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    trailing: findDistanceToPlace(latitude, longitude),
                    onTap: () {
                      _launchMap(
                          double.parse(latitude), double.parse(longitude));
                    },
                    enabled: place.openingHours.openNow == false ? false : true,
                  ),
                );
              },
            );
          default:
            return Center(child: Text("No Data Found at the Moment."));
        }
      },
    );
  }

  Widget findDistanceToPlace(String lat, String lng) {
    String _distance;
    String _duration;
    return FutureBuilder<List<Rows>>(
      future: NearByPlacesService.getDistanceToPlace(lat, lng),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasData) {
              List<Rows> data = snapshot.data;
              data.forEach((elms) {
                elms.elements.forEach((elm) {
                  _distance = elm.distance.text;
                  _duration = elm.duration.text;
                });
              });
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _distance,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    _duration,
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              );
            }
            return CircularProgressIndicator();
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }

  void _launchMap(double lat, double lng) {
    // MapsLauncher.launchCoordinates(lat, lng);
    print("Navigating to Lat:${lat}, Lng:${lng}");
    MapsLauncher.launchCoordinates(lat, lng);
  }
}
