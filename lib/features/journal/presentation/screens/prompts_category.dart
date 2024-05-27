import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/features/journal/presentation/widgets/gouded_category_item.dart';
import 'package:mentra/features/journal/presentation/widgets/guided_prompt_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PromptsCategoryScreen extends StatefulWidget {
  const PromptsCategoryScreen({super.key});

  @override
  State<PromptsCategoryScreen> createState() => _PromptsCategoryScreenState();
}

class _PromptsCategoryScreenState extends State<PromptsCategoryScreen> {
  final _journalBloc = JournalBloc(injector.get());

  @override
  void initState() {
    _journalBloc.add(GetPromptsCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 23.0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomNeumorphicButton(
                      onTap: () {
                        context.pop();
                        context.pushNamed(
                          PageUrl.createJournalScreen,
                        );
                      },
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      color: Pallets.primary,
                      child: Row(
                        children: [
                          ImageWidget(imageUrl: Assets.images.svgs.editFilled,size: 18.w,),
                          5.horizontalSpace,
                          const TextView(
                            text: 'Blank Entry',
                            color: Pallets.white,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  const TextView(
                    text: 'Categories',
                    fontSize: 16,
                    color: Pallets.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  16.verticalSpace,
                  Expanded(
                      child: BlocConsumer<JournalBloc, JournalState>(
                    listener: _listenToJournalBloc,
                    bloc: _journalBloc,
                    builder: (context, state) {
                      if (state is GetPromptsCategoryLoadingState) {
                        return Center(
                          child: CustomDialogs.getLoading(size: 30),
                        );
                      }

                      if (state is GetPromptsCategoryFailureState) {
                        return Center(
                          child: AppPromptWidget(
                            onTap: () {
                              _journalBloc.add(GetPromptsCategoriesEvent());
                            },
                          ),
                        );
                      }

                      if (state is GetPromptsCategorySuccessState) {
                        if (state.response.data.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              _journalBloc.add(GetPromptsCategoriesEvent());
                            },
                            child: ListView.builder(
                              itemCount: state.response.data.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: PromptCategoryItem(
                                  category: state.response.data.reversed.toList()[index],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: () async {
                              _journalBloc.add(GetPromptsCategoriesEvent());
                            },
                            child: Center(
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                children: [
                                  AppEmptyState(
                                    hasBg: false,
                                    tittleColor: Pallets.black,
                                    image: Assets.images.pngs.journalNote.path,
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
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _listenToJournalBloc(BuildContext context, JournalState state) {}
}
