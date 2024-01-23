import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_tabbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/presentation/widgets/article_item.dart';
import 'package:mentra/features/library/presentation/widgets/library_item.dart';
import 'package:mentra/gen/assets.gen.dart';


class WellnessLibraryScreen extends StatefulWidget {
  const WellnessLibraryScreen({Key? key}) : super(key: key);

  @override
  State<WellnessLibraryScreen> createState() => _WellnessLibraryScreenState();
}

class _WellnessLibraryScreenState extends State<WellnessLibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        centerTile: false,
        // canGoBack: false,
        leading: 0.horizontalSpace,
        leadingWidth: 0,
        tittle: TextView(
          text: 'Wellness Library',
          style:
              GoogleFonts.fraunces(fontSize: 32, fontWeight: FontWeight.w600),
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
      body: Stack(
        children: [
          const AppBg(),
          DefaultTabController(
            length: 2,
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                children: [
                  100.h.verticalSpace,
                  const CustomTabbar(tabs: [
                    Tab(
                      text: "Discover",
                    ),
                    Tab(text: "Favorites"),
                  ]),
                  20.verticalSpace,

                  const Expanded(
                      child: TabBarView(
                          physics: BouncingScrollPhysics(),
                          children: [DiscoverContents(), FavoriteContents()])),

                  8.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscoverContents extends StatefulWidget {
  const DiscoverContents({super.key});

  @override
  State<DiscoverContents> createState() => _DiscoverContentsState();
}

class _DiscoverContentsState extends State<DiscoverContents> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10),
      children: [
        LibraryItem(
          onTap: () {
            context.pushNamed(PageUrl.allArticlesScreen);
          },
          bgColor: Pallets.mildRed,
          text: 'Managing\nAnxiety',
          image: Assets.images.pngs.anxiety.path,
        ),
        10.verticalSpace,
        LibraryItem(
          onTap: () {
            context.pushNamed(PageUrl.allArticlesScreen);
          },
          bgColor: Pallets.subtleLight,
          text: 'Improve Sleep',
          image: Assets.images.pngs.sleep.path,
        ),
        10.verticalSpace,
        LibraryItem(
          onTap: () {
            context.pushNamed(PageUrl.allArticlesScreen);
          },
          bgColor: Pallets.mildOrange,
          text: 'Improve Productivity',
          image: Assets.images.pngs.productivity.path,
        ),
      ],
    );
  }
}

class FavoriteContents extends StatefulWidget {
  const FavoriteContents({super.key});

  @override
  State<FavoriteContents> createState() => _FavoriteContentsState();
}

class _FavoriteContentsState extends State<FavoriteContents> {
  @override
  Widget build(BuildContext context) {
    // return const Column(children: [
    //
    //   TherapyEmptyState()]);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: ArticleItem(),
      ),
    );
  }
}
