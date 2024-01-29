import 'package:mentra/features/library/data/models/get_course_details_response.dart';
import 'package:mentra/features/library/data/models/get_favourite_courses_response.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/features/library/data/models/update_favourites_endpoints.dart';

abstract class WellnessLibraryRepository {
  Future<GetLibraryCategoriesResponse> getLibraryCategories();

  Future<GetLibraryCoursesResponse> getLibraryCourses(String id);

  Future<GetCourseDetailsResponse> getCourseDetails(String id);

  Future<UpdateFavouriteResponse> updateFavourite(String id);

  Future<GetFavoutiteCoursesResponse> getFavouriteCourses();
}
