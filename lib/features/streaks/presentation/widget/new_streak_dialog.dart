import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';

class NewStreakDialog extends StatefulWidget {
  const NewStreakDialog({super.key});

  @override
  State<NewStreakDialog> createState() => _NewStreakDialogState();
}

class _NewStreakDialogState extends State<NewStreakDialog> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 5));
    Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
      () {
        _controller.play();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: Container(
          decoration: BoxDecoration(
              color: Pallets.bottomSheetColor,
              borderRadius: BorderRadius.circular(21)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              60.verticalSpace,
              TextView(
                text:
                    '${injector.get<UserBloc>().appUser?.badge?.duration ?? '0'}-day streak!',
                style: GoogleFonts.fraunces(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Pallets.currentStreakBg),
              ),
              20.verticalSpace,
              ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                // blastDirection: pi, // radial value - LEFT
                particleDrag: 0.05,
                // apply drag to the confetti
                emissionFrequency: 0.02,
                // how often it should emit
                numberOfParticles: 15,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                ],
              ),
              TextView(
                text: 'Congratulations 🎉',
                style: GoogleFonts.fraunces(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              6.verticalSpace,
              TextView(
                text: 'You are doing well',
                style: GoogleFonts.fraunces(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              41.verticalSpace,
              CustomNeumorphicButton(
                onTap: () {
                  context.pop();
                },
                color: Pallets.primary,
                text: 'Continue',
                // expanded: false,
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 15.h),
              ),
              30.verticalSpace,
            ],
          ),
        ));
  }
}
