import 'package:electro/models/NearByPlaces.dart';
import 'package:electro/models/PlaceDistance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:math';

class NearByPlacesService {
  static String _search = "http://192.168.100.103:3000/search";
  static String _search_large = "http://192.168.100.103:3000/largesearch";
  static String _distance_url = "http://192.168.100.103:3000/distance";

  static String _aws_base = "https://electroapi.s3.ap-south-1.amazonaws.com/";
  static String _aws_search = "nearbysearch.json";
  static String _aws_search_large = "nearbysearch_large.json";
  static List<String> _aws_distance = ["distancematrix_1.json","distancematrix_2.json","distancematrix_3.json"];

  static Future<List<Result>> getNearByPlaces() async {
    NearByPlaces _places;
    Response response = await get(_aws_base + _aws_search).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }

  static Future<List<Result>> getNearByPlacesTillFiveKM() async {
    NearByPlaces _places;
    Response response = await get(_aws_base + _aws_search_large).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }

  static Future<List<Rows>> getDistanceToPlace(String lat, String lng) async {
    var rng = new Random();
    int index = rng.nextInt(3);
    await Future.delayed(Duration(seconds: 1));
    PlaceDistance _response;
    Response response = await get(_aws_base + _aws_distance[index]).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _response = placeDistanceFromJson(response.body);
    }
    return _response.rows;
  }
}
