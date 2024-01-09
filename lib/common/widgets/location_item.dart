// import 'package:flutter/material.dart';
//
// import 'package:fops/common/models/app_location_model.dart';
// import 'package:fops/core/helpers/app_enums.dart';
// import 'package:fops/core/theme/app_colors.dart';
//
// class LocationItem extends StatefulWidget {
//   const LocationItem(
//       {Key? key, required this.place, required this.onLocationSelected})
//       : super(key: key);
//   final AppLocationModel place;
//   final Function(AppLocationModel place) onLocationSelected;
//
//   @override
//   State<LocationItem> createState() => _LocationItemState();
// }
//
// class _LocationItemState extends State<LocationItem> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         widget.onLocationSelected(widget.place);
//       },
//       child: Row(
//         children: [
//
//           _getIcon(widget.place),
//           const SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.place.name,
//                   style: TextStyle(
//                       color: Theme
//                           .of(context)
//                           .colorScheme
//                           .onBackground),
//                 ),
//                 const SizedBox(
//                   height: 1,
//                 ),
//                 Text(
//                   widget.place.formattedAddress,
//                   style: const TextStyle(color: darkGrey, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           Icon(
//             Icons.arrow_forward_ios_rounded,
//             size: 13,
//             color: Theme
//                 .of(context)
//                 .colorScheme
//                 .onBackground,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _getIcon(AppLocationModel place) {
//     return   const Icon(
//       Icons.location_on,
//       color: Colors.grey,
//       size: 25,
//     );
//
//
//
//   }
// }
