// To parse this JSON data, do
//
//     final nearByPlaces = nearByPlacesFromJson(jsonString);

import 'dart:convert';

NearByPlaces nearByPlacesFromJson(String str) => NearByPlaces.fromJson(json.decode(str));

String nearByPlacesToJson(NearByPlaces data) => json.encode(data.toJson());

class NearByPlaces {
  NearByPlaces({
    this.results,
    this.status,
  });

  List<Result> results;
  String status;

  factory NearByPlaces.fromJson(Map<String, dynamic> json) => NearByPlaces(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status,
  };
}

class Result {
  Result({
    // this.businessStatus,
    this.geometry,
    this.icon,
    this.name,
    this.openingHours,
    // this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    // this.scope,
    // this.types,
    this.userRatingsTotal,
    this.vicinity,
  });

  // String businessStatus;
  Geometry geometry;
  String icon;
  String name;
  OpeningHours openingHours;
  // List<Photo> photos;
  String placeId;
  PlusCode plusCode;
  String rating;
  String reference;
  // String scope;
  // List<String> types;
  int userRatingsTotal;
  String vicinity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    // businessStatus: json["business_status"],
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    name: json["name"],
    openingHours: OpeningHours.fromJson(json["opening_hours"]),
    // photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    placeId: json["place_id"],
    plusCode: PlusCode.fromJson(json["plus_code"]),
    rating: (json["rating"].toString()),
    reference: json["reference"],
    // scope: json["scope"],
    // types: List<String>.from(json["types"].map((x) => x)),
    userRatingsTotal: json["user_ratings_total"],
    vicinity: json["vicinity"],
  );

  Map<String, dynamic> toJson() => {
    // "business_status": businessStatus,
    "geometry": geometry.toJson(),
    "icon": icon,
    "name": name,
    "opening_hours": openingHours.toJson(),
    // "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "place_id": placeId,
    "plus_code": plusCode.toJson(),
    "rating": rating,
    "reference": reference,
    // "scope": scope,
    // "types": List<dynamic>.from(types.map((x) => x)),
    "user_ratings_total": userRatingsTotal,
    "vicinity": vicinity,
  };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "viewport": viewport.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast.toJson(),
    "southwest": southwest.toJson(),
  };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    openNow: json["open_now"] == null ? null : json["open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow == null ? null : openNow,
  };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    height: json["height"],
    htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
    "photo_reference": photoReference,
    "width": width,
  };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"],
    globalCode: json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode,
    "global_code": globalCode,
  };
}
