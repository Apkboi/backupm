part of 'google_map_bloc.dart';

// Base class for Google Map states
abstract class GoogleMapState extends Equatable {
  const GoogleMapState();
}

class GoogleMapInitial extends GoogleMapState {
  @override
  List<Object?> get props => [];
}

// Loading state for searching a place on Google Maps
class SearchPlaceLoading extends GoogleMapState {
  @override
  List<Object?> get props => [];
}

// Success state for searching a place on Google Maps
class SearchPlaceSuccess extends GoogleMapState {
  final dynamic placeResult;

  SearchPlaceSuccess(this.placeResult);

  @override
  List<Object?> get props => [placeResult];
}

// Failure state for searching a place on Google Maps
class SearchPlaceFailure extends GoogleMapState {
  final String error;

  SearchPlaceFailure(this.error);

  @override
  List<Object?> get props => [error];
}
