import 'dart:developer';
import 'package:flutter/material.dart';

class CustomButtomNav extends StatefulWidget {
  const CustomButtomNav(
      {Key? key,
      required this.navItem,
      required this.onTap,
      this.hasFab = false,
      this.showIndicator = true,
      this.selectedIconColor,
      this.unselectedIconColor})
      : super(key: key);
  final List<NavItemModel> navItem;
  final Function(int index) onTap;
  final bool? hasFab;
  final bool? showIndicator;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;

  @override
  State<CustomButtomNav> createState() => _CustomButtomNavState();
}

class _CustomButtomNavState extends State<CustomButtomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var items = List.generate(
        widget.navItem.length,
        (index) => Expanded(
              child: InkWell(
                onTap: () {
                  widget.onTap(index);
                  _switchTab(index);
                  log(index.toString());
                },
                child: NavItem(
                  navItem: widget.navItem[index],
                  isSelected: index == _selectedIndex,
                  showIndicator: widget.showIndicator!,
                  selectedIconColor: widget.selectedIconColor ??
                      Theme.of(context).colorScheme.primary,
                  unselectedIconColor: widget.selectedIconColor ?? Colors.grey,
                ),
              ),
            ));

    if (widget.hasFab! && widget.navItem.length > 3) {
      items.insert(2, const Expanded(child: SizedBox()));
    }

    return BottomAppBar(
      height: 60,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      color: Theme.of(context).colorScheme.background,
      shadowColor: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.zero,
      elevation: 0,
      child: Row(
        children: items,
      ),
    );
  }

  void _switchTab(int index) {
    _selectedIndex = index;

    setState(() {});
  }
}

class NavItem extends StatefulWidget {
  final NavItemModel navItem;
  final bool isSelected;
  final bool showIndicator;
  final Color selectedIconColor;
  final Color unselectedIconColor;

  const NavItem({
    Key? key,
    required this.navItem,
    required this.isSelected,
    required this.showIndicator,
    required this.selectedIconColor,
    required this.unselectedIconColor,
  }) : super(key: key);

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 16,
        ),
        Expanded(
          flex: 2,
          child: Theme(
            data: ThemeData(
                iconTheme: IconThemeData(
                    color: widget.isSelected
                        ? widget.selectedIconColor
                        : widget.unselectedIconColor)),
            child: AnimatedCrossFade(
                firstChild: widget.navItem.icon,
                secondChild: widget.navItem.selectedIcon ?? const SizedBox(),
                crossFadeState:
                    widget.isSelected && widget.navItem.selectedIcon != null
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300)),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        AnimatedCrossFade(
            secondCurve: Curves.fastOutSlowIn,
            firstCurve: Curves.bounceInOut,
            firstChild: const SizedBox(),
            secondChild: const NavNotch(),
            crossFadeState: widget.showIndicator && widget.isSelected
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300)),
      ],
    );
  }
}

class NavItemModel {
  final VoidCallback onTap;
  final Widget icon;
  final Widget? selectedIcon;

  NavItemModel({
    required this.onTap,
    required this.icon,
    this.selectedIcon,
  });
}

class NavNotch extends StatelessWidget {
  const NavNotch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
