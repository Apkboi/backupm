import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_tabbar.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/library/presentation/widgets/article_item.dart';
import 'package:mentra/features/library/presentation/widgets/library_item.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/gen/assets.gen.dart';

class WellnessLibraryScreen extends StatefulWidget {
  const WellnessLibraryScreen({Key? key}) : super(key: key);

  @override
  State<WellnessLibraryScreen> createState() => _WellnessLibraryScreenState();
}

final bloc = SettingsBloc(injector.get());

class _WellnessLibraryScreenState extends State<WellnessLibraryScreen> {
  @override
  void initState() {
    super.initState();
  }

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
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  children: [
                    // 100.h.verticalSpace,
                    const CustomTabbar(tabs: [
                      Tab(
                        text: "Discover",
                      ),
                      Tab(text: "Favorites"),
                    ]),
                    20.verticalSpace,
                    const Expanded(
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                          DiscoverContents(),
                          FavoriteContents()
                        ])),
                    8.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteContents extends StatefulWidget {
  const FavoriteContents({super.key});

  @override
  State<FavoriteContents> createState() => _FavoriteContentsState();
}

class _FavoriteContentsState extends State<FavoriteContents>
    with AutomaticKeepAliveClientMixin {
  // final bloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    injector.get<WellnessLibraryBloc>().add(const GetFavouriteCoursesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<WellnessLibraryBloc, WellnessLibraryState>(
      bloc: injector.get(),
      buildWhen: _buildWhen,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetFavouritesLoadingState) {
          return Center(
            child: CustomDialogs.getLoading(size: 50, color: Pallets.primary),
          );
        }

        if (state is GetFavouritesFailureState) {
          return AppPromptWidget(
            retryTextColor: Pallets.navy,
            textColor: Pallets.navy,
            onTap: () {
              injector
                  .get<WellnessLibraryBloc>()
                  .add(const GetFavouriteCoursesEvent());
            },
          );
        }

        if (state is GetFavouritesSuccessState) {
          if (state.response.data.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                injector
                    .get<WellnessLibraryBloc>()
                    .add(const GetFavouriteCoursesEvent());
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.response.data.length,
                itemBuilder: (context, index) {
                  return ArticleItem(
                    course: state.response.data[index],
                  );
                },
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                injector
                    .get<WellnessLibraryBloc>()
                    .add(const GetFavouriteCoursesEvent());
              },
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: const [
                    AppEmptyState(
                      hasBg: false,
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            );
          }
        }

        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool _buildWhen(WellnessLibraryState previous, WellnessLibraryState current) {
    return current is GetFavouritesSuccessState ||
        current is GetFavouritesFailureState ||
        current is GetFavouritesLoadingState;
  }
}

class DiscoverContents extends StatefulWidget {
  const DiscoverContents({super.key});

  @override
  State<DiscoverContents> createState() => _DiscoverContentsState();
}

class _DiscoverContentsState extends State<DiscoverContents>
    with AutomaticKeepAliveClientMixin {
  // final bloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    if (injector.get<WellnessLibraryBloc>().libraryCategories == null) {
      injector.get<WellnessLibraryBloc>().add(GetLibraryCategoriesEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WellnessLibraryBloc, WellnessLibraryState>(
      bloc: injector.get(),
      buildWhen: _buildWhen,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetLibraryCategoriesLoadingState) {
          return Center(
            child: CustomDialogs.getLoading(size: 50, color: Pallets.primary),
          );
        }

        if (state is GetLibraryCategoriesFailureState) {
          return AppPromptWidget(
            retryTextColor: Pallets.navy,
            textColor: Pallets.navy,
            onTap: () {
              injector
                  .get<WellnessLibraryBloc>()
                  .add(GetLibraryCategoriesEvent());
            },
          );
        }

        if (injector.get<WellnessLibraryBloc>().libraryCategories?.isNotEmpty ??
            false) {
          return RefreshIndicator(
            onRefresh: () async {
              injector
                  .get<WellnessLibraryBloc>()
                  .add(GetLibraryCategoriesEvent());
            },
            child: AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: injector
                        .get<WellnessLibraryBloc>()
                        .libraryCategories
                        ?.length ??
                    0,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          duration: const Duration(milliseconds: 300),
                          child: LibraryItem(
                            category: injector
                                .get<WellnessLibraryBloc>()
                                .libraryCategories![index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              injector
                  .get<WellnessLibraryBloc>()
                  .add(GetLibraryCategoriesEvent());
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: const [
                  AppEmptyState(
                    hasBg: false,
                  ),
                  // Spacer(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool _buildWhen(WellnessLibraryState previous, WellnessLibraryState current) {
    return current is GetLibraryCategoriesFailureState ||
        current is GetLibraryCategoriesLoadingState ||
        current is GetLibraryCategoriesSuccessState;
  }
}
