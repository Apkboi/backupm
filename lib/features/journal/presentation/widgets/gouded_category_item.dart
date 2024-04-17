import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/data/models/get_prompts_response.dart';
import 'package:mentra/gen/assets.gen.dart';

class PromptCategoryItem extends StatelessWidget {
  const PromptCategoryItem({super.key, required this.prompt});

  final JournalPrompt prompt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        context.pushNamed(PageUrl.createJournalScreen,
            queryParameters: {PathParam.prompt: jsonEncode(prompt.toJson())});
      },
      child: Container(
        padding:
        const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
            color: prompt.backgroundColor.toString().toColor(),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextView(
                    text: prompt.title,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Pallets.primary,
                  ),
                ),
                CircleAvatar(
                  foregroundColor: Pallets.primary,
                  backgroundColor: Pallets.white.withOpacity(0.5),
                  radius: 12.r,
                  child: ImageWidget(
                    imageUrl: Assets.images.svgs.refreshIcon,
                  ),
                )
              ],
            ),
            12.verticalSpace,

            Html(shrinkWrap: true, data: prompt.content, style: {
              "p": Style(
                  fontSize: FontSize(
                    16.sp,
                    Unit.px,
                  ),
                  fontWeight: FontWeight.w400),
              "h4": Style(
                  fontSize: FontSize(
                    16.sp,
                    Unit.px,
                  ),
                  // height: Height(15),
                  fontWeight: FontWeight.w400),
            }),
            // TextView(
            //   text: prompt.content,
            //   fontSize: 16,
            //   fontWeight: FontWeight.w600,
            //   color: Pallets.primary,
            // ),
          ],
        ),
      ),
    );
  }
}
