import 'package:electro/models/NearByPlaces.dart';
import 'package:electro/models/PlaceDistance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:math';

class NearByPlacesService {
  static Map<String, List<Rows>> _cachedDistance = Map();

  static String _local_base = "http://192.168.100.116:3000";
  static String _search = "/search";
  static String _search_large = "/largesearch";
  static String _distance_url = "/distance";

  static String _aws_base = "https://electroapi.s3.ap-south-1.amazonaws.com/";
  static String _aws_search = "nearbysearch.json";
  static String _aws_search_large = "nearbysearch_large.json";
  static List<String> _aws_distance = ["distancematrix_1.json","distancematrix_2.json","distancematrix_3.json"];

  static Future<List<Result>> getNearByPlaces() async {
    NearByPlaces _places;
    Response response = await get(_local_base + _search).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }

  static Future<List<Result>> getNearByPlacesTillFiveKM() async {
    NearByPlaces _places;
    Response response = await get(_local_base + _search_large).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }

  static Future<List<Rows>> getDistanceToPlace(String lat, String lng) async {
    String _cacheKey = lat+","+lng;
    print(_cacheKey);

    var rng = new Random();
    int index = rng.nextInt(3);
    // await Future.delayed(Duration(seconds: 1));
    PlaceDistance _response;
    if(_cachedDistance.containsKey(_cacheKey)) {
      print("Cache Key ${_cacheKey} Found. Returning data from cache.");
      return _cachedDistance[_cacheKey];
    }
    Response response = await get(_local_base + _distance_url).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _response = placeDistanceFromJson(response.body);
    }
    print("Cache Key ${_cacheKey} Not Found. Putting data into cache.");
    _cachedDistance[_cacheKey] = _response.rows;
    return _response.rows;
  }
}
