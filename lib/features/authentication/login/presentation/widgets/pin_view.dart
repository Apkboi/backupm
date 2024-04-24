import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class PinView extends StatefulWidget {
  const PinView(
      {Key? key,
      required this.onDigitPressed,
      required this.onDelete,
      required this.onDone,
      required this.pinController,
      this.hasBiometric = false,
      required this.biometricAuthenticated,
      this.hasPinField = true,
      required this.onOutput,
      this.lastIconWidget,
      required this.onLastIconClicked,
      this.aspectRatio})
      : super(key: key);

  final Function(int) onDigitPressed;
  final VoidCallback onDelete;
  final Function(String) onDone;
  final Function(String) onLastIconClicked;
  final Function(int) onOutput;
  final Function(bool) biometricAuthenticated;
  final PINController pinController;
  final bool? hasBiometric;
  final bool? hasPinField;
  final double? aspectRatio;
  final Widget? lastIconWidget;

  @override
  State<PinView> createState() => _PinViewState();

// void onLastIconClicked() {}
}

class _PinViewState extends State<PinView> {
  String output = '';

  @override
  void initState() {
    // widget.pinController.resetPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PINController, PINState>(
      bloc: widget.pinController,
      listener: (context, state) {
        if (state is PINResetState) {
          output = '';
          widget.onOutput(output.length - 1);
          setState(() {});
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.hasPinField!
                ? SizedBox(
                    height: 30, child: PinDots(activeCount: output.length - 1))
                : 0.verticalSpace,
            widget.hasPinField! ? 40.verticalSpace : 0.verticalSpace,
            GridView.count(
                childAspectRatio: widget.aspectRatio ?? 1.5,
                padding: EdgeInsets.zero,
                // padding: const EdgeInsets.only(horizontal: 18,b: 6),
                // crossAxisSpacing: 10,
                // mainAxisSpacing: 8,

                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(
                    12,
                    (index) => index == 11 && widget.hasBiometric!
                        ? _getBioMetricButton()
                        : index == 9 && !widget.hasBiometric!
                            ? const SizedBox.shrink()
                            : Material(
                                shape: const StadiumBorder(),
                                color: Colors.transparent,
                                child: HapticInkWell(
                                  splashColor: Pallets.eggShell,
                                  borderRadius: BorderRadius.circular(100),
                                  // splashColor: Colors.red,
                                  // hoverColor: Colors.red,
                                  //
                                  // overlayColor:MaterialStateColor.resolveWith((states) => Colors.red) ,
                                  onTap: () {
                                    int number = index + 1;
                                    if (number != 10 &&
                                        number != 11 &&
                                        number != 12) {
                                      widget.onDigitPressed(number);
                                      if (output.length < 4) {
                                        output += number.toString();
                                      }
                                    } else if (number == 11) {
                                      widget.onDigitPressed(0);
                                      if (output.length < 4) {
                                        output += '0';
                                      }
                                    } else if (number == 10) {
                                      widget.onDelete();
                                      if (output.isNotEmpty) {
                                        output = output.substring(
                                            0, output.length - 1);
                                      }
                                    }
                                    setState(() {
                                      if (output.length == 4) {
                                        logger.i('Done');
                                        widget.onDone(output);
                                      }
                                    });

                                    widget.onOutput(output.length - 1);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: index == 9
                                            ? ImageWidget(
                                                imageUrl: Assets
                                                    .images.svgs.backspace,
                                                size: 20,
                                              )
                                            : Text(
                                                index == 10
                                                    ? '0'
                                                    : '${index + 1}',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontSize: 25.sp,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onBackground,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              )),
                                  ),
                                ),
                              )).toList()),
          ],
        );
      },
    );
  }

  Widget _getBioMetricButton() {
    return FutureBuilder(
        future: Future.value(true),
        // future: StorageHelper.getBoolean(StorageKeys.biometricEnabled, false),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!
                ? IconButton(
                    onPressed: () {
                      widget.onLastIconClicked(output);
                      _authenticateWithBioMetric();
                    },
                    icon: widget.lastIconWidget ??
                        ImageWidget(imageUrl: Assets.images.svgs.biometricBtn))
                : const SizedBox();
          }

          return const SizedBox();
        });
  }

  Future<void> _authenticateWithBioMetric() async {
    // var res =
    //     await injector.get<BiometricService>().authenticateWithBiometric();
    // res.fold((left) => AppUtils.showCustomToast(left),
    //     (right) => widget.biometricAuthenticated(right));
  }
}

class PinDots extends StatefulWidget {
  final int activeCount;

  const PinDots({Key? key, required this.activeCount}) : super(key: key);

  @override
  State<PinDots> createState() => _PinDotsState();
}

class _PinDotsState extends State<PinDots> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: List.generate(
          4,
          (index) => !(index <= widget.activeCount)
              ? Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: Pallets.borderGrey),
                  ),
                )
              : Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: Pallets.borderGrey),
                  ),
                  child: const Text(
                    '⬤',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
        ).toList(),
      ),
    );
  }
}

class PINController extends Cubit<PINState> {
  PINController() : super(PINInitialState());

  void resetPin() {
    emit(PINResetState(''));
  }
}

abstract class PINState {}

class PINInitialState extends PINState {
  List<Object?> get props => [];
}

class PINResetState extends PINState {
  final String pin;

  PINResetState(this.pin);

  List<Object?> get props => [pin];
}
