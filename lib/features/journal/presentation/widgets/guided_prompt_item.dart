import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/data/models/get_prompts_response.dart';

class GuidedPromptsItem extends StatelessWidget {
  const GuidedPromptsItem({super.key, required this.prompt});

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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Pallets.promptMilkCOlor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextView(
                    text: prompt.title,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Pallets.primary,
                  ),
                ),
                CircleAvatar(
                  foregroundColor: Pallets.primary,
                  backgroundColor: Pallets.white.withOpacity(0.5),
                  child: const Icon(
                    Icons.sync,
                    color: Pallets.primary,
                  ),
                )
              ],
            ),
            16.verticalSpace,
            TextView(
              text: prompt.content,
              fontWeight: FontWeight.w600,
              color: Pallets.primary,
            ),
          ],
        ),
      ),
    );
  }
}
