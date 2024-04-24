import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/data/models/get_prompts_category_endpoint.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class PromptCategoryItem extends StatelessWidget {
  const PromptCategoryItem({super.key, required this.category});

  final PromptCategory category;

  @override
  Widget build(BuildContext context) {
    return HapticInkWell(
      onTap: () {
        context.pushNamed(PageUrl.guidedPromptScreen,
            queryParameters: {PathParam.id: category.id.toString()});
        // context.pop();
        // context.pushNamed(PageUrl.createJournalScreen,
        //     queryParameters: {PathParam.prompt: jsonEncode(prompt.toJson())});
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: category.backgroundColor.toString().toColor(),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextView(
                    text: category.title,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Pallets.primary,
                  ),
                ),
                CircleAvatar(
                  foregroundColor: Pallets.primary,
                  backgroundColor: Pallets.white.withOpacity(0.5),
                  radius: 13.r,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                  ),
                )
              ],
            ),

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
