import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapist_about_widget.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapist_review_widget.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapists_spcialization_widget.dart';
import 'package:mentra/gen/assets.gen.dart';

class AcceptTherapistScreen extends StatefulWidget {
  const AcceptTherapistScreen({super.key, required this.suggestedTherapist});

  final SuggestedTherapist suggestedTherapist;

  @override
  State<AcceptTherapistScreen> createState() => _AcceptTherapistScreenState();
}

class _AcceptTherapistScreenState extends State<AcceptTherapistScreen> {
  final _bloc = TherapyBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TherapyBloc, TherapyState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is AcceptTherapistLoadingState) {
          CustomDialogs.showLoading(context);
        }
        if (state is AcceptTherapistSuccessState) {
          CustomDialogs.success(state.response.message);
          context.pop();
          context.pop(true);
        }
        if (state is AcceptTherapistFailureState) {
          context.pop();
          CustomDialogs.error(state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: 100,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: CustomNeumorphicButton(
                    onTap: () {
                      _bloc.add(SelectTherapistEvent(
                          therapistUserId:
                              widget.suggestedTherapist.user.id.toString()));
                    },
                    color: Pallets.primary,
                    text: 'Accept',
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: CustomOutlinedButton(
                    radius: 100,
                    outlinedColr: Pallets.grey1,
                    padding: const EdgeInsets.all(20),
                    child: const Text('Match again'),
                    onPressed: () {
                      context.pop(false);
                    },
                  ),
                )
              ],
            ),
          ),
          body: Stack(
            children: [
              AppBg(
                image: Assets.images.pngs.homeBg.path,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 100.verticalSpace,
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 300,
                              width: 1.sw,
                              decoration: BoxDecoration(
                                  color: Pallets.primary,
                                  image: DecorationImage(
                                      image: NetworkImage(widget
                                          .suggestedTherapist.user.avatar))),
                              child: const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 60.0, left: 16),
                                  child: CustomBackButton(),
                                ),
                              ),
                            ),
                            150.verticalSpace
                          ],
                        ),
                        Positioned(
                          bottom: 30,
                          right: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Container(
                                width: 1.sw,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: Pallets.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextView(
                                      text: widget.suggestedTherapist.user.name,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    10.verticalSpace,
                                    TextView(
                                        align: TextAlign.center,
                                        text:
                                            '${widget.suggestedTherapist.therapist.field ?? widget.suggestedTherapist.therapist.certifications ?? (widget.suggestedTherapist.therapist.techniquesOfExpertise).firstOrNull.toString()}'),
                                    16.verticalSpace,
                                    InkWell(
                                      onTap: () {
                                        logger.i(
                                            widget.suggestedTherapist.toJson());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Pallets.pendingColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.star_rounded,
                                                color: Pallets.pendingColor,
                                                size: 13,
                                              ),
                                              const TextView(
                                                text: ' 4.7',
                                                color: Pallets.pendingColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              16.verticalSpace,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextView(
                              text: 'About Nour',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            16.verticalSpace,
                            TherapistAboutWidget(
                                therapist: widget.suggestedTherapist),
                            16.verticalSpace,
                            const TextView(
                              text: 'Specializations',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            16.verticalSpace,
                            TherapistSpecializationWidget(
                              suggestedTherapist: widget.suggestedTherapist,
                            ),
                            16.verticalSpace,
                            const TextView(
                              text: 'Reviews',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            16.verticalSpace,
                            const TherapistsReviewWidget()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
