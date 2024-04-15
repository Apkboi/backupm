import 'package:mentra/features/streaks/data/model/get_streaks_response.dart';

abstract class StreaksRepository {
  Future<GetStreaksResponse> getStreaks();
}
