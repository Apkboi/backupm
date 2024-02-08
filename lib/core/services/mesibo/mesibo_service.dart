// import 'package:mesibo_flutter/mesibo_flutter.dart';
// import 'package:mesibo_flutter_sdk/mesibo.dart';
//
// class MesiboService {
//   static final MesiboService _instance = MesiboService._internal();
//
//   factory MesiboService() {
//     return _instance;
//   }
//
//   MesiboService._internal() {
//     // Initialize Mesibo SDK here
//     Mesibo.initialize();
//     // Add necessary initialization code like setting up listeners, etc.
//   }
//
//   void login(String authToken) {
//     // Perform Mesibo login using authToken
//     Mesibo.login(authToken);
//   }
//
//   void sendMessage(String peer, String message) {
//     // Send message using Mesibo SDK
//     Mesibo.sendMessage(peer, 0, message);
//   }
//
//   void callUser(String peer) {
//     // Initiate a call using Mesibo SDK
//     MesiboCall.getInstance().call(peer, true);
//   }
//
// // Add more methods as needed for Mesibo functionalities
//
// }
