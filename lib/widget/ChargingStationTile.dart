import 'package:electro/models/NearByPlaces.dart';
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
                  child: ListTile(
                    tileColor: Colors.blueGrey,
                    contentPadding: EdgeInsets.all(15.0),
                    dense: true,
                    isThreeLine: true,
                    leading: Icon(
                      Icons.local_gas_station,
                      size: 50.0,
                    ),
                    title: Text(
                      place.name,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.star_half),
                        Text(
                          place.rating.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    trailing: findDistanceToPlace(latitude, longitude),
                    onTap: () {
                      /*_launchMapsUrl("ChIJw-P4V5unGToRE9YxF4ShiWY",
                                "ChIJ41yEqJynGToRCcibrlr4XnE");*/
                    },
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

  findDistanceToPlace(String latitude, String longitude) {
    // TODO: implement distance widget
    return Text("2 min away");
  }
}
