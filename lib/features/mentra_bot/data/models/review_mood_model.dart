import 'package:mentra/gen/assets.gen.dart';

class ReviewMoodModel {
  String avatar;
  String mood;

  ReviewMoodModel({required this.avatar, required this.mood});

  static List<ReviewMoodModel> get allMoods => [
        ReviewMoodModel(avatar: Assets.images.pngs.moody.path, mood: 'Moody'),
        ReviewMoodModel(avatar: Assets.images.pngs.normal.path, mood: 'Normal'),
        ReviewMoodModel(avatar: Assets.images.pngs.happy.path, mood: 'Happy'),
      ];
}
