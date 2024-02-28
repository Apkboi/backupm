import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/permission_handler/permission_handler_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/widgets/cancel_session_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_date_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_time_sheet.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

class TherapyDetailsSheet extends StatefulWidget {
  const TherapyDetailsSheet({super.key, required this.session});

  final TherapySession session;

  @override
  State<TherapyDetailsSheet> createState() => _TherapyDetailsSheetState();
}

class _TherapyDetailsSheetState extends State<TherapyDetailsSheet> {
  static final MesiboUI _mesiboUi = MesiboUI();

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      transitionBackgroundColor: Pallets.bottomSheetColor,
      // backgroundColor: Pallets.bottomSheetColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              ImageWidget(
                imageUrl: widget.session.therapist.user.avatar,
                height: 64.h,
                width: 64.w,
                borderRadius: BorderRadius.circular(30),
              ),
              6.verticalSpace,
              TextView(
                text: widget.session.focus,
                style: GoogleFonts.fraunces(
                    color: Pallets.navy,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600),
              ),
              8.verticalSpace,
              TextView(
                  text: 'Session with ${widget.session.therapist.user.name}',
                  color: Pallets.brandColor,
                  fontWeight: FontWeight.w600),
              17.verticalSpace,
              Row(
                children: [
                  CustomNeumorphicButton(
                      fgColor: Pallets.black,
                      padding: const EdgeInsets.all(10),
                      onTap: () async {
                        // injector.get<MesiboCubit>().startGroupCall();
                        _startMessaging();
                        // context.pushNamed(PageUrl.therapistChatScreen);
                      },
                      text: "Message ${widget.session.therapist.user.name}",
                      color: Pallets.milkColor),
                  8.horizontalSpace,
                  CustomOutlinedButton(
                    bgColor: Colors.white,
                    outlinedColr: Pallets.primary,
                    padding: const EdgeInsets.all(10),
                    radius: 148,
                    child: const TextView(
                      text: 'Cancel Session',
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      _cancelTherapySession(context);
                    },
                  ),
                ],
              ),
              48.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                      text: 'Status',
                      color: Pallets.ink,
                    ),
                    TextView(
                      text: widget.session.status,
                      color: Pallets.mildOrange,
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                          text: 'Date',
                          color: Pallets.ink,
                        ),
                        TextView(
                          text: TimeUtil.formatDate(
                              widget.session.startsAt.toIso8601String()),
                          // color: Pallets.mildOrange,
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                          text: 'Time',
                          color: Pallets.ink,
                        ),
                        TextView(
                          text: TimeUtil.formatTime(widget.session.startsAt),
                          // color: Pallets.mildOrange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: 'Your notes',
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    TextView(
                      text: widget.session.note ?? '',
                    ),
                  ],
                ),
              ),
              77.verticalSpace,
              Center(
                child: CustomNeumorphicButton(
                  onTap: () {
                    _reScheduleTherapy(context);
                  },
                  color: Pallets.primary,
                  expanded: false,
                  text: "Reschedule Session",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _reScheduleTherapy(BuildContext context) {
    // context.pop();
    injector.get<TherapyBloc>().currentSessionFlow = SessionFlow.reSchedule;
    CustomDialogs.showCupertinoBottomSheet(context, SelectDateSheet(
      onSelected: (DateTime selectedDate) {
        injector.get<TherapyBloc>().updatePayload(
            date: selectedDate, sessionId: widget.session.id.toString());

        CustomDialogs.showCupertinoBottomSheet(
          context,
          SelectTimeSheet(
            date: selectedDate,
          ),
        );
      },
    ), useRootNavigator: true);
  }

  void _cancelTherapySession(BuildContext context) async {
    final bool? canceled = await CustomDialogs.showCupertinoBottomSheet(
      context,
      CancelSessionSheet(
        session: widget.session,
      ),
    );

    if (canceled ?? false) {
      context.pop();
    }
  }

  void _startMessaging() {
    launchMessage();
  }

  void launchMessage() async {
    PermissionHandlerService().requestPermission(Permission.microphone);
    PermissionHandlerService().requestPermission(Permission.mediaLibrary);
    PermissionHandlerService().requestPermission(Permission.camera);
    logger.i(widget.session.therapist.user.mesiboUserToken);

    MesiboProfile pro = MesiboProfile(
        groupId: 0,
        uid: int.parse(widget.session.therapist.user.mesiboUserId),
        selfProfile: false,
        hash_id: 0);
    MesiboProfile profile = await Mesibo()
        .getUserProfile(widget.session.therapist.user.email);
    profile.setImageUrl(widget.session.therapist.user.avatar);
    // profile.address = ;
    profile.save();
    logger.i(widget.session.therapist.user.mesiboUserToken);
    // profile.setImagePath(widget.session.therapist.user.avatar);
    // profile.address = widget.session.therapist.user.avatar;
    _mesiboUi.getUiDefaults().then((MesiboUIOptions options) {
      options.enableBackButton = true;
      options.appName = "Mentra";
      options.toolbarColor = 0xff00868b;
      options.onlineIndicationTitle = 'Online';
      options.statusBarColor = Pallets.primary.value;
      options.toolbarColor = Pallets.primary.value;
      options.offlineIndicationTitle = 'Offline';
      options.emptyMessageListMessage = 'No messages here';
      _mesiboUi.setUiDefaults(options);
    });

    MesiboUIButtons buttons = MesiboUIButtons();
    buttons.message = true;
    buttons.audioCall = false;
    buttons.videoCall = false;
    buttons.groupAudioCall = false;
    buttons.groupVideoCall = false;
    buttons.endToEndEncryptionInfo = true; // e2// ee should be enabled
    _mesiboUi.setupBasicCustomization(buttons, null);
    _mesiboUi.launchMessaging(profile);
  }
}
