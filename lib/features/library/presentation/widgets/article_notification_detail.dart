import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/notification/data/models/get_notifications_response.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ArticleNotificationDetailsSheet extends StatefulWidget {
  final MentraNotification notification;

  const ArticleNotificationDetailsSheet({
    super.key,
    required this.notification,
  });

  @override
  State<ArticleNotificationDetailsSheet> createState() =>
      _ArticleNotificationDetailsSheetState();
}

class _ArticleNotificationDetailsSheetState
    extends State<ArticleNotificationDetailsSheet> {
  final libraryBloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    libraryBloc.add(GetCourseDetailEvent(widget.notification.dataId.toString() ?? '0'));
    super.initState();
  }

  // static final MesiboUI _mesiboUi = MesiboUI();

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      transitionBackgroundColor: Pallets.bottomSheetColor,
      // backgroundColor: Pallets.bottomSheetColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            20.verticalSpace,
            Expanded(
              child: BlocConsumer<WellnessLibraryBloc, WellnessLibraryState>(
                bloc: libraryBloc,
                listener: _listenToLibraryBloc,
                builder: (context, state) {
                  if (state is GetCourseDetailsLoadingState) {
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: CustomDialogs.getLoading(
                            size: 50, color: Pallets.primary),
                      ),
                    );
                  }
                  if (state is GetCourseDetailsFailureState) {
                    return AppPromptWidget(
                      retryTextColor: Pallets.navy,
                      textColor: Pallets.navy,
                      message: state.error,
                      onTap: () {
                        libraryBloc.add(GetCourseDetailEvent(
                            widget.notification.dataId.toString()));
                      },
                    );
                  }
                  if (state is GetCourseDetailsSuccessState) {
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                  text: state.response.data.title,
                                  style: GoogleFonts.fraunces(
                                      fontSize: 32.sp, fontWeight: FontWeight.w600),
                                ),
                                20.verticalSpace,
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextView(
                                      text:
                                          'Updated ${TimeUtil.formatDate(state.response.data.updatedAt.toIso8601String())}',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(width: 11),
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1, color: Color(0xFF99BEB7)),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 11),
                                    TextView(
                                      text:
                                          "${state.response.data.readTime ?? '4 Mins'} read",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                                24.verticalSpace,
                                ImageWidget(
                                  imageUrl: state.response.data.attachments!
                                          .firstOrNull?.file.url ??
                                      Assets.images.pngs.videoThumbail.path,
                                  height: 213.h,
                                  // fit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(10),
                                  width: 1.sw,
                                ),
                                24.verticalSpace,
                                // TextView(
                                //   text: '1. Deep Breathing',
                                //   style: GoogleFonts.fraunces(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                                // 16.verticalSpace,
                                SizedBox(
                                  height: 100,
                                  child: Html(
                                    data: state.response.data.body,
                                    style: {
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
                                          height: Height(15),
                                          fontWeight: FontWeight.w500),
                                    },
                                  ),
                                ),
                                29.verticalSpace,
                                // TextView(
                                //   text: '2. Mindfulness Meditation',
                                //   style: GoogleFonts.fraunces(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                                // 16.verticalSpace,
                                // const TextView(
                                //   text:
                                //       'When anxiety hits, try deep breathing exercises. Inhale slowly for a count of four, hold for four, and exhale for four. This can help calm your nervous system.',
                                // ),
                              ],
                            ),
                          ),
                        ),
                        CustomNeumorphicButton(
                          onTap: () {
                            context.pushNamed(PageUrl.articleDetailsScreen, queryParameters: {
                              PathParam.libraryCourse: jsonEncode(state.response.data.toJson())
                            });
                          },
                          color: Pallets.primary,
                          text: 'Learn More',
                        )
                      ],
                    );
                  }

                  return Container();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _listenToLibraryBloc(BuildContext context, WellnessLibraryState state) {}
}
