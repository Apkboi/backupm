// To parse this JSON data, do
//
//     final getDistanceResponse = getDistanceResponseFromJson(jsonString);

import 'dart:convert';

GetDistanceResponse getDistanceResponseFromJson(String str) =>
    GetDistanceResponse.fromJson(json.decode(str));

String getDistanceResponseToJson(GetDistanceResponse data) =>
    json.encode(data.toJson());

class GetDistanceResponse {
  GetDistanceResponse({
    required this.destinationAddresses,
    required this.originAddresses,
    required this.rows,
    required this.status,
  });

  final List<String> destinationAddresses;
  final List<String> originAddresses;
  final List<GetDistanceResults> rows;
  final String status;

  GetDistanceResponse copyWith({
    List<String>? destinationAddresses,
    List<String>? originAddresses,
    List<GetDistanceResults>? rows,
    String? status,
  }) =>
      GetDistanceResponse(
        destinationAddresses: destinationAddresses ?? this.destinationAddresses,
        originAddresses: originAddresses ?? this.originAddresses,
        rows: rows ?? this.rows,
        status: status ?? this.status,
      );

  factory GetDistanceResponse.fromJson(Map<String, dynamic> json) =>
      GetDistanceResponse(
        destinationAddresses:
            List<String>.from(json["destination_addresses"].map((x) => x)),
        originAddresses:
            List<String>.from(json["origin_addresses"].map((x) => x)),
        rows: List<GetDistanceResults>.from(
            json["rows"]?.map((x) => GetDistanceResults.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "destination_addresses":
            List<dynamic>.from(destinationAddresses.map((x) => x)),
        "origin_addresses": List<dynamic>.from(originAddresses.map((x) => x)),
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
        "status": status,
      };

  double? getDistanceInKm() {
    var kmString = rows.first.elements
        .where((element) => element.distance != null)
        .firstOrNull
        ?.distance
        ?.text
        .replaceAll("km", "")
        .trim();

    if (kmString != null) {
      return double.parse(kmString);
    }

    return null;
  }
}

class GetDistanceResults {
  GetDistanceResults({
    required this.elements,
  });

  final List<GetDistanceResult> elements;

  GetDistanceResults copyWith({
    List<GetDistanceResult>? elements,
  }) =>
      GetDistanceResults(
        elements: elements ?? this.elements,
      );

  factory GetDistanceResults.fromJson(Map<String, dynamic> json) =>
      GetDistanceResults(
        elements: List<GetDistanceResult>.from(
            json["elements"].map((x) => GetDistanceResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
      };
}

class GetDistanceResult {
  GetDistanceResult({
    required this.distance,
    required this.duration,
    required this.status,
  });

  final Distance? distance;
  final Distance? duration;
  final String status;

  GetDistanceResult copyWith({
    Distance? distance,
    Distance? duration,
    String? status,
  }) =>
      GetDistanceResult(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        status: status ?? this.status,
      );

  factory GetDistanceResult.fromJson(Map<String, dynamic> json) =>
      GetDistanceResult(
        distance: json["distance"] == null
            ? null
            : Distance.fromJson(json["distance"]),
        duration: json["duration"] == null
            ? null
            : Distance.fromJson(json["duration"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance?.toJson(),
        "duration": duration?.toJson(),
        "status": status,
      };
}

class Distance {
  Distance({
    required this.text,
    required this.value,
  });

  final String text;
  final int value;

  Distance copyWith({
    String? text,
    int? value,
  }) =>
      Distance(
        text: text ?? this.text,
        value: value ?? this.value,
      );

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
      };
}
