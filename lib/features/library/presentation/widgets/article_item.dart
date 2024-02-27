import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/gen/assets.gen.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.course});

  final LibraryCourse course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (course.courseType == 'Video') {
          context.pushNamed(PageUrl.videoArticleScreen,
              queryParameters: {PathParam.id: course.id.toString()});
        } else {
          context.pushNamed(PageUrl.articleDetailsScreen, queryParameters: {
            PathParam.libraryCourse: jsonEncode(course.toJson())
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Pallets.white.withOpacity(0.9)),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              height: 126.h,
              width: 126.w,
              child: Stack(
                children: [
                  ImageWidget(
                    imageUrl: course.attachments?.firstOrNull?.file.url ??Assets.images.pngs.article.path,
                    height: 126.h,
                    // fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(16),
                    width: 126.w,
                  ),
                  // course.courseType == 'Video'
                  //     ? const Center(
                  //         child: Icon(
                  //           Icons.play_arrow_rounded,
                  //           size: 50,
                  //           color: Pallets.white,
                  //         ),
                  //       )
                  //     : 0.horizontalSpace
                ],
              ),
            ),
            16.horizontalSpace,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: course.title,
                  fontWeight: FontWeight.w600,
                ),
                2.verticalSpace,
                const TextView(
                  // text: course.courseType == 'text' ? 'Article' : 'Video',
                  text: 'Article',
                  fontSize: 13,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
