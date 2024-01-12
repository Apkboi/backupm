import 'package:flutter/material.dart';
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
    'avatar1',
    'avatar2',
    'avatar3',
    'avatar3',
    'avatar3',
    'avatar3',
    'avatar4',
    'avatar5',
    'avatar6',
    'avatar6',
    'avatar6',
    'avatar6',
    'avatar6',
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
              backgroundImage: AssetImage(Assets.images.pngs.onboarding3.path), // Assuming avatars are named like 'avatar1.jpg', 'avatar2.jpg', etc.
            ),
          ),
        );
      },
    );
  }
}
