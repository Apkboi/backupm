import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/library/presentation/widgets/article_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({Key? key}) : super(key: key);

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Managing Anxiety',
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
                  child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: ArticleItem(),
                  );
                },
              ))
            ],
          ),
        ],
      ),
    );
  }
}
