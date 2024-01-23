import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class VideoArticleScreen extends StatefulWidget {
  const VideoArticleScreen({Key? key}) : super(key: key);

  @override
  State<VideoArticleScreen> createState() => _VideoArticleScreenState();
}

class _VideoArticleScreenState extends State<VideoArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          NestedScrollView(
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
                    child: InkWell(
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
                    InkWell(
                      onTap: () {
                        // context.pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Pallets.white,
                        child: Icon(
                          Icons.favorite_border,
                          color: Pallets.black,
                          size: 18,
                        ),
                      ),
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
                                context.pushNamed(PageUrl.videoPlayerScreen);
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
                              text: '5 Everyday Strategies to Reduce Anxiety',
                              style: GoogleFonts.fraunces(
                                  fontSize: 32.sp, fontWeight: FontWeight.w600),
                            ),
                            20.verticalSpace,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const TextView(
                                  text: 'Updated December 5, 2023',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(width: 11),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
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
          ),
        ],
      ),
    );
  }
}
