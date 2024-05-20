import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/work_sheet/presentation/widgets/questionaire_field.dart';
import 'package:mentra/gen/assets.gen.dart';

class QuestionaireScreen extends StatefulWidget {
  const QuestionaireScreen({super.key, required this.id});

  final String id;

  @override
  State<QuestionaireScreen> createState() => _QuestionaireScreenState();
}

class _QuestionaireScreenState extends State<QuestionaireScreen> {
  final allControllers = List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Pallets.white,
        foregroundColor: Pallets.black,
        flexibleSpace: 20.verticalSpace,
        elevation: 0,
        centerTitle: true,
        leading: HapticInkWell(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImageWidget(
              imageUrl: Assets.images.svgs.arrowLeft,
              size: 16,
              height: 25,
              width: 25,
              onTap: () {
                context.pop();
              },
            ),
          ),
        ),
        title: const TextView(
          text: 'WorkSheet Name',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        children: [
          const AppBg(),
          Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: 4,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: QuestionaireField(
                      controller: allControllers[index], question: 'question'),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
