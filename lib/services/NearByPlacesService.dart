import 'package:electro/models/NearByPlaces.dart';
import 'package:http/http.dart';

class NearByPlacesService {
  static String _url = "http://192.168.100.103:3000/search";
  static String _url_new = "http://192.168.100.103:3000/largesearch";

  static Future<List<Result>> getNearByPlaces() async {
    NearByPlaces _places;
    Response response = await get(_url).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }

  static Future<List<Result>> getNearByPlacesTillFiveKM() async {
    NearByPlaces _places;
    Response response = await get(_url_new).timeout(Duration(seconds: 5));
    if (response.statusCode == 200) {
      _places = nearByPlacesFromJson(response.body);
    }
    return _places.results;
  }


}
