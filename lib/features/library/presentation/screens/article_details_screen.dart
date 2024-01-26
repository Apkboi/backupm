import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/gen/assets.gen.dart';

class ArticleDetailsScreen extends StatefulWidget {
  const ArticleDetailsScreen({Key? key, required this.categoryJson})
      : super(key: key);
  final String categoryJson;

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  late LibraryCategory category;

  @override
  void initState() {
    category = LibraryCategory.fromJson(jsonDecode(widget.categoryJson));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        actions: [
          const CircleAvatar(
            backgroundColor: Pallets.white,
            child: Icon(
              Icons.favorite_border,
              color: Pallets.black,
              size: 18,
            ),
          ),
          10.horizontalSpace,
        ],
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                120.verticalSpace,
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
                TextView(
                  text: '1. Deep Breathing',
                  style: GoogleFonts.fraunces(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                16.verticalSpace,
                const TextView(
                  text:
                      'When anxiety hits, try deep breathing exercises. Inhale slowly for a count of four, hold for four, and exhale for four. This can help calm your nervous system.',
                ),
                29.verticalSpace,
                TextView(
                  text: '2. Mindfulness Meditation',
                  style: GoogleFonts.fraunces(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                16.verticalSpace,
                const TextView(
                  text:
                      'When anxiety hits, try deep breathing exercises. Inhale slowly for a count of four, hold for four, and exhale for four. This can help calm your nervous system.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
