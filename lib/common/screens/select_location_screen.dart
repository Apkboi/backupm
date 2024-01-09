// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fops/common/blocs/google_map/google_map_bloc.dart';
// import 'package:fops/common/models/app_location_model.dart';
// import 'package:fops/common/widgets/filled_textfield.dart';
// import 'package:fops/common/widgets/location_item.dart';
// import 'package:fops/common/widgets/location_item_shimmer.dart';
// import 'package:fops/core/di/injector.dart';
// import 'package:fops/core/helpers/debouncer.dart';
// import 'package:fops/core/utils/app_utils.dart';
//
// class SelectLocation extends StatefulWidget {
//   const SelectLocation({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<SelectLocation> createState() => _SelectLocationState();
// }
//
// class _SelectLocationState extends State<SelectLocation> {
//   List<AppLocationModel> places = [];
//   String lastInput = '';
//   Debouncer debouncer = Debouncer(milliseconds: 700);
//   final originController = TextEditingController();
//   final destinationController = TextEditingController();
//   final destinationFocusNode = FocusNode();
//   final originFocusNode = FocusNode();
//   var bloc = injector.get<GoogleMapBloc>();
//
//   AppLocationModel? pickedLocation;
//
//   @override
//   void initState() {
//     super.initState();
//     bloc.add(SearchPlaceEvent('A'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.background,
//           borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(10)),
//                 width: 70,
//                 height: 4,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Choose Location',
//                   style: TextStyle(
//                       color: Theme.of(context).colorScheme.onBackground,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       'Close',
//                       style: TextStyle(color: Colors.red),
//                     ))
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             FilledTextField(
//               hint: 'Search Location',
//               focusNode: originFocusNode,
//               controller: originController,
//               autofocus: true,
//               outline: true,
//               fillColor: Colors.grey.shade200.withOpacity(0.1),
//               onChanged: (val) {
//                 if (lastInput != val) {
//                   // setState(() {
//                   //   selectedPlace = null;
//                   // });
//
//                   lastInput = val!;
//                   debouncer.run(() {
//                     bloc.add(SearchPlaceEvent(val));
//                   });
//                 }
//                 return null;
//               },
//               preffix: const Icon(
//                 Icons.location_on,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             BlocConsumer<GoogleMapBloc, GoogleMapState>(
//                 bloc: bloc,
//                 listener: _listenToGoogleMapStates,
//                 builder: (context, state) {
//                   return Expanded(
//                     child: state is SearchPlaceLoading
//                         ? const LocationItemShimmer()
//                         : ListView.builder(
//                             itemCount: places.length,
//                             padding: EdgeInsets.zero,
//                             physics: const BouncingScrollPhysics(),
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) => GestureDetector(
//                                   behavior: HitTestBehavior.opaque,
//                                   onTap: () {
//                                     // widget.onLocationPicked(places[index]);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 15),
//                                     child: LocationItem(
//                                       place: places[index],
//                                       onLocationSelected: (place) {
//                                         locationSelected(place, context);
//                                       },
//                                     ),
//                                   ),
//                                 )),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void locationSelected(AppLocationModel place, BuildContext context) {
//     Navigator.pop(context, place);
//   }
//
//   void _listenToGoogleMapStates(BuildContext context, GoogleMapState state) {
//
//     if (state is SearchPlaceSuccess) {
//       setState(() {
//         places = state.placeResult.results
//             .map((e) => e.toAppLocationModel())
//             .toList();
//       });
//
//       // CustomSnackBar.showMessage(context,
//       //     message: state.placeResult.status.toString());
//     }
//     if (state is SearchPlaceFailure) {
//       showCustomToast(state.error, Colors.red);
//       CustomSnackBar.showError(context, message: state.error);
//       log(state.error);
//     }
//   }
// }
