// // To parse this JSON data, do
// //
// //     final searchLocationResponse = searchLocationResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:fops/common/models/app_location_model.dart';
// import 'package:fops/core/helpers/app_enums.dart';
//
// // import 'package:shap_shap_customer/common/models/app_location_model.dart';
// // import 'package:shap_shap_customer/core/helpers/app_enums.dart';
//
// SearchLocationResponse searchLocationResponseFromJson(String str) =>
//     SearchLocationResponse.fromJson(json.decode(str));
//
// String searchLocationResponseToJson(SearchLocationResponse data) =>
//     json.encode(data.toJson());
//
// class SearchLocationResponse {
//   SearchLocationResponse({
//     required this.htmlAttributions,
//     required this.results,
//     required this.status,
//   });
//
//   List<dynamic> htmlAttributions;
//   List<Result> results;
//   String status;
//
//   SearchLocationResponse copyWith({
//     List<dynamic>? htmlAttributions,
//     List<Result>? results,
//     String? status,
//   }) =>
//       SearchLocationResponse(
//         htmlAttributions: htmlAttributions ?? this.htmlAttributions,
//         results: results ?? this.results,
//         status: status ?? this.status,
//       );
//
//   factory SearchLocationResponse.fromJson(Map<String, dynamic> json) =>
//       SearchLocationResponse(
//         htmlAttributions:
//             List<dynamic>.from(json["html_attributions"].map((x) => x)),
//         results:
//             List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//         "status": status,
//       };
// }
//
// class Result {
//   Result({
//     required this.formattedAddress,
//     required this.geometry,
//     required this.icon,
//     required this.iconBackgroundColor,
//     required this.iconMaskBaseUri,
//     required this.name,
//     this.photos,
//     required this.placeId,
//     required this.reference,
//     required this.types,
//   });
//
//   String formattedAddress;
//   Geometry geometry;
//   String icon;
//   String iconBackgroundColor;
//   String iconMaskBaseUri;
//   String name;
//   List<Photo>? photos;
//   String placeId;
//   String reference;
//   List<String> types;
//
//   Result copyWith({
//     String? formattedAddress,
//     Geometry? geometry,
//     String? icon,
//     String? iconBackgroundColor,
//     String? iconMaskBaseUri,
//     String? name,
//     List<Photo>? photos,
//     String? placeId,
//     String? reference,
//     List<String>? types,
//   }) =>
//       Result(
//         formattedAddress: formattedAddress ?? this.formattedAddress,
//         geometry: geometry ?? this.geometry,
//         icon: icon ?? this.icon,
//         iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
//         iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
//         name: name ?? this.name,
//         photos: photos ?? this.photos,
//         placeId: placeId ?? this.placeId,
//         reference: reference ?? this.reference,
//         types: types ?? this.types,
//       );
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         formattedAddress: json["formatted_address"],
//         geometry: Geometry.fromJson(json["geometry"]),
//         icon: json["icon"],
//         iconBackgroundColor: json["icon_background_color"],
//         iconMaskBaseUri: json["icon_mask_base_uri"],
//         name: json["name"],
//         photos: json["photos"] != null
//             ? List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x)))
//             : null,
//         placeId: json["place_id"],
//         reference: json["reference"],
//         types: List<String>.from(json["types"].map((x) => x)),
//       );
//
//   AppLocationModel toAppLocationModel() => AppLocationModel(
//       lat: geometry.location.lat,
//       lng: geometry.location.lng,
//       name: name,
//       isSuggestion: false,
//       formattedAddress: formattedAddress,
//       locationType: LocationType.none,
//       state: '',
//       city: '');
//
//   Map<String, dynamic> toJson() => {
//         "formatted_address": formattedAddress,
//         "geometry": geometry.toJson(),
//         "icon": icon,
//         "icon_background_color": iconBackgroundColor,
//         "icon_mask_base_uri": iconMaskBaseUri,
//         "name": name,
//         "photos": photos == null
//             ? List<dynamic>.from(photos!.map((x) => x.toJson()))
//             : null,
//         "place_id": placeId,
//         "reference": reference,
//         "types": List<dynamic>.from(types.map((x) => x)),
//       };
// }
//
// class Geometry {
//   Geometry({
//     required this.location,
//     required this.viewport,
//   });
//
//   Location location;
//   Viewport viewport;
//
//   Geometry copyWith({
//     Location? location,
//     Viewport? viewport,
//   }) =>
//       Geometry(
//         location: location ?? this.location,
//         viewport: viewport ?? this.viewport,
//       );
//
//   factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
//         location: Location.fromJson(json["location"]),
//         viewport: Viewport.fromJson(json["viewport"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "location": location.toJson(),
//         "viewport": viewport.toJson(),
//       };
// }
//
// class Location {
//   Location({
//     required this.lat,
//     required this.lng,
//   });
//
//   double lat;
//   double lng;
//
//   Location copyWith({
//     double? lat,
//     double? lng,
//   }) =>
//       Location(
//         lat: lat ?? this.lat,
//         lng: lng ?? this.lng,
//       );
//
//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//         lat: json["lat"].toDouble(),
//         lng: json["lng"].toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lng": lng,
//       };
// }
//
// class Viewport {
//   Viewport({
//     required this.northeast,
//     required this.southwest,
//   });
//
//   Location northeast;
//   Location southwest;
//
//   Viewport copyWith({
//     Location? northeast,
//     Location? southwest,
//   }) =>
//       Viewport(
//         northeast: northeast ?? this.northeast,
//         southwest: southwest ?? this.southwest,
//       );
//
//   factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
//         northeast: Location.fromJson(json["northeast"]),
//         southwest: Location.fromJson(json["southwest"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "northeast": northeast.toJson(),
//         "southwest": southwest.toJson(),
//       };
// }
//
// class Photo {
//   Photo({
//     required this.height,
//     required this.htmlAttributions,
//     required this.photoReference,
//     required this.width,
//   });
//
//   int height;
//   List<String> htmlAttributions;
//   String photoReference;
//   int width;
//
//   Photo copyWith({
//     int? height,
//     List<String>? htmlAttributions,
//     String? photoReference,
//     int? width,
//   }) =>
//       Photo(
//         height: height ?? this.height,
//         htmlAttributions: htmlAttributions ?? this.htmlAttributions,
//         photoReference: photoReference ?? this.photoReference,
//         width: width ?? this.width,
//       );
//
//   factory Photo.fromJson(Map<String, dynamic> json) => Photo(
//         height: json["height"],
//         htmlAttributions:
//             List<String>.from(json["html_attributions"].map((x) => x)),
//         photoReference: json["photo_reference"],
//         width: json["width"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "height": height,
//         "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
//         "photo_reference": photoReference,
//         "width": width,
//       };
// }
