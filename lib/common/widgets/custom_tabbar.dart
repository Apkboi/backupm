import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({Key? key, required this.tabs, this.controller})
      : super(key: key);
  final List<Widget> tabs;
  final TabController? controller;

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Pallets.Grey1,
        borderRadius: BorderRadius.circular(50),
        // border: Border.all(color: Colors.grey.shade300, width: 10),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black26,
        //   ),
        //   BoxShadow(
        //     color: Pallets.Grey1,
        //     spreadRadius: -1.0,
        //     blurRadius: 6.0,
        //   ),
        // ],
      ),
      child: TabBar(
          controller: widget.controller,
          unselectedLabelColor: Pallets.primaryDark,
          labelColor: Pallets.primaryDark,
          indicator: BoxDecoration(
              color: Pallets.white, borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.zero,
          tabs: widget.tabs,
          unselectedLabelStyle: GoogleFonts.fraunces(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Pallets.primaryDark),
          labelStyle: GoogleFonts.fraunces(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Pallets.primaryDark)),
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
