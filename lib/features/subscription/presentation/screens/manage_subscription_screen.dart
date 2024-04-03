import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/subscription/presentation/widget/plan_features_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class ManageSubscriptionScreen extends StatefulWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  State<ManageSubscriptionScreen> createState() =>
      _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: '',
        actions: [],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        bloc: injector.get(),
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              AppBg(
                image: Assets.images.pngs.homeBg.path,
              ),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: 'Current Plan',
                      style: GoogleFonts.fraunces(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Pallets.primaryDark),
                    ),
                    16.verticalSpace,
                    Expanded(
                      child: PlanDetailsItem(
                          isPreview: true,
                          plan: injector
                              .get<UserBloc>()
                              .appUser!
                              .activeSubscription!
                              .plan),
                    ),
                    10.verticalSpace,
                  ],
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
