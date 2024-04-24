import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/data/models/library_courses_response.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/library/presentation/widgets/favorite_acction_button.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';


class VideoArticleScreen extends StatefulWidget {
  const VideoArticleScreen({super.key, required this.courseId});

  final String courseId;

  @override
  State<VideoArticleScreen> createState() => _VideoArticleScreenState();
}

class _VideoArticleScreenState extends State<VideoArticleScreen> {
  LibraryCourse? course;
  final libraryBloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    libraryBloc.add(GetCourseDetailEvent(widget.courseId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          BlocConsumer<WellnessLibraryBloc, WellnessLibraryState>(
            bloc: libraryBloc,
            listener: (context, state) {
              if (state is GetCourseDetailsSuccessState) {
                course = state.response.data;
                setState(() {});
              }
            },
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
                        .add(GetCourseDetailEvent(widget.courseId.toString()));
                  },
                );
              }

              if (state is GetCourseDetailsSuccessState) {
                return NestedScrollView(
                  // floatHeaderSlivers: true,

                  physics: const BouncingScrollPhysics(),

                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        // forceElevated: true,
                        collapsedHeight: 60,
                        expandedHeight: 300.h,
                        leadingWidth: 60,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HapticInkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Pallets.white,
                              child: Icon(
                                Icons.arrow_back,
                                color: Pallets.black,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          FavoriteActionButton(
                            favourite: state.response.data.favourite,
                            id: state.response.data.id.toString(),
                          ),
                          10.horizontalSpace,
                        ],
                        flexibleSpace: Stack(
                          children: [
                            Hero(
                              tag: 'image',
                              child: ImageWidget(
                                imageUrl: Assets.images.pngs.article.path,
                                height: 350.h,
                                width: 1.sw,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: Pallets.videoButtonColor.withOpacity(0.1),
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      context.pushNamed(
                                          PageUrl.videoPlayerScreen,
                                          queryParameters: {
                                            PathParam.libraryCourse:
                                                jsonEncode(course?.toJson())
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.play_circle_fill_rounded,
                                      size: 56,
                                      color: Pallets.videoButtonColor,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ];
                    // return
                  },
                  body: CustomScrollView(
                      // physics: const NeverScrollableScrollPhysics(),

                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  24.verticalSpace,
                                  TextView(
                                    text: state.response.data.title,
                                    style: GoogleFonts.fraunces(
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  20.verticalSpace,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                width: 1,
                                                color: Color(0xFF99BEB7)),
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                ],
                              ),
                            )
                          ]),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 16,
                          ),
                        ),
                      ]),
                );
              }

              return 0.verticalSpace;
            },
          ),
        ],
      ),
    );
  }
}
