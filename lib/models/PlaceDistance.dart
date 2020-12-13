// To parse this JSON data, do
//
//     final placeDistance = placeDistanceFromJson(jsonString);

import 'dart:convert';

PlaceDistance placeDistanceFromJson(String str) => PlaceDistance.fromJson(json.decode(str));

String placeDistanceToJson(PlaceDistance data) => json.encode(data.toJson());

class PlaceDistance {
  PlaceDistance({
    this.destinationAddresses,
    this.originAddresses,
    this.rows,
    this.status,
  });

  List<String> destinationAddresses;
  List<String> originAddresses;
  List<Rows> rows;
  String status;

  factory PlaceDistance.fromJson(Map<String, dynamic> json) => PlaceDistance(
    destinationAddresses: List<String>.from(json["destination_addresses"].map((x) => x)),
    originAddresses: List<String>.from(json["origin_addresses"].map((x) => x)),
    rows: List<Rows>.from(json["rows"].map((x) => Rows.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "destination_addresses": List<dynamic>.from(destinationAddresses.map((x) => x)),
    "origin_addresses": List<dynamic>.from(originAddresses.map((x) => x)),
    "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
    "status": status,
  };
}

class Rows {
  Rows({
    this.elements,
  });

  List<Element> elements;

  factory Rows.fromJson(Map<String, dynamic> json) => Rows(
    elements: List<Element>.from(json["elements"].map((x) => Element.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
  };
}

class Element {
  Element({
    this.distance,
    this.duration,
    this.status,
  });

  Distance distance;
  Distance duration;
  String status;

  factory Element.fromJson(Map<String, dynamic> json) => Element(
    distance: Distance.fromJson(json["distance"]),
    duration: Distance.fromJson(json["duration"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance.toJson(),
    "duration": duration.toJson(),
    "status": status,
  };
}

class Distance {
  Distance({
    this.text,
    this.value,
  });

  String text;
  int value;

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
    text: json["text"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "value": value,
  };
}