import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentra/core/theme/pallets.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({Key? key, required this.tabs}) : super(key: key);
  final List<Widget> tabs;

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        // color: AppColors.tertiaryColor,
        borderRadius: BorderRadius.circular(50),
        // border: Border.all(color: Colors.grey.shade300, width: 10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
          ),
          BoxShadow(
            color: Pallets.Grey1,
            spreadRadius: -1.0,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TabBar(
          unselectedLabelColor: Pallets.Grey1,
          indicator: BoxDecoration(
              color: Pallets.white, borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.zero,
          tabs: widget.tabs,
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
// Stack(
// children: [
//
// Container(
// height: 80,
// width: 400,
// decoration:   BoxDecoration(
// color: Colors.indigo,
// borderRadius: BorderRadius.circular(50),
// border: Border.all(color: AppColors.tabColor,width: 5),
// boxShadow:[ BoxShadow(color: Colors.black12,offset: Offset(0, 0),blurRadius: 7)]
// ),
// ),
// // Container(
// //   height: 70,
// //   width: 390,
// //   decoration:   BoxDecoration(
// //     color: Colors.indigo.shade500,
// //     borderRadius: BorderRadius.circular(50),
// //     // border: Border.all(color: Colors.indigo.shade500,width: 5),
// //     // boxShadow:[ BoxShadow(color: Colors.black12,offset: Offset(0, 0),blurRadius: 7)]
// //   ),
// // ),
// ],
// )
