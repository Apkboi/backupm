import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
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
import 'package:mentra/features/library/presentation/widgets/audio_player_widget.dart';
import 'package:mentra/features/library/presentation/widgets/favorite_acction_button.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:flutter_html/flutter_html.dart';

class AudioArticleScreen extends StatefulWidget {
  const AudioArticleScreen({Key? key, required this.courseJson})
      : super(key: key);
  final String courseJson;

  @override
  State<AudioArticleScreen> createState() => _AudioArticleScreenState();
}

class _AudioArticleScreenState extends State<AudioArticleScreen> {
  late LibraryCourse course;
  late AudioPlayer player = AudioPlayer();
  final libraryBloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    super.initState();

    course = LibraryCourse.fromJson(jsonDecode(widget.courseJson));
    libraryBloc.add(GetCourseDetailEvent(course.id.toString()));

    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await player.setSource(
      //     UrlSource(course.attachments!.first.file.url));
      await player.setSource(
          UrlSource("https://webaudioapi.com/samples/audio-tag/chrono.mp3"));
      // await player.resume();
    });
  }


  @override
  void dispose() {
    // Release all sources and dispose the player.
    player.dispose();

    super.dispose();
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
                              TextView(
                                text: "${course.readTime ?? '4 Mins'} read",
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          24.verticalSpace,
                          ImageWidget(
                            imageUrl: course.cover?.url ??
                                Assets.images.pngs.videoThumbail.path,
                            height: 213.h,
                            // fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(10),
                            width: 1.sw,
                          ),
                          24.verticalSpace,

                          Html(data: state.response.data.body, style: {
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
                          }),
                          AudioPlayerWidget(player: player),
                          29.verticalSpace,
                          // AudioPlayerWidget(player: player)
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
