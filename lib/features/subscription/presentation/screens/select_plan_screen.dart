import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/features/subscription/presentation/widget/plan_features_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class SelectPlanScreen extends StatefulWidget {
  const SelectPlanScreen({Key? key}) : super(key: key);

  @override
  State<SelectPlanScreen> createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        // leadingWidth: 80,

        tittleText: '',
      ),
      body: Stack(
        children: [
          AppBg(image: Assets.images.pngs.homeBg.path),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              100.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextView(
                  text: 'Select plan',
                  style: GoogleFonts.fraunces(
                      fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ),
              39.verticalSpace,
              Expanded(
                flex: 1,
                child: PageView(

                  controller: PageController(viewportFraction: 0.8),
                  children: const [
                    PlanDetailsItem(),
                    PlanDetailsItem(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
