import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/app_filled_textfield.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/date_selector_widget.dart';
import 'package:mentra/features/library/presentation/screens/wellness_library_screen.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _passwordObscured = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  var year = '';

  // final _nameController = TextEditingController();
  final _bloc = SettingsBloc(injector.get());

  @override
  void initState() {
    _preFillContents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Profile',
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        bloc: bloc,
        listener: _listenToSettingsBloc,
        builder: (context, state) {
          return Stack(
            children: [
              const AppBg(),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  children: [
                    Expanded(
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: ImageWidget(
                                  size: 80,
                                  imageUrl: Assets.images.pngs.avatar22.path,
                                  // imageUrl: "${injector.get<LoginBloc>().userPreview?.avatar}"
                                ),
                              ),
                              10.verticalSpace,
                              Center(
                                child: TextView(
                                  text:
                                      injector.get<UserBloc>().appUser?.name ??
                                          '',
                                  style: GoogleFonts.fraunces(
                                    fontSize: 32.sp,
                                  ),
                                ),
                              ),
                              18.verticalSpace,
                              Center(
                                child: CustomNeumorphicButton(
                                    expanded: false,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26, vertical: 10),
                                    onTap: () {
                                      context
                                          .pushNamed(PageUrl.editAvatarScreen);
                                    },
                                    color: Pallets.buttonBlack,
                                    child: const TextView(
                                      text: "Change Avatar",
                                      color: Pallets.white,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              45.verticalSpace,
                              InkWell(
                                onTap: () {
                                  CustomDialogs.showBottomSheet(
                                      context,
                                      Container(
                                        height: 240,
                                        decoration: const BoxDecoration(
                                            color: Pallets.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(21),
                                                topLeft: Radius.circular(21))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: TextView(
                                                text: 'Select year',
                                                style: GoogleFonts.fraunces(
                                                    color: Pallets.navy,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            16.verticalSpace,
                                            Expanded(
                                              child: DateSelectorWidget(
                                                alignment: Alignment.center,
                                                initialYear: int.parse(year),
                                                onYearSelected: (selectedYear) {
                                                  year =
                                                      selectedYear.toString();
                                                  context.pop();
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Pallets.white,
                                      borderRadius: BorderRadius.circular(17)),
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextView(
                                              text: 'Birth Year',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            TextView(
                                              text: year,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Pallets.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              AppFilledTextField(
                                hint: 'Habib',
                                label: 'Enter your nickname',
                                controller: _nameController,
                              ),
                              16.verticalSpace,
                              // AppFilledTextField(
                              //     hint: '*******',
                              //     label: 'Passcode',
                              //
                              //     obscured: _passwordObscured,
                              //     suffix: InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           _passwordObscured = !_passwordObscured;
                              //         });
                              //       },
                              //       child: Container(
                              //         child: !_passwordObscured
                              //             ? const Icon(
                              //             Icons.remove_red_eye_outlined)
                              //             : const Icon(
                              //             Icons.visibility_off_outlined),
                              //       ),
                              //     )),
                              // 16.verticalSpace,
                              AppFilledTextField(
                                hint: 'habib@gmail.com',
                                enabled: false,
                                controller: _emailController,
                                label: 'Enter your email',
                              ),
                              16.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomNeumorphicButton(
                          text: "Save Changes",
                          onTap: () {
                            bloc.add(UpdateProfileEvent(
                                _nameController.text, int.parse(year)));
                            // sc
                          },
                          color: Pallets.primary),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _listenToSettingsBloc(BuildContext context, SettingsState state) {
    if (state is UpdateProfileSuccessState) {
      context.pop();
      CustomDialogs.success('Profile updated');
      // context.pop();
    }
    if (state is UpdateProfileLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is UpdatePasscodeFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is UpdateProfileFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }

  void _preFillContents() {
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        var user = injector.get<UserBloc>().appUser;
        year = user!.birthYear;
        _nameController.text = user.name;
        _emailController.text = user.email;
        setState(() {});
      },
    );
  }

// Future<DateTime?> _selectYear(BuildContext context, int selectedYear) async {
//   return await showDatePicker(
//     context: context,
//     initialDate: DateTime(selectedYear),
//     firstDate: DateTime(1899),
//     lastDate: DateTime(2024),
//     initialDatePickerMode: DatePickerMode.year,
//
//     // onDatePickerModeChange: (value) {
//     //   if(value != DatePickerMode.year){
//     //
//     //   }
//     // },
//     builder: (BuildContext context, Widget? child) {
//       return Theme(
//         data: context.theme.copyWith(
//             textTheme: context.textTheme.copyWith(
//               headline6:
//                   TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//             ),
//             colorScheme: context.colorScheme.copyWith(
//                 primary: Pallets.lightSecondary, onPrimary: Pallets.black),
//             primaryColor: Pallets.secondary),
//         child: child!,
//       );
//     },
//   );
// }
}
