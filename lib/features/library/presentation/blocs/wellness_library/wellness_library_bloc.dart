import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/features/library/dormain/repository/wellness_library_repository.dart';

part 'wellness_library_event.dart';

part 'wellness_library_state.dart';

class WellnessLibraryBloc
    extends Bloc<WellnessLibraryEvent, WellnessLibraryState> {
  final WellnessLibraryRepository _wellnessLibraryRepository;

  List<LibraryCategory> libraryCategories = [];

  WellnessLibraryBloc(this._wellnessLibraryRepository)
      : super(WellnessLibraryInitial()) {
    on<GetLibraryCategoriesEvent>(_mapGetLibraryCategoriesEventToState);
    on<GetLibraryCoursesEvent>(_mapGetLibraryCoursesEventToState);
  }

  Future<void> _mapGetLibraryCategoriesEventToState(
      GetLibraryCategoriesEvent event,
      Emitter<WellnessLibraryState> emit) async {
    emit(GetLibraryCategoriesLoadingState());

    try {
      final response = await _wellnessLibraryRepository.getLibraryCategories();

      libraryCategories = response.data;
      emit(GetLibraryCategoriesSuccessState(response: response));
    } catch (e) {
      emit(GetLibraryCategoriesFailureState(error: e.toString()));
    }
  }

  Future<void> _mapGetLibraryCoursesEventToState(
      GetLibraryCoursesEvent event, Emitter<WellnessLibraryState> emit) async {
    emit(GetLibraryCoursesLoadingState());

    try {
      final courses = await _wellnessLibraryRepository
          .getLibraryCourses(event.id.toString());
      emit(GetLibraryCoursesSuccessState(response: courses));
    } catch (e) {
      emit(GetLibraryCoursesFailureState(error: e.toString()));
    }
  }

// ... (rest of the code remains unchanged)
}
