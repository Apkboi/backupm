import 'dart:convert';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
import 'package:mentra/features/journal/data/models/get_prompts_response.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';

class JournalItem extends StatefulWidget {
  const JournalItem({super.key, required this.journal});

  final GuidedJournal journal;

  @override
  State<JournalItem> createState() => _JournalItemState();
}

class _JournalItemState extends State<JournalItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return HapticInkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 6, right: 10, left: 16, bottom: 12.h),
            decoration: BoxDecoration(
                color: Pallets.white.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Row(
              children: [
                Expanded(
                    child: TextView(
                  text: TimeUtil.formDateTimeForJournal(
                      (widget.journal.createdAt as DateTime).toLocal()),
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
                                PathParam.journal:
                                    jsonEncode(widget.journal.toJson())
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
                          _delete(widget.journal.id.toString(), context);
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
          ),
          Container(
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            width: 1.sw,
            decoration: const BoxDecoration(
                color: Pallets.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                _PromptWidget(
                  prompt: widget.journal.guidedPrompt,
                ),
                12.verticalSpace,
                TextView(
                  text: widget.journal.body,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                  textOverflow: TextOverflow.ellipsis,
                  maxLines: widget.journal.body.toString().length > 6
                      ? isExpanded
                          ? widget.journal.body.toString().length ~/ 5
                          : 2
                      : null,
                )
              ],
            ),
          ),
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

  final JournalPrompt? prompt;

  @override
  Widget build(BuildContext context) {
    return prompt != null
        ? Container(
            width: 1.sw,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: prompt?.category.backgroundColor.toString().toColor(),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: prompt!.category.title.toString(),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Pallets.navy,
                ),
                9.verticalSpace,

                Html(shrinkWrap: true, data: prompt!.content, style: {
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
                //   fontSize: 15,
                //   text: prompt!.content.toString(),
                //   fontWeight: FontWeight.w600,
                //   color: Pallets.navy,
                // ),
              ],
            ),
          )
        : 0.verticalSpace;
  }
}
