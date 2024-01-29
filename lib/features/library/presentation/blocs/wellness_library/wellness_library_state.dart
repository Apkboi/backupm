part of 'wellness_library_bloc.dart';

abstract class WellnessLibraryState extends Equatable {
  const WellnessLibraryState();
}

class WellnessLibraryInitial extends WellnessLibraryState {
  @override
  List<Object> get props => [];
}

class GetLibraryCategoriesLoadingState extends WellnessLibraryState {
  @override
  List<Object?> get props => [];
}

class GetLibraryCategoriesFailureState extends WellnessLibraryState {
  final String error;

  const GetLibraryCategoriesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetLibraryCoursesLoadingState extends WellnessLibraryState {
  @override
  List<Object?> get props => [];
}

class GetLibraryCoursesFailureState extends WellnessLibraryState {
  final String error;

  const GetLibraryCoursesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetLibraryCategoriesSuccessState extends WellnessLibraryState {
  final GetLibraryCategoriesResponse response;

  const GetLibraryCategoriesSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetLibraryCoursesSuccessState extends WellnessLibraryState {
  final GetLibraryCoursesResponse response;

  const GetLibraryCoursesSuccessState({required this.response});
  @override
  List<Object?> get props => [response];
}



class GetFavouritesFailureState extends WellnessLibraryState {
  final String error;

  const GetFavouritesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetFavouritesSuccessState extends WellnessLibraryState {
  final GetFavoutiteCoursesResponse response;

  const GetFavouritesSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetFavouritesLoadingState extends WellnessLibraryState {

  const GetFavouritesLoadingState();
  @override
  List<Object?> get props => [];
}

class UpdateFavouritesFailureState extends WellnessLibraryState {
  final String error;

  const UpdateFavouritesFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateFavouritesSuccessState extends WellnessLibraryState {
  final UpdateFavouriteResponse response;

  const UpdateFavouritesSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class UpdateFavouritesLoadingState extends WellnessLibraryState {

  const UpdateFavouritesLoadingState();
  @override
  List<Object?> get props => [];
}


class GetCourseDetailsFailureState extends WellnessLibraryState {
  final String error;

  const GetCourseDetailsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetCourseDetailsSuccessState extends WellnessLibraryState {
  final GetCourseDetailsResponse response;

  const GetCourseDetailsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetCourseDetailsLoadingState extends WellnessLibraryState {

  const GetCourseDetailsLoadingState();
  @override
  List<Object?> get props => [];
}




