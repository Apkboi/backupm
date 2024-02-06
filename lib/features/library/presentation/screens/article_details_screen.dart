import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/library/presentation/widgets/favorite_acction_button.dart';
import 'package:mentra/gen/assets.gen.dart';

import 'package:flutter_html/flutter_html.dart';

class ArticleDetailsScreen extends StatefulWidget {
  const ArticleDetailsScreen({Key? key, required this.courseJson})
      : super(key: key);
  final String courseJson;

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  late LibraryCourse course;
  final libraryBloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    course = LibraryCourse.fromJson(jsonDecode(widget.courseJson));
    libraryBloc.add(GetCourseDetailEvent(course.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: course.title,
        actions: [
          FavoriteActionButton(
            favourite: course.favourite,
            id: course.id.toString(),
          ),
          10.horizontalSpace,
        ],
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
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
                        onTap: () {
                          libraryBloc
                              .add(GetCourseDetailEvent(course.id.toString()));
                        },
                      );
                    }
                    if (state is GetCourseDetailsSuccessState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: course.title,
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
                                    'Updated ${TimeUtil.formatDate(course.updatedAt.toIso8601String())}',
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
                              const TextView(
                                text: '4 Mins read',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          24.verticalSpace,
                          ImageWidget(
                            imageUrl: Assets.images.pngs.article.path,
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
                          Html(data: course.body, style: {
                            "p": Style(
                                fontSize: FontSize(
                                  15.sp,
                                  Unit.px,
                                ),
                                fontWeight: FontWeight.w500),
                          }),
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
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listenToLibraryBloc(BuildContext context, WellnessLibraryState state) {}
}
