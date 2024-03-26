import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/library/presentation/widgets/article_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/gen/assets.gen.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({Key? key, required this.categoryJson})
      : super(key: key);
  final String categoryJson;

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  late LibraryCategory category;
  final _bloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    category = LibraryCategory.fromJson(jsonDecode(widget.categoryJson));
    _bloc.add(GetLibraryCoursesEvent(category.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: category.name,
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          Column(
            children: [
              100.verticalSpace,
              Expanded(
                  child:
                      BlocConsumer<WellnessLibraryBloc, WellnessLibraryState>(
                bloc: _bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetLibraryCoursesLoadingState) {
                    return Center(
                      child: CustomDialogs.getLoading(
                          size: 50, color: Pallets.primary),
                    );
                  }

                  if (state is GetLibraryCoursesFailureState) {
                    return Column(
                      children: [
                        AppPromptWidget(
                          retryTextColor: Pallets.navy,
                          textColor: Pallets.navy,
                          onTap: () {
                            _bloc.add(
                                GetLibraryCoursesEvent(category.id.toString()));
                          },
                        ),
                      ],
                    );
                  }

                  if (state is GetLibraryCoursesSuccessState) {
                    if (state.response.data.isEmpty) {
                      return const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: AppEmptyState(
                              tittle: 'There are no articles here',
                              subtittle: '',
                            ),
                          ),
                        ],
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        _bloc.add(
                            GetLibraryCoursesEvent(category.id.toString()));
                      },
                      child: ListView.builder(
                        itemCount: state.response.data.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ArticleItem(
                              course: state.response.data[index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ))
            ],
          ),
        ],
      ),
    );
  }
}
