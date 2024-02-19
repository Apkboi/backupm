import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class EditAvatarScreen extends StatefulWidget {
  const EditAvatarScreen({super.key});

  @override
  State<EditAvatarScreen> createState() => _EditAvatarScreenState();
}

class _EditAvatarScreenState extends State<EditAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: 'Edit Avatar',
        actions: [
          CustomNeumorphicButton(
            onTap: () {},
            color: Pallets.black,
            expanded: false,
            padding: const EdgeInsets.all(12),
            text: 'Save',
          )
        ],
      ),
      body: Stack(
        children: [
          // AppBg(),
          Column(
            children: [
              Container(
                height: 390,
                child: Center(
                  child: ImageWidget(
                    imageUrl: Assets.images.pngs.avatar2.path,
                    size: 130,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
