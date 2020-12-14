import 'package:electro/models/NearByPlaces.dart';
import 'package:electro/models/PlaceDistance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class NearByPlacesService {
  static String _search = "http://192.168.100.103:3000/search";
  static String _search_large = "http://192.168.100.103:3000/largesearch";
  static String _distance_url = "http://192.168.100.103:3000/distance";

  static Future<List<Result>> getNearByPlaces() async {
    NearByPlaces _places;
    Response response = await get(_search).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }

  static Future<List<Result>> getNearByPlacesTillFiveKM() async {
    NearByPlaces _places;
    Response response = await get(_search_large).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }

  static Future<List<Rows>> getDistanceToPlace(String lat, String lng) async {
    await Future.delayed(Duration(seconds: 1));
    List<String> _distance;
    PlaceDistance _response;
    Response response = await get(_distance_url).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _response = placeDistanceFromJson(response.body);
    }
    return _response.rows;
  }
}
