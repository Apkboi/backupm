import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class AvatarGridView extends StatefulWidget {
  final Function(String) onAvatarSelected;

  AvatarGridView({required this.onAvatarSelected});

  @override
  _AvatarGridViewState createState() => _AvatarGridViewState();
}

class _AvatarGridViewState extends State<AvatarGridView> {
  List<String> avatars = [
    Assets.images.pngs.avatar1.path,
    Assets.images.pngs.avatar2.path,
    Assets.images.pngs.avatar3.path,
    Assets.images.pngs.avatar4.path,
    Assets.images.pngs.avatar13.path,
    Assets.images.pngs.avatar14.path,
    Assets.images.pngs.avatar15.path,
    Assets.images.pngs.avatar16.path,
    Assets.images.pngs.avatar20.path,
    Assets.images.pngs.avatar21.path,
    Assets.images.pngs.avatar22.path,

    // Add more avatar names as needed
  ];

  String? selectedAvatar;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        // crossAxisSpacing: 2.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.3,
      ),
      itemCount: avatars.length,
      itemBuilder: (context, index) {
        String avatar = avatars[index];

        bool isSelected = index == selectedIndex;

        return InkWell(
          onTap: () {
            setState(() {
              selectedAvatar = avatar;
              selectedIndex = index;
            });
            widget.onAvatarSelected(avatar);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Pallets.turquoise1 : Colors.transparent,
                width: 3.0,
              ),
            ),
            child: CircleAvatar(
              // backgroundImage: AssetImage(Assets.images.pngs.avatar1.path,), // Assuming avatars are named like 'avatar1.jpg', 'avatar2.jpg', etc.
              child: Image.asset(avatars[index]),
            ),
          ),
        );
      },
    );
  }
}
