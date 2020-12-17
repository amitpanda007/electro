import 'dart:async';

import 'package:electro/models/NearByPlaces.dart';
import 'package:electro/services/NearByPlacesService.dart';
import 'package:electro/services/PreferenceManager.dart';

class NearByPlacesManager {

  Stream<List<Result>> get placesListView {
    return Stream.fromFuture(NearByPlacesService.getNearByPlaces());
  }

  Stream<List<Result>> get placesListViewMax {
    return Stream.fromFuture(NearByPlacesService.getNearByPlacesTillFiveKM());
  }

}