part of 'wellness_library_bloc.dart';

abstract class WellnessLibraryEvent extends Equatable {
  const WellnessLibraryEvent();
}



class GetLibraryCategoriesEvent extends WellnessLibraryEvent {

  @override
  List<Object?> get props => [];
}

class GetLibraryCoursesEvent extends WellnessLibraryEvent {
  final String id;

  const GetLibraryCoursesEvent(this.id);

  @override
  List<Object?> get props => [];
}



