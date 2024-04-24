import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';

import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';

import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/presentation/widgets/change_therapist_chat/change_therapist_message_box.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MatchTherapistScreen extends StatefulWidget {
  const MatchTherapistScreen({
    super.key,
    required this.updatedPreference,
  });

  final bool updatedPreference;

  @override
  State<MatchTherapistScreen> createState() => _MatchTherapistScreenState();
}

class _MatchTherapistScreenState extends State<MatchTherapistScreen> {
  final _formKey = GlobalKey<FormState>();

  final _bloc = TherapyBloc(injector.get());

  @override
  void initState() {
    _bloc.add(MatchTherapistEvent(updatedPreference: widget.updatedPreference));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<TherapyBloc, TherapyState>(
        listener: (context, state) {},
        builder: (context, state) {
          final messages = context.watch<TherapyBloc>().changeTherapistMessages;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: state is TherapistAcceptedState
                ? SizedBox(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: CustomNeumorphicButton(
                        onTap: () {
                          injector.get<UserBloc>().add(GetRemoteUser());
                          context.pushReplacementNamed(PageUrl.therapyScreen);
                        },
                        color: Pallets.primary,
                        text: 'Done',
                      ),
                    ),
                  )
                : 0.verticalSpace,
            body: Stack(
              children: [
                const AppBg(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: CustomBackButton(
                                onTap: () {
                                  if (state is TherapistAcceptedState) {
                                    injector
                                        .get<UserBloc>()
                                        .add(GetRemoteUser());
                                    context.pushReplacementNamed(
                                        PageUrl.therapyScreen);
                                  } else {
                                    context.pop();
                                  }
                                },
                              )),
                          16.verticalSpace,
                          if (messages.isNotEmpty)
                            Expanded(
                                child: ScrollablePositionedList.builder(
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              itemScrollController:
                                  context.read<TherapyBloc>().scrollController,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return ChangeTherapistMessageBox(
                                    message: messages.reversed.toList()[index]);
                              },
                            )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    // log('message');
    if (_formKey.currentState!.validate()) {}
  }
}
