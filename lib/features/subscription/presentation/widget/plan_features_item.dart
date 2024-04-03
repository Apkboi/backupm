import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/confirm_sheet.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/subscription/data/models/card_details_payload.dart';
import 'package:mentra/features/subscription/data/models/get_plans_response.dart';
import 'package:mentra/features/subscription/data/models/subscription_payload.dart';
import 'package:mentra/features/subscription/presentation/bloc/subscription_bloc/subscription_bloc.dart';

import 'card_details_sheet.dart';

class PlanDetailsItem extends StatefulWidget {
  const PlanDetailsItem(
      {super.key, required this.plan, this.isPreview = false});

  final SubscriptionPlan plan;
  final bool? isPreview;

  @override
  State<PlanDetailsItem> createState() => _PlanDetailsItemState();
}

class _PlanDetailsItemState extends State<PlanDetailsItem> {
  final _bloc = injector.get<SubscriptionBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        bloc: injector.get(),
        listener: _listenToSubscriptionBloc,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 1.sw,
                        // color: Pallets.grey,

                        decoration: ShapeDecoration(
                            // color: Pallets.white,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Pallets.white,
                                ),
                                borderRadius: BorderRadius.circular(20))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 25,
                              sigmaY: 25,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  30.verticalSpace,
                                  if (widget.plan.name
                                          .toString()
                                          .toLowerCase() !=
                                      'free')
                                    TextView(
                                      text: (!widget.isPreview! &&
                                              widget.plan.isActiveSubscription)
                                          ? 'Current Plan'
                                          : widget.plan.name,
                                      style: GoogleFonts.fraunces(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Pallets.lightSecondary,
                                      ),
                                    ),
                                  5.verticalSpace,
                                  TextView(
                                    text: widget.plan.name
                                                .toString()
                                                .toLowerCase() ==
                                            'free'
                                        ? 'FREE'
                                        : '${widget.plan.price} AED/month',
                                    style: GoogleFonts.fraunces(
                                        color: Pallets.primary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),

                                    // fontSize: 18,
                                    // color: Pallets.lightSecondary,
                                    // fontWeight: FontWeight.w700
                                  ),
                                  10.verticalSpace,
                                  if (widget.plan.description != null)
                                    TextView(
                                        text: widget.plan.description ?? '',
                                        color: Pallets.navy,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  10.verticalSpace,
                                  ...List.generate(
                                      widget.plan.benefits.length,
                                      (index) => PlanFeature(
                                            benefit:
                                                widget.plan.benefits[index],
                                          )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget.isPreview!)
                Column(
                  children: [
                    if (!widget.plan.isActiveSubscription)
                      Column(
                        children: List.generate(widget.plan.durations.length,
                            (index) {
                          if (widget.plan.price == 0) {
                            return 0.verticalSpace;
                          }
                          if (widget.plan.durations[index].frequency ==
                              'Monthly') {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: widget.plan.durations.length > 1
                                      ? 10
                                      : 20),
                              child: CustomOutlinedButton(
                                radius: 100,
                                bgColor: Pallets.white,
                                outlinedColr: Pallets.primary,
                                padding: const EdgeInsets.all(12),
                                child: TextView(
                                  align: TextAlign.center,
                                  text:
                                      'Subscribe Monthly\n(${widget.plan.durations[index].price} AED/month)',
                                  fontWeight: FontWeight.w600,
                                ),
                                onPressed: () {
                                  _subscribe(
                                      context, widget.plan.durations[index]);
                                },
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomNeumorphicButton(
                                onTap: () {
                                  // _subscribe(context);
                                  _subscribe(
                                      context, widget.plan.durations[index]);
                                },
                                color: Pallets.primary,
                                padding: const EdgeInsets.all(12),
                                text:
                                    "Subscribe Annually\n(AED ${widget.plan.durations[index].price}/year, Save 20%)",
                              ),
                            );
                          }
                        }),
                      ),
                    if (widget.plan.isActiveSubscription &&
                        widget.plan.price != 0)
                      TextButton(
                          onPressed: () {
                            _cancelSubscription(context);
                          },
                          child: const TextView(
                            fontSize: 16,
                            text: 'Cancel Subscription',
                            fontWeight: FontWeight.w600,
                            color: Pallets.black80,
                          )),
                  ],
                ),
              if (widget.isPreview!)
                CustomNeumorphicButton(
                    text: "Change Plan",
                    onTap: () {
                      context.pushNamed(PageUrl.selectPlanScreen);
                    },
                    color: Pallets.primary),
              27.verticalSpace
            ],
          );
        },
      ),
    );
  }

  void _subscribe(BuildContext context, PlanDuration duration) async {
    // log(widget.plan.id.toString());
    final SubscriptionCard? cardDetails = await CustomDialogs.showBottomSheet(
      context,
      const CardDetailsSheet(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      )),
    );

    if (cardDetails != null) {
      SubscriptionPayload payload = SubscriptionPayload(
          planId: widget.plan.id,
          planDurationId: duration.id,
          cardOwnerName: cardDetails.cardOwnerName,
          cardNumber: cardDetails.cardNumber,
          cardExpMonth: 12,
          cardExpYear: 34,
          cardCvc: 122);
      _bloc.add(SubscribeEvent(payload));
    }
  }

  void _listenToSubscriptionBloc(
      BuildContext context, SubscriptionState state) {}

  void _cancelSubscription(BuildContext context) {
    CustomDialogs.showBottomSheet(
        context,
        ConfirmSheet(
          tittle: 'Are you sure you want to cancel your subscription?',
          confirmText: "Cancel Subscription",
          cancelText: "No, Keep Subscription",
          subtittle:
              "You'll lose access to premium features and your subscription benefits will end on [Subscription End Date]. Your account will revert to the free plan.",
          onConfirm: () {
            context.pop();
          },
          onCancel: () {
            context.pop();
          },
        ));
  }
}

class PlanFeature extends StatelessWidget {
  const PlanFeature({super.key, required this.benefit});

  final Benefit benefit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Pallets.lightSecondary,
            size: 24,
          ),
          8.horizontalSpace,
          Expanded(
              child: TextView(
            text: benefit.title,
            fontSize: 16,
          ))
        ],
      ),
    );
  }
}
