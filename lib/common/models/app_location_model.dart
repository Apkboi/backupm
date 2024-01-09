// // To parse this JSON data, do
// //
// //     final appLocatioinModel = appLocatioinModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:fops/core/helpers/app_enums.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
//
//
//
// AppLocationModel appLocatioinModelFromJson(String str) =>
//     AppLocationModel.fromJson(json.decode(str));
//
// String appLocatioinModelToJson(AppLocationModel data) =>
//     json.encode(data.toJson());
//
// class AppLocationModel {
//   final double lat;
//   final double lng;
//   final String name;
//   final String formattedAddress;
//   final String state;
//   final String city;
//   final bool? isSuggestion;
//   final LocationType? locationType;
//
//   AppLocationModel({
//     required this.lat,
//     required this.lng,
//     required this.name,
//     required this.formattedAddress,
//     required this.state,
//     required this.city,
//     this.isSuggestion = false,
//     this.locationType,
//   });
//
//   AppLocationModel copyWith({
//     double? lat,
//     double? lng,
//     String? name,
//     String? formattedAddress,
//     String? state,
//     String? city,
//     LocationType? locationType,
//   }) =>
//       AppLocationModel(
//         lat: lat ?? this.lat,
//         lng: lng ?? this.lng,
//         name: name ?? this.name,
//         formattedAddress: formattedAddress ?? this.formattedAddress,
//         state: state ?? this.state,
//         city: city ?? this.city,
//         locationType: locationType ?? this.locationType,
//       );
//
//   factory AppLocationModel.fromJson(Map<String, dynamic> json) =>
//       AppLocationModel(
//         lat: json["lat"]?.toDouble(),
//         lng: json["lng"]?.toDouble(),
//         name: json["name"],
//         formattedAddress: json["formatted_address"],
//         state: json["state"],
//         city: json["city"],
//         locationType: json["location_type"] == null
//             ? null
//             : LocationType.fromJson(json["location_type"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lng": lng,
//         "name": name,
//         "formatted_address": formattedAddress,
//         "state": state,
//         "city": city,
//         "location_type": locationType?.toJson()
//       };
//
//   LatLng get toLatLng => LatLng(lat, lng);
//
// }
