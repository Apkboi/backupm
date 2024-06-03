import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/extensions/color_extension.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/features/settings/presentation/widgets/avatar_selector_widget.dart';

class EditAvatarScreen extends StatefulWidget {
  const EditAvatarScreen({super.key});

  @override
  State<EditAvatarScreen> createState() => _EditAvatarScreenState();
}

class _EditAvatarScreenState extends State<EditAvatarScreen> {
  String selectedImageUrl = '';
  int? selectedImageId;
  Color selectedColor = Colors.indigo;

  @override
  void initState() {
    _prefillAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        // height: 60,
        // height: 70,
        tittleText: 'Edit Avatar',
        actions: [
          CustomNeumorphicButton(
            onTap: () {
              // if (selectedImageId == null) {
              //   CustomDialogs.showToast('Select an avatar');
              // } else {
                injector.get<SettingsBloc>().add(
                    UploadImageEvent(selectedImageId, selectedColor.toHex()));
              // }
            },
            color: Pallets.black,
            expanded: false,
            padding:  const EdgeInsets.symmetric(horizontal: 15,vertical: 10),

            text: 'Save',
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: selectedColor),
              height: 390.h,
              child: Center(
                child: ImageWidget(
                  imageUrl: selectedImageUrl,
                  fit: BoxFit.scaleDown,
                  size: 150,
                  // fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: AvartarSelector(
                onAvatarSelected: (p0) {
                  selectedImageUrl = p0.image.url;
                  selectedImageId = p0.id;
                  setState(() {});
                },
                onBackgroundSelector: (p0) {
                  selectedColor = p0;
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _prefillAvatar() {
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        selectedImageUrl = injector.get<UserBloc>().appUser!.avatar;
        setState(() {});
      },
    );
  }
}
