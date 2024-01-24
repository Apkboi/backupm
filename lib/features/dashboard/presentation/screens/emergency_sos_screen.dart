import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/glass_container.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/dashboard/presentation/widget/sos_dialer_item.dart';

class EmergencySosScreen extends StatefulWidget {
  const EmergencySosScreen({super.key});

  @override
  State<EmergencySosScreen> createState() => _EmergencySosScreenState();
}

class _EmergencySosScreenState extends State<EmergencySosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  color: Pallets.white.withOpacity(0.6)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                child: TextView(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    text:
                        'Remember, your safety matters to us. If you need someone to talk to or support, you can also reach out to Mentra\n \nWe\'re here to listen and help.'),
              ),
            ),
            32.verticalSpace,
            CustomNeumorphicButton(
                text: "Talk to Mentra",
                onTap: () {

            }, color: Pallets.primary
            ),
            32.verticalSpace,

          ],
        ),
      ),
      appBar: const CustomAppBar(tittleText: 'Emergency SOS'),
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(17),
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
                  SosDialerItem(
                    icon: '🚑',
                    tittle: "Medical Emergency",
                    subtittle: "998",
                    onTap: () {},
                  ),
                  9.verticalSpace,
                  SosDialerItem(
                    iconBg: Pallets.pink,
                    icon: '🚓',
                    tittle: "Police",
                    subtittle: "998",
                    onTap: () {},
                  ),
                  9.verticalSpace,
                  SosDialerItem(
                    icon: '🚒',
                    iconBg: Colors.orange,
                    tittle: "Fire Department",
                    subtittle: "997",
                    onTap: () {},
                  ),
                  9.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
