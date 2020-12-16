import 'package:electro/models/NearByPlaces.dart';
import 'package:electro/models/PlaceDistance.dart';
import 'package:electro/services/NearByPlacesService.dart';
import 'package:flutter/material.dart';

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
                    tileColor: Colors.blueGrey.shade800,
                    contentPadding: EdgeInsets.all(15.0),
                    dense: true,
                    isThreeLine: true,
                    leading: Icon(
                      Icons.local_gas_station,
                      size: 50.0,
                      color: Colors.pinkAccent.withOpacity(0.8),
                    ),
                    title: Text(
                      place.name,
                      style: TextStyle(fontSize: 20.0),
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
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    trailing: findDistanceToPlace(latitude, longitude),
                    onTap: () {
                      /*_launchMapsUrl("ChIJw-P4V5unGToRE9YxF4ShiWY",
                                "ChIJ41yEqJynGToRCcibrlr4XnE");*/
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
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(
                    _duration,
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
}
