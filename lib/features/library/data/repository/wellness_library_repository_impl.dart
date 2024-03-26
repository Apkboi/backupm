import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/library/data/models/get_course_details_response.dart';
import 'package:mentra/features/library/data/models/get_favourite_courses_response.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/features/library/data/models/update_favourites_endpoints.dart';
import 'package:mentra/features/library/dormain/repository/wellness_library_repository.dart';

class WellnessLibraryRepositoryImpl extends WellnessLibraryRepository {
  final NetworkService _networkService;

  WellnessLibraryRepositoryImpl(this._networkService);

  @override
  Future<GetLibraryCategoriesResponse> getLibraryCategories() async {
    try {
      final response = await _networkService.call(
          UrlConfig.getLibraryCategoriesEndpoint, RequestMethod.get);

      return GetLibraryCategoriesResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(stack);
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<GetLibraryCoursesResponse> getLibraryCourses(String id) async {
    try {
      final response = await _networkService.call(
          UrlConfig.getLibraryCoursesEndpoint, RequestMethod.get,
          queryParams: {"id": id});

      return GetLibraryCoursesResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(stack);
      logger.e(e.toString());
      rethrow;
    }
  }

  @override
  Future<UpdateFavouriteResponse> updateFavourite(String id) async {
    try {
      final response = await _networkService.call(
          UrlConfig.updateFavourite, RequestMethod.post,
          data: {"wellness_course_id": id});

      return UpdateFavouriteResponse.fromJson(response.data);
    } catch (e) {
      // TODO
      logger.e(e);

      rethrow;
    }
  }

  @override
  Future<GetCourseDetailsResponse> getCourseDetails(String id) async {
    final response = await _networkService.call(
      UrlConfig.getCourseDetails(id),
      RequestMethod.get,
    );

    return GetCourseDetailsResponse.fromJson(response.data);
  }

  @override
  Future<GetFavoutiteCoursesResponse> getFavouriteCourses() async {
    final response = await _networkService.call(
      UrlConfig.getFavourites,
      RequestMethod.get,
    );

    return GetFavoutiteCoursesResponse.fromJson(response.data);
  }
}
