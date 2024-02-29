import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/confirm_sheet.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/data/models/get_journals_response.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';

class JournalItem extends StatelessWidget {
  const JournalItem({super.key, required this.journal});

  final GuidedJournal journal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Pallets.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: TextView(
                text: TimeUtil.formDateTimeForJournal(journal.createdAt),
                fontSize: 13.sp,
              )),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 160),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      onTap: () {
                        context.pushNamed(PageUrl.createJournalScreen,
                            queryParameters: {
                              PathParam.journal: jsonEncode(journal.toJson())
                            });
                      },
                      child: Row(
                        children: [
                          ImageWidget(
                            imageUrl: Assets.images.svgs.editFilled,
                            color: Pallets.black,
                            size: 20,
                          ),
                          8.horizontalSpace,
                          const TextView(
                            text: 'Edit',
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      )),
                  PopupMenuItem(
                      onTap: () {
                        _delete(journal.id.toString(), context);
                      },
                      child: Row(
                        children: [
                          ImageWidget(
                            imageUrl: Assets.images.svgs.delete,
                            color: Pallets.black,
                            size: 20,
                          ),
                          8.horizontalSpace,
                          const TextView(
                            text: 'Delete',
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      )),
                ],
                child: const Icon(Icons.more_vert),
              )
            ],
          ),
          16.verticalSpace,
          _PromptWidget(
            prompt: journal.guidedPrompt,
          ),
          12.verticalSpace,
          TextView(
            text: journal.body,
            fontWeight: FontWeight.w500,
            lineHeight: 1.5,
          )
        ],
      ),
    );
  }

  _delete(String id, BuildContext context) {
    CustomDialogs.showBottomSheet(
        context,
        ConfirmSheet(
          tittle: 'Are you sure you want to delete this journal entry?',
          confirmText: "Yes, I understand. Delete it",
          subtittle:
              "Deleting this entry will permanently remove it from your journal. You won't be able to recover it. Are you sure you want to proceed?",
          onConfirm: () {
            context.pop();
            injector.get<JournalBloc>().add(DeleteJournalsEvent(id: id));
          },
          onCancel: () {
            context.pop();
          },
        ));
  }
}

class _PromptWidget extends StatelessWidget {
  const _PromptWidget({super.key, this.prompt});

  final GuidedPrompt? prompt;

  @override
  Widget build(BuildContext context) {
    return prompt != null
        ? Container(
            width: 1.sw,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Pallets.promptMilkCOlor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: prompt!.title.toString(),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Pallets.navy,
                ),
                16.verticalSpace,
                TextView(
                  text: prompt!.content.toString(),
                  fontWeight: FontWeight.w600,
                  color: Pallets.navy,
                ),
              ],
            ),
          )
        : 0.verticalSpace;
  }
}
