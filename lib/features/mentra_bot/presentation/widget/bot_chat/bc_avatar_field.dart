import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/avatar_selector_widget.dart';

class BCAvatarField extends StatefulWidget {
  const BCAvatarField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BCAvatarField> createState() => _BCAvatarFieldState();
}

class _BCAvatarFieldState extends State<BCAvatarField> {
  String? selectedAvatar;
  String? selectedUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Pallets.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          )),
      child: Column(
        children: [
          SizedBox(
            height: 0.4.sh,
            child: AvartarSelector(
              onBackgroundSelector: (p0) {},
              onAvatarSelected: (p0) {
                setState(() {
                  selectedAvatar = p0.image.id.toString();
                  selectedUrl = p0.image.url;
                });
              },
            ),
          ),
          CustomNeumorphicButton(
              onTap: () {
                _continue(context);
                // _goToNextScreen(context);
              },
              color: Pallets.primary,
              text: "Continue"),
        ],
      ),
    );
  }

  void _continue(BuildContext context) {
    if (selectedAvatar != null) {
      injector.get<RegistrationBloc>().updateFields(avatarPath: selectedAvatar);

      logger.i(selectedAvatar);
      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: "*******",
          nextFlow: BotChatFlow.signup,
          answerWidget: ImageWidget(
            imageUrl: selectedUrl!,
            size: 25,
          ),
          // answerWidget:Container(height: 100,width: 100,color: Colors.red,),
          nextSignupStage: SignupStage.EMAIL_MESSAGE);

      // context.pushNamed(PageUrl.selectYearScreen);
      // context.pushNamed(PageUrl.signupOptionScreen);
    } else {
      CustomDialogs.showToast('Please select an avatar');
    }
  }
}
