import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.videoArticleScreen);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Pallets.white),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ImageWidget(
              imageUrl: Assets.images.pngs.article.path,
              height: 126.h,
              // fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(16),
              width: 126.w,
            ),
            16.horizontalSpace,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: 'Journaling for Anxiety\nManagement',
                  fontWeight: FontWeight.w600,
                ),
                2.verticalSpace,
                const TextView(
                  text: 'Video 1h~15m',
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
