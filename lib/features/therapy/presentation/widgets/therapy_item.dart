import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/widgets/join_session_button.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_details_sheet.dart';

class TherapyItem extends StatelessWidget {
  const TherapyItem({super.key, required this.session});

  final TherapySession session;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomDialogs.showCupertinoBottomSheet(
            context,
            TherapyDetailsSheet(
              session: session,
            ));
        // context.pushNamed(PageUrl.therapistChatScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const TherapyStatusIndicator(),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: session.focus,
                      fontSize: 16,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    ),
                    8.verticalSpace,
                    TextView(
                      text: 'Session with ${session.therapist.user.name}.',
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    TextView(
                      text: TimeUtil.formartToDayTime(session.startsAt.toLocal()),
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    SessionButton(
                      startDate: session.startsAt.toLocal(),
                      endDate: (session.endsAt ??
                              session.startsAt.add(const Duration(hours: 1)))
                          .toLocal(),
                      session: session,
                    )
                  ],
                ),
              ),
              ImageWidget(
                imageUrl: session.therapist.user.avatar,
                size: 45,
                borderRadius: BorderRadius.circular(30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TherapyStatusIndicator extends StatelessWidget {
  const TherapyStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(37),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Active
              colors: [Color(0xffd4f7e9), Color(0xffeffaf6)],
              // History
              // colors: [Color(0xffe0e3e7), Color(0xffe0e3e7)],
              // Awaiting
              // colors: [Color(0xffffdac1), Color(0xfffef3eb)],
            )));
  }
}
