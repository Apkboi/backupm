// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../constants/pallets.dart';
//
// class ShimmerWidget extends StatelessWidget {
//   final double? height;
//   final double? width;
//   final double? borderRadius;
//   final bool? enabled;
//   final BoxDecoration? decoration;
//
//   ShimmerWidget.rectangle(
//       {super.key,
//       this.width = double.infinity,
//       this.height,
//       this.borderRadius = 0,
//       this.enabled})
//       : decoration = BoxDecoration(
//           shape: BoxShape.rectangle,
//           color: Pallets.white,
//           borderRadius: BorderRadius.circular(borderRadius ?? 0),
//         );
//
//   const ShimmerWidget.circle(
//       {super.key, this.width, this.height, this.borderRadius = 0, this.enabled})
//       : decoration = const BoxDecoration(
//           shape: BoxShape.circle,
//           color: Pallets.white,
//         );
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       period: const Duration(seconds: 2),
//       enabled: enabled ?? true,
//       baseColor: Pallets.borderGrey.withOpacity(0.3),
//       highlightColor: Pallets.unselectedGrey,
//       child: Container(
//           width: width,
//           height: height,
//           decoration: decoration ??
//               BoxDecoration(
//                 borderRadius: BorderRadius.circular(borderRadius!),
//                 color: Colors.grey[400],
//               )
//           // ShapeDecoration(, shape: shapeBorder),
//           ),
//     );
//   }
// }
