part of 'google_map_bloc.dart';



// Base class for Google Map events
abstract class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();
}

// Event class for searching a place on Google Maps
class SearchPlaceEvent extends GoogleMapEvent {
  final String query;

  SearchPlaceEvent(this.query);

  @override
  List<Object?> get props => [query];
}
