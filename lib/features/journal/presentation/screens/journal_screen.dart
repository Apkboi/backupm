import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTile: false,
        // canGoBack: false,
        leading: 0.horizontalSpace,
        leadingWidth: 0,
        tittle: TextView(
          text: 'Therapy',
          style: GoogleFonts.fraunces(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Pallets.primaryDark),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.goNamed(PageUrl.menuScreen);
            },
            child: CircleAvatar(
              backgroundColor: Pallets.white,
              radius: 25,
              child: ImageWidget(imageUrl: Assets.images.svgs.menuIcon),
            ),
          ),
          16.horizontalSpace,
        ],
      ),
      body: const Stack(
        children: [
          SafeArea(
              child: Column(
            children: [],
          )),
        ],
      ),
    );
  }
}
