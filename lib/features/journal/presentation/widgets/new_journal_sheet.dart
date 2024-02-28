import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/presentation/widgets/guided_prompt_item.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NewJournalSheet extends StatelessWidget {
  const NewJournalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoScaffold(body: Container()),
        CupertinoScaffold(
          transitionBackgroundColor: Pallets.bottomSheetColor,
          // backgroundColor: Pallets.bottomSheetColor,
          // topRadius: Radius.circular(50),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Pallets.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                16.verticalSpace,
                CustomNeumorphicButton(onTap: () {}, color: Pallets.primary,child: Row(children: [
                  ImageWidget(imageUrl: Assets.images.svgs.editFilled),
                  5.horizontalSpace,
                  const TextView(text: 'Blank Entry',color: Pallets.white,fontWeight: FontWeight.w600,)
                ],),),
                20.verticalSpace,
                const TextView(
                  text: 'Guided Prompts',
                  fontSize: 16,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w600,
                ),
                20.verticalSpace,
                Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GuidedPromptsItem(),
                  ),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
