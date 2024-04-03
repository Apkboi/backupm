import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/dashboard/presentation/widget/sos_dialer_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class EmergencySosScreen extends StatefulWidget {
  const EmergencySosScreen({super.key});

  @override
  State<EmergencySosScreen> createState() => _EmergencySosScreenState();
}

class _EmergencySosScreenState extends State<EmergencySosScreen> {
  final _bloc = DashboardBloc(injector.get());

  @override
  void initState() {
    _bloc.add(GetEmergencyContactsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      extendBody: true,
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(17),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(
      //               25,
      //             ),
      //             color: Pallets.white.withOpacity(0.6)),
      //         child: const Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      //           child: TextView(
      //               fontSize: 16,
      //               fontWeight: FontWeight.w600,
      //               text:
      //                   'Remember, your safety matters to us. If you need someone to talk to or support, you can also reach out to Mentra\n \nWe\'re here to listen and help.'),
      //         ),
      //       ),
      //       32.verticalSpace,
      //       CustomNeumorphicButton(
      //           text: "Talk to Mentra", onTap: () {}, color: Pallets.primary),
      //       32.verticalSpace,
      //     ],
      //   ),
      // ),
      appBar: const CustomAppBar(tittleText: 'Emergency SOS'),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: BlocConsumer<DashboardBloc, DashboardState>(
                bloc: _bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetEmergencyContactLoadingState) {
                    return SizedBox(
                      height: 300,
                      child: CustomDialogs.getLoading(size: 30),
                    );
                  }
                  if (state is GetEmergencyContactFailureState) {
                    return AppPromptWidget(
                      onTap: () {
                        _bloc.add(GetEmergencyContactsEvent());
                      },
                    );
                  }

                  if (state is GetEmergencyContactSuccessState) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          13.verticalSpace,
                          const TextView(
                            text:
                                'In case of an emergency, here are the helpline numbers you can contact for immediate assistance:',
                            fontWeight: FontWeight.w600,
                          ),
                          19.verticalSpace,
                          ...List.generate(
                            state.data.data.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: SosDialerItem(
                                // icon: state.data.data[index].image.url??'',
                                tittle: state.data.data[index].title,
                                subtittle: state.data.data[index].contact,
                                onTap: () {
                                  UrlLauncher().dialPhoneNumber(
                                      state.data.data[index].contact);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  return 0.verticalSpace;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
