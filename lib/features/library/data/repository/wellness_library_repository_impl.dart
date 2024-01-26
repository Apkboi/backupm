import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/features/library/dormain/repository/wellness_library_repository.dart';

class WellnessLibraryRepositoryImpl extends WellnessLibraryRepository {
  final NetworkService _networkService;

  WellnessLibraryRepositoryImpl(this._networkService);

  @override
  Future<GetLibraryCategoriesResponse> getLibraryCategories() async {
    final response = await _networkService.call(
        UrlConfig.getLibraryCategoriesEndpoint, RequestMethod.get);

    return GetLibraryCategoriesResponse.fromJson(response.data);
  }

  @override
  Future<GetLibraryCoursesResponse> getLibraryCourses(String id) async {
    final response = await _networkService.call(
        UrlConfig.getLibraryCoursesEndpoint, RequestMethod.get,
        queryParams: {"id": id});

    return GetLibraryCoursesResponse.fromJson(response.data);
  }
}
