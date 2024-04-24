import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/subscription/presentation/bloc/subscription_bloc/subscription_bloc.dart';
import 'package:mentra/features/subscription/presentation/widget/plan_features_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class SelectPlanScreen extends StatefulWidget {
  const SelectPlanScreen({Key? key}) : super(key: key);

  @override
  State<SelectPlanScreen> createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  final _bloc = injector.get<SubscriptionBloc>();

  @override
  void initState() {
    _bloc.add(GetPlansEvent());
    super.initState();
  }

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
            children: [
              Expanded(
                child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
                  bloc: _bloc,
                  listener: (context, state) {
                    logger.i(state.runtimeType.toString());
                    if (state is SubscriptionLoadingState) {
                      CustomDialogs.showLoading(context);
                    }

                    if (state is SubscriptionFailureState) {
                      context.pop();
                      CustomDialogs.error(state.error);
                    }

                    if (state is SubscribeSuccessState) {
                      context.pop();
                      context.pop();
                      CustomDialogs.success('Payment successful.');
                    }
                  },
                  builder: (context, state) {
                    if (state is GetPlansLoadingState) {
                      return Center(
                        child: CustomDialogs.getLoading(size: 30),
                      );
                    }
                    if (state is GetPlansFailureState) {
                      return Center(
                        child: AppPromptWidget(
                          onTap: () {
                            _bloc.add(GetPlansEvent());
                          },
                        ),
                      );
                    }
                    if (state is GetPlansSuccessState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          100.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextView(
                              text: 'Select Plan',
                              style: GoogleFonts.fraunces(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                            ),
                          ),
                          39.verticalSpace,
                          Expanded(
                            flex: 1,
                            child: PageView.builder(
                              itemCount: state.response.data.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: PlanDetailsItem(
                                    plan: state.response.data[index]),
                              ),
                              padEnds: true,
                              controller:
                                  PageController(viewportFraction: 0.88),
                            ),
                          )
                        ],
                      );
                    }
                    return 0.verticalSpace;
                  },
                  buildWhen: _buildWhen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _buildWhen(SubscriptionState previous, SubscriptionState current) {
    return current is GetPlansLoadingState ||
        current is GetPlansFailureState ||
        current is GetPlansSuccessState;
  }
}
