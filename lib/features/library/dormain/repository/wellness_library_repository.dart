import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';

abstract class WellnessLibraryRepository {
  Future<GetLibraryCategoriesResponse> getLibraryCategories();
  Future<GetLibraryCoursesResponse> getLibraryCourses(String id);
}
