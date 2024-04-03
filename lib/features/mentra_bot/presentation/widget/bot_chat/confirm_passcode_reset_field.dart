import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/gen/assets.gen.dart';

enum PinMode {
  setPin,
  confirmPin,
}

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = PINController();
  PinMode pinMode = PinMode.setPin;
  int activeCount = -1;
  String pin = '';
  String conFirmPin = '';
  final _bloc = PasswordResetBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AppBg(image: Assets.images.pngs.homeBg.path),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
                  bloc: _bloc,
                  listener: _listenToPasswordResetBloc,
                  builder: (context, state) {
                    return InputBar(
                      inputType: TextInputType.number,
                      hint: "Enter passcode",
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Enter passcode'),
                        MaxLengthValidator(4,
                            errorText: 'Passcode should be a 4 digit number'),
                        MinLengthValidator(4,
                            errorText: 'Passcode should be a 4 digit number'),
                      ]).call,
                      onAnswer: (answer) {
                        if (injector.get<RegistrationBloc>().confirmPasscode(answer)) {
                          injector.get<RegistrationBloc>().updateFields(password: answer);
// logger.i(injector.get<RegistrationBloc>().registrationPayload.toJson());
                          _registrationBloc.add(RegisterEvent(
                              payload:
                              injector.get<RegistrationBloc>().registrationPayload));


                        } else {
                          context.read<BotChatCubit>().revertBack();
                          CustomDialogs.error('Password mismatch');
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _listenToPasswordResetBloc(
      BuildContext context, PasswordResetState state) {
    if (state is ResetPasswordLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ResetPasswordSuccessState) {
      injector.get<RegistrationBloc>().clear();

      context.pop();
      context.pushNamed(PageUrl.biometricAccess);
    }

    if (state is ResetPasswordFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }

  void _registerUser() {
    injector.get<RegistrationBloc>().updateFields(password: conFirmPin);
    // logger.i(injector.get<RegistrationBloc>().registrationPayload.toJson());
    _bloc.add(const ResetPasswordEvent(hashKey: '', password: ''));
  }
}









