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
