// /******************************************************************************
//  * By accessing or copying this work, you agree to comply with the following   *
//  * terms:                                                                      *
//  *                                                                             *
//  * Copyright (c) 2019-2023 mesibo                                              *
//  * https://mesibo.com                                                          *
//  * All rights reserved.                                                        *
//  *                                                                             *
//  * Redistribution is not permitted. Use of this software is subject to the     *
//  * conditions specified at https://mesibo.com . When using the source code,    *
//  * maintain the copyright notice, conditions, disclaimer, and  links to mesibo *
//  * website, documentation and the source code repository.                      *
//  *                                                                             *
//  * Do not use the name of mesibo or its contributors to endorse products from  *
//  * this software without prior written permission.                             *
//  *                                                                             *
//  * This software is provided "as is" without warranties. mesibo and its        *
//  * contributors are not liable for any damages arising from its use.           *
//  *                                                                             *
//  * Documentation: https://mesibo.com/documentation/                            *
//  *                                                                             *
//  * Source Code Repository: https://github.com/mesibo/                          *
//  *******************************************************************************/
//
// // ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
//
// import'dart:collection';
// import'dart:async';
// import'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
// import'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
// import'package:flutter/services.dart';
// import 'package:mentra/core/di/injector.dart';
//
// List<Object?> wrapResponse(
//     {Object? result, PlatformException? error, bool empty = false}) {
//   if (empty) {
//     return <Object?>[];
//   }
//   if (error == null) {
//     return <Object?>[result];
//   }
//   return <Object?>[error.code, error.message, error.details];
// }
//
// class meSibofLuTtERcLass {
//   meSibofLuTtERcLass(
//       {this.name, this.flags, this.callFlags, this.callDuration, this.videoResolution, this.expiry,});
//
//   String? name;
//   int? flags;
//   int? callFlags;
//   int? callDuration;
//   int? videoResolution;
//   int? expiry;
//
//   Object encode() {
//     return <Object?>[
//       name,
//       flags,
//       callFlags,
//       callDuration,
//       videoResolution,
//       expiry,
//     ];
//   }
//
//   static meSibofLuTtERcLass decode(Object result) {
//     result as List<Object?>;
//     return MesiboGroupSettings(name:
//     result[0] as String?,
//       flags: result[1] as int?,
//       callFlags: result[2] as int?,
//       callDuration: result[3] as int?,
//       videoResolution:
//       result[4] as int?,
//       expiry: result[5] as int?,);
//   }
// }
//
// class MeSiBOFLUttercLass {
//   MeSiBOFLUttercLass(
//       {this.flags, this.adminFlags, this.callFlags, this.callDuration, this.videoResolution, this.expiry,});
//
//   int? flags;
//   int? adminFlags;
//   int? callFlags;
//   int? callDuration;
//   int? videoResolution;
//   int? expiry;
//
//   Object encode() {
//     return <Object?>[
//       flags,
//       adminFlags,
//       callFlags,
//       callDuration,
//       videoResolution,
//       expiry,
//     ];
//   }
//
//   static MeSiBOFLUttercLass decode(Object result) {
//     result as List<Object?>;
//     return MesiboMemberPermissions(flags:
//     result[0] as int?,
//       adminFlags: result[1] as int?,
//       callFlags: result[2] as int?,
//       callDuration: result[3] as int?,
//       videoResolution:
//       result[4] as int?,
//       expiry:
//       result[5] as int?,);
//   }
// }
//
// class mESiBOFluttErcLass {
//   mESiBOFluttErcLass({required this.pin, this.permissions,});
//
//   int pin;
//   MeSiBOFLUttercLass? permissions;
//
//   Object encode() {
//     return <Object?>[pin, permissions?.encode(),];
//   }
//
//   static mESiBOFluttErcLass decode(Object result) {
//     result as List<Object?>;
//     return MesiboGroupPin(pin: result[0]! as int, permissions:
//     result[1] != null
//         ? MeSiBOFLUttercLass.decode(result[1]! as List<Object?>)
//         : null,);
//   }
// }
//
// class MEsIBOfluTterClass {
//   MEsIBOfluTterClass({this.profile, required this.admin, required this.owner,});
//
//   MesiboProfileFlutter? profile;
//   bool admin;
//   bool owner;
//
//   Object encode() {
//     return <Object?>[profile?.encode(), admin, owner,];
//   }
//
//   static MEsIBOfluTterClass decode(Object result) {
//     result as List<Object?>;
//     return MesiboGroupMember(profile:
//     result[0] != null
//         ? MesiboProfileFlutter.decode(result[0]! as List<Object?>)
//         : null, admin:
//     result[1]! as bool, owner: result[2]! as bool,);
//   }
// }
//
// class MesiboProfileFlutter {
//   MesiboProfileFlutter(
//       {this.address, required this.groupId, required this.uid, this.status, this.name, this.imageUrl, this.imagePath, this.thumbnailPath, required this.selfProfile,});
//
//   String? address;
//   int groupId;
//   int uid;
//   String? status;
//   String? name;
//   String? imageUrl;
//   String? imagePath;
//   String? thumbnailPath;
//   bool selfProfile;
//
//   Object encode() {
//     return <Object?>[
//       address,
//       groupId,
//       uid,
//       status,
//       name,
//       imageUrl,
//       imagePath,
//       thumbnailPath,
//       selfProfile,
//     ];
//   }
//
//   static MesiboProfileFlutter decode(Object result) {
//     logger.i(result);
//     result as List<Object?>;
//     return MesiboGroupProfile.createInstance(result, address:
//     result[0] as String?,
//       groupId: result[1]! as int,
//       uid:
//       result[2]! as int,
//       status: (result[3].toString()),
//       name: result[4] as String?,
//       imageUrl: (result[5].toString()),
//       // imagePath: result[6] as String?,
//       // thumbnailPath: result[7] as String?,
//       // selfProfile: result[8]! as bool,
//     )
//     ;
//   }
// }
//
// class MesiboDateTimeFlutter {
//   MesiboDateTimeFlutter(
//       {this.date, this.ndate, this.time, required this.ts, required this.year, required this.month, required this.wday, required this.day, required this.hour, required this.min, required this.sec,});
//
//   String? date;
//   String? ndate;
//   String? time;
//   int ts;
//   int year;
//   int month;
//   int wday;
//   int day;
//   int hour;
//   int min;
//   int sec;
//
//   Object encode() {
//     return <Object?>[
//       date,
//       ndate,
//       time,
//       ts,
//       year,
//       month,
//       wday,
//       day,
//       hour,
//       min,
//       sec,
//     ];
//   }
//
//   static MesiboDateTimeFlutter decode(Object result) {
//     result as List<Object?>;
//     return MesiboDateTime(date:
//     result[0] as String?,
//       ndate: result[1] as String?,
//       time:
//       result[2] as String?,
//       ts: result[3]! as int,
//       year: result[4]! as int,
//       month: result[5]! as int,
//       wday:
//       result[6]! as int,
//       day: result[7]! as int,
//       hour: result[8]! as int,
//       min:
//       result[9]! as int,
//       sec: result[10]! as int,);
//   }
// }
//
// class mEsiBoFLuTTERclAss {
//   mEsiBoFLuTTERclAss(
//       {required this.mid, required this.refid, required this.rsid, required this.type, required this.flags, required this.status, required this.expiry, required this.origin, this.title, this.subtitle, this.footer, this.message, this.filePath, required this.fileType, required this.latitude, required this.longitude, this.profile, this.groupProfile, this.ts,});
//
//   int mid;
//   int refid;
//   int rsid;
//   int type;
//   int flags;
//   int status;
//   int expiry;
//   int origin;
//   String? title;
//   String? subtitle;
//   String? footer;
//   String? message;
//   String? filePath;
//   int fileType;
//   double latitude;
//   double longitude;
//   MesiboProfileFlutter? profile;
//   MesiboProfileFlutter? groupProfile;
//   MesiboDateTimeFlutter? ts;
//
//   Object encode() {
//     return <Object?>[
//       mid,
//       refid,
//       rsid,
//       type,
//       flags,
//       status,
//       expiry,
//       origin,
//       title,
//       subtitle,
//       footer,
//       message,
//       filePath,
//       fileType,
//       latitude,
//       longitude,
//       profile?.encode(),
//       groupProfile?.encode(),
//       ts?.encode(),
//     ];
//   }
//
//   static mEsiBoFLuTTERclAss decode(Object result) {
//     result as List<Object?>;
//     return MesiboMessage.createInstance(result, mid:
//     result[0]! as int,
//       refid: result[1]! as int,
//       rsid: result[2]! as int,
//       type:
//       result[3]! as int,
//       flags: result[4]! as int,
//       status: result[5]! as int,
//       expiry: result[6]! as int,
//       origin:
//       result[7]! as int,
//       title:
//       result[8] as String?,
//       subtitle: result[9] as String?,
//       footer:
//       result[10] as String?,
//       message:
//       result[11] as String?,
//       filePath:
//       result[12] as String?,
//       fileType:
//       result[13]! as int,
//       latitude: result[14]! as double,
//       longitude: result[15]! as double,
//       profile:
//       result[16] != null ? MesiboProfileFlutter.decode(
//           result[16]! as List<Object?>) : null,
//       groupProfile:
//       result[17] != null ? MesiboProfileFlutter.decode(
//           result[17]! as List<Object?>) :
//       null,
//       ts: result[18] != null ? MesiboDateTimeFlutter.decode(
//           result[18]! as List<Object?>) :
//       null,);
//   }
// }
//
// class MEsIbOflutteRclass {
//   MEsIbOflutteRclass(
//       {required this.presence, required this.value, this.profile, this.groupProfile,});
//
//   int presence;
//   int value;
//   MesiboProfileFlutter? profile;
//   MesiboProfileFlutter? groupProfile;
//
//   Object encode() {
//     return <Object?>[
//       presence,
//       value,
//       profile?.encode(),
//       groupProfile?.encode(),
//     ];
//   }
//
//   static MEsIbOflutteRclass decode(Object result) {
//     result as List<Object?>;
//     return MesiboPresence(presence:
//     result[0]! as int,
//       value:
//       result[1]! as int,
//       profile: result[2] != null ? MesiboProfileFlutter.decode(
//           result[2]! as List<Object?>) : null,
//       groupProfile:
//       result[3] != null ? MesiboProfileFlutter.decode(
//           result[3]! as List<Object?>) : null,);
//   }
// }
//
// class MESiBOFLuTtERclass {
//   MESiBOFLuTtERclass(
//       {this.profile, this.name, this.phoneNumber, this.nationalNumber, this.formattedPhoneNumber, this.country, this.countryIsoCode, required this.countryPhoneCode, required this.type, required this.valid, required this.possiblyValid,});
//
//   MesiboProfileFlutter? profile;
//   String? name;
//   String? phoneNumber;
//   String? nationalNumber;
//   String? formattedPhoneNumber;
//   String? country;
//   String? countryIsoCode;
//   int countryPhoneCode;
//   int type;
//   bool valid;
//   bool possiblyValid;
//
//   Object encode() {
//     return <Object?>[
//       profile?.encode(),
//       name,
//       phoneNumber,
//       nationalNumber,
//       formattedPhoneNumber,
//       country,
//       countryIsoCode,
//       countryPhoneCode,
//       type,
//       valid,
//       possiblyValid,
//     ];
//   }
//
//   static MESiBOFLuTtERclass decode(Object result) {
//     result as List<Object?>;
//     return MesiboPhoneContact(profile:
//     result[0] != null
//         ? MesiboProfileFlutter.decode(result[0]! as List<Object?>)
//         :
//     null,
//       name: result[1] as String?,
//       phoneNumber: result[2] as String?,
//       nationalNumber:
//       result[3] as String?,
//       formattedPhoneNumber: result[4] as String?,
//       country: result[5] as String?,
//       countryIsoCode:
//       result[6] as String?,
//       countryPhoneCode: result[7]! as int,
//       type: result[8]! as int,
//       valid: result[9]! as bool,
//       possiblyValid:
//       result[10]! as bool,);
//   }
// }
//
// class MeSIBOFLUTTeRClass {
//   MeSIBOFLUTTeRClass(
//       {this.message, this.audioCall, this.videoCall, this.groupAudioCall, this.groupVideoCall, this.endToEndEncryptionInfo, this.hasListerner,});
//
//   bool? message;
//   bool? audioCall;
//   bool? videoCall;
//   bool? groupAudioCall;
//   bool? groupVideoCall;
//   bool? endToEndEncryptionInfo;
//   bool? hasListerner;
//
//   Object encode() {
//     return <Object?>[
//       message,
//       audioCall,
//       videoCall,
//       groupAudioCall,
//       groupVideoCall,
//       endToEndEncryptionInfo,
//       hasListerner,
//     ];
//   }
//
//   static MeSIBOFLUTTeRClass decode(Object result) {
//     result as List<Object?>;
//     return MesiboUIButtons(message: result[0] as bool?,
//       audioCall:
//       result[1] as bool?,
//       videoCall: result[2] as bool?,
//       groupAudioCall:
//       result[3] as bool?,
//       groupVideoCall:
//       result[4] as bool?,
//       endToEndEncryptionInfo:
//       result[5] as bool?,
//       hasListerner: result[6] as bool?,);
//   }
// }
//
// class MesiboUIOptionsFlutter {
//   MesiboUIOptionsFlutter(
//       {this.appName, required this.enableForward, required this.enableSearch, required this.enableBackButton, required this.e2eIndicator, this.messageListTitle, this.userListTitle, this.createGroupTitle, this.selectContactTitle, this.selectGroupContactsTitle, this.forwardTitle, this.forwardedTitle, this.userOnlineIndicationTitle, this.onlineIndicationTitle, this.offlineIndicationTitle, this.connectingIndicationTitle, this.noNetworkIndicationTitle, this.suspendedIndicationTitle, this.typingIndicationTitle, this.joinedIndicationTitle, this.e2eeActive, this.e2eeIdentityChanged, this.e2eeInactive, this.emptyUserListMessage, this.emptyMessageListMessage, this.emptySearchListMessage, required this.showRecentInForward, required this.convertSmilyToEmoji, required this.toolbarColor, required this.statusBarColor, required this.toolbarTextColor, required this.userListTypingIndicationColor, required this.userListStatusColor, required this.userListBackgroundColor, required this.messageBackgroundColorForMe, required this.messageBackgroundColorForPeer, required this.titleBackgroundColorForMe, required this.titleBackgroundColorForPeer, required this.messagingBackgroundColor, required this.maxImageFileSize, required this.maxVideoFileSize, required this.verticalImageWidth, required this.horizontalImageWidth, this.recentUsersTitle, this.allUsersTitle, this.groupMembersTitle, this.cancelTitle, this.missedVoiceCallTitle, this.missedVideoCallTitle, this.deletedMessageTitle, this.deleteMessagesTitle, this.deleteForEveryoneTitle, this.deleteForMeTitle, this.deleteTitle,});
//
//   String? appName;
//   bool enableForward;
//   bool enableSearch;
//   bool enableBackButton;
//   bool e2eIndicator;
//   String? messageListTitle;
//   String? userListTitle;
//   String? createGroupTitle;
//   String? selectContactTitle;
//   String? selectGroupContactsTitle;
//   String? forwardTitle;
//   String? forwardedTitle;
//   String? userOnlineIndicationTitle;
//   String? onlineIndicationTitle;
//   String? offlineIndicationTitle;
//   String? connectingIndicationTitle;
//   String? noNetworkIndicationTitle;
//   String? suspendedIndicationTitle;
//   String? typingIndicationTitle;
//   String? joinedIndicationTitle;
//   String? e2eeActive;
//   String? e2eeIdentityChanged;
//   String? e2eeInactive;
//   String? emptyUserListMessage;
//   String? emptyMessageListMessage;
//   String? emptySearchListMessage;
//   bool showRecentInForward;
//   bool convertSmilyToEmoji;
//   int toolbarColor;
//   int statusBarColor;
//   int toolbarTextColor;
//   int userListTypingIndicationColor;
//   int userListStatusColor;
//   int userListBackgroundColor;
//   int messageBackgroundColorForMe;
//   int messageBackgroundColorForPeer;
//   int titleBackgroundColorForMe;
//   int titleBackgroundColorForPeer;
//   int messagingBackgroundColor;
//   int maxImageFileSize;
//   int maxVideoFileSize;
//   int verticalImageWidth;
//   int horizontalImageWidth;
//   String? recentUsersTitle;
//   String? allUsersTitle;
//   String? groupMembersTitle;
//   String? cancelTitle;
//   String? missedVoiceCallTitle;
//   String? missedVideoCallTitle;
//   String? deletedMessageTitle;
//   String? deleteMessagesTitle;
//   String? deleteForEveryoneTitle;
//   String? deleteForMeTitle;
//   String? deleteTitle;
//
//   Object encode() {
//     return <Object?>[
//       appName,
//       enableForward,
//       enableSearch,
//       enableBackButton,
//       e2eIndicator,
//       messageListTitle,
//       userListTitle,
//       createGroupTitle,
//       selectContactTitle,
//       selectGroupContactsTitle,
//       forwardTitle,
//       forwardedTitle,
//       userOnlineIndicationTitle,
//       onlineIndicationTitle,
//       offlineIndicationTitle,
//       connectingIndicationTitle,
//       noNetworkIndicationTitle,
//       suspendedIndicationTitle,
//       typingIndicationTitle,
//       joinedIndicationTitle,
//       e2eeActive,
//       e2eeIdentityChanged,
//       e2eeInactive,
//       emptyUserListMessage,
//       emptyMessageListMessage,
//       emptySearchListMessage,
//       showRecentInForward,
//       convertSmilyToEmoji,
//       toolbarColor,
//       statusBarColor,
//       toolbarTextColor,
//       userListTypingIndicationColor,
//       userListStatusColor,
//       userListBackgroundColor,
//       messageBackgroundColorForMe,
//       messageBackgroundColorForPeer,
//       titleBackgroundColorForMe,
//       titleBackgroundColorForPeer,
//       messagingBackgroundColor,
//       maxImageFileSize,
//       maxVideoFileSize,
//       verticalImageWidth,
//       horizontalImageWidth,
//       recentUsersTitle,
//       allUsersTitle,
//       groupMembersTitle,
//       cancelTitle,
//       missedVoiceCallTitle,
//       missedVideoCallTitle,
//       deletedMessageTitle,
//       deleteMessagesTitle,
//       deleteForEveryoneTitle,
//       deleteForMeTitle,
//       deleteTitle,
//     ];
//   }
//
//   static MesiboUIOptionsFlutter decode(Object result) {
//     result as List<Object?>;
//     return MesiboUIOptions(appName:
//     result[0] as String?,
//       enableForward: result[1]! as bool,
//       enableSearch: result[2]! as bool,
//       enableBackButton:
//       result[3]! as bool,
//       e2eIndicator: result[4]! as bool,
//       messageListTitle:
//       result[5] as String?,
//       userListTitle: result[6] as String?,
//       createGroupTitle: result[7] as String?,
//       selectContactTitle:
//       result[8] as String?,
//       selectGroupContactsTitle: result[9] as String?,
//       forwardTitle: result[10] as String?,
//       forwardedTitle:
//       result[11] as String?,
//       userOnlineIndicationTitle:
//       result[12] as String?,
//       onlineIndicationTitle:
//       result[13] as String?,
//       offlineIndicationTitle: result[14] as String?,
//       connectingIndicationTitle: result[15] as String?,
//       noNetworkIndicationTitle:
//       result[16] as String?,
//       suspendedIndicationTitle: result[17] as String?,
//       typingIndicationTitle:
//       result[18] as String?,
//       joinedIndicationTitle:
//       result[19] as String?,
//       e2eeActive: result[20] as String?,
//       e2eeIdentityChanged:
//       result[21] as String?,
//       e2eeInactive: result[22] as String?,
//       emptyUserListMessage:
//       result[23] as String?,
//       emptyMessageListMessage: result[24] as String?,
//       emptySearchListMessage:
//       result[25] as String?,
//       showRecentInForward: result[26]! as bool,
//       convertSmilyToEmoji: result[27]! as bool,
//       toolbarColor:
//       result[28]! as int,
//       statusBarColor:
//       result[29]! as int,
//       toolbarTextColor: result[30]! as int,
//       userListTypingIndicationColor: result[31]! as int,
//       userListStatusColor:
//       result[32]! as int,
//       userListBackgroundColor:
//       result[33]! as int,
//       messageBackgroundColorForMe: result[34]! as int,
//       messageBackgroundColorForPeer: result[35]! as int,
//       titleBackgroundColorForMe:
//       result[36]! as int,
//       titleBackgroundColorForPeer: result[37]! as int,
//       messagingBackgroundColor: result[38]! as int,
//       maxImageFileSize:
//       result[39]! as int,
//       maxVideoFileSize: result[40]! as int,
//       verticalImageWidth: result[41]! as int,
//       horizontalImageWidth:
//       result[42]! as int,
//       recentUsersTitle: result[43] as String?,
//       allUsersTitle: result[44] as String?,
//       groupMembersTitle:
//       result[45] as String?,
//       cancelTitle:
//       result[46] as String?,
//       missedVoiceCallTitle: result[47] as String?,
//       missedVideoCallTitle: result[48] as String?,
//       deletedMessageTitle:
//       result[49] as String?,
//       deleteMessagesTitle: result[50] as String?,
//       deleteForEveryoneTitle: result[51] as String?,
//       deleteForMeTitle:
//       result[52] as String?,
//       deleteTitle: result[53] as String?,);
//   }
// }
//
// class _MesiboMessageListenerFlutterCodec extends StandardMessageCodec {
//   const _MesiboMessageListenerFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MesiboDateTimeFlutter) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is mEsiBoFLuTTERclAss) {
//       buffer.putUint8(129);
//       writeValue(buffer, value.encode());
//     } else if (value is MesiboProfileFlutter) {
//       buffer.putUint8(130);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MesiboDateTimeFlutter.decode(readValue(buffer)!);
//       case 129:
//         return mEsiBoFLuTTERclAss.decode(readValue(buffer)!);
//       case 130:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// abstract class MesiboMessageListenerFlutter {
//   static const MessageCodec<
//       Object?> codec = _MesiboMessageListenerFlutterCodec();
//
//   void Mesibo_onMessage(MesiboMessage message);
//
//   void Mesibo_onMessageUpdate(MesiboMessage message);
//
//   void Mesibo_onMessageStatus(MesiboMessage message);
//
//   static void setup(MesiboMessageListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessage',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessage was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboMessage? arg_message = (args[0] as MesiboMessage?);
//           assert(arg_message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessage was null, expected non-null MesiboMessageFlutter.');
//           try {
//             api.Mesibo_onMessage(arg_message!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessageUpdate',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessageUpdate was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboMessage? arg_message = (args[0] as MesiboMessage?);
//           assert(arg_message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessageUpdate was null, expected non-null MesiboMessageFlutter.');
//           try {
//             api.Mesibo_onMessageUpdate(arg_message!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessageStatus',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessageStatus was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboMessage? arg_message = (args[0] as MesiboMessage?);
//           assert(arg_message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboMessageListenerFlutter.Mesibo_onMessageStatus was null, expected non-null MesiboMessageFlutter.');
//           try {
//             api.Mesibo_onMessageStatus(arg_message!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           }
//           catch (e) {
//             return wrapResponse(
//                 error: PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// abstract class MesiboSyncListenerFlutter {
//   static const MessageCodec<Object?> codec = StandardMessageCodec();
//
//   void Mesibo_onSync(int session, int count);
//
//   static void setup(MesiboSyncListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboSyncListenerFlutter.Mesibo_onSync',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboSyncListenerFlutter.Mesibo_onSync was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final int? arg_session = (args[0] as int?);
//           assert(arg_session !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboSyncListenerFlutter.Mesibo_onSync was null, expected non-null int.');
//           final int? arg_count = (args[1] as int?);
//           assert(arg_count !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboSyncListenerFlutter.Mesibo_onSync was null, expected non-null int.');
//           try {
//             api.Mesibo_onSync(arg_session!, arg_count!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(
//                 error: PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// abstract class MesiboConnectionListenerFlutter {
//   static const MessageCodec<Object?> codec = StandardMessageCodec();
//
//   void Mesibo_onConnectionStatus(int status);
//
//   static void setup(MesiboConnectionListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboConnectionListenerFlutter.Mesibo_onConnectionStatus',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboConnectionListenerFlutter.Mesibo_onConnectionStatus was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final int? arg_status = (args[0] as int?);
//           assert(arg_status !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboConnectionListenerFlutter.Mesibo_onConnectionStatus was null, expected non-null int.');
//           try {
//             api.Mesibo_onConnectionStatus(arg_status!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// class _MesiboPresenceListenerFlutterCodec extends StandardMessageCodec {
//   const _MesiboPresenceListenerFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MEsIbOflutteRclass) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MesiboProfileFlutter) {
//       buffer.putUint8(129);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MEsIbOflutteRclass.decode(readValue(buffer)!);
//       case 129:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// abstract class MesiboPresenceListenerFlutter {
//   static const MessageCodec<
//       Object?> codec = _MesiboPresenceListenerFlutterCodec();
//
//   void Mesibo_onPresence(MesiboPresence presence);
//
//   void Mesibo_onPresenceRequest(MesiboPresence presence);
//
//   static void setup(MesiboPresenceListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboPresenceListenerFlutter.Mesibo_onPresence',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPresenceListenerFlutter.Mesibo_onPresence was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboPresence? arg_presence = (args[0] as MesiboPresence?);
//           assert(arg_presence !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPresenceListenerFlutter.Mesibo_onPresence was null, expected non-null MesiboPresenceFlutter.');
//           try {
//             api.Mesibo_onPresence(arg_presence!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboPresenceListenerFlutter.Mesibo_onPresenceRequest',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPresenceListenerFlutter.Mesibo_onPresenceRequest was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboPresence? arg_presence = (args[0] as MesiboPresence?);
//           assert(arg_presence !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPresenceListenerFlutter.Mesibo_onPresenceRequest was null, expected non-null MesiboPresenceFlutter.');
//           try {
//             api.Mesibo_onPresenceRequest(arg_presence!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(
//                 error: PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// class _MesiboProfileListenerFlutterCodec extends StandardMessageCodec {
//   const _MesiboProfileListenerFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MesiboProfileFlutter) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// abstract class MesiboProfileListenerFlutter {
//   static const MessageCodec<
//       Object?> codec = _MesiboProfileListenerFlutterCodec();
//
//   void Mesibo_onProfileUpdated(MesiboProfile profile);
//
//   static void setup(MesiboProfileListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboProfileListenerFlutter.Mesibo_onProfileUpdated',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboProfileListenerFlutter.Mesibo_onProfileUpdated was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboProfileListenerFlutter.Mesibo_onProfileUpdated was null, expected non-null MesiboProfileFlutter.');
//           try {
//             api.Mesibo_onProfileUpdated(arg_profile!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code: 'error', message:
//             e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// class _MesiboGroupListenerFlutterCodec extends StandardMessageCodec {
//   const _MesiboGroupListenerFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MEsIBOfluTterClass) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is mESiBOFluttErcLass) {
//       buffer.putUint8(129);
//       writeValue(buffer, value.encode());
//     } else if (value is meSibofLuTtERcLass) {
//       buffer.putUint8(130);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MeSiBOFLUttercLass) {
//       buffer.putUint8(131);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MesiboProfileFlutter) {
//       buffer.putUint8(132);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MEsIBOfluTterClass.decode(readValue(buffer)!);
//       case 129:
//         return mESiBOFluttErcLass.decode(readValue(buffer)!);
//       case 130:
//         return meSibofLuTtERcLass.decode(readValue(buffer)!);
//       case 131:
//         return MeSiBOFLUttercLass.decode(readValue(buffer)!);
//       case 132:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// abstract class MesiboGroupListenerFlutter {
//   static const MessageCodec<Object?> codec = _MesiboGroupListenerFlutterCodec();
//
//   void Mesibo_onGroupCreated(MesiboProfile profile);
//
//   void Mesibo_onGroupJoined(MesiboProfile profile);
//
//   void Mesibo_onGroupLeft(MesiboProfile profile);
//
//   void Mesibo_onGroupMembers(MesiboProfile profile,
//       List<MesiboGroupMember?> members);
//
//   void Mesibo_onGroupMembersJoined(MesiboProfile profile,
//       List<MesiboGroupMember?> members);
//
//   void Mesibo_onGroupMembersRemoved(MesiboProfile profile,
//       List<MesiboGroupMember?> members);
//
//   void Mesibo_onGroupSettings(MesiboProfile profile,
//       MesiboGroupSettings? groupSettings,
//       MesiboMemberPermissions? memberPermissions,
//       List<MesiboGroupPin?> groupPins);
//
//   void Mesibo_onGroupError(MesiboProfile profile, int error);
//
//   static void setup(MesiboGroupListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupCreated',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupCreated was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupCreated was null, expected non-null MesiboProfileFlutter.');
//           try {
//             api.Mesibo_onGroupCreated(arg_profile!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupJoined',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupJoined was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupJoined was null, expected non-null MesiboProfileFlutter.');
//           try {
//             api.Mesibo_onGroupJoined(arg_profile!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code: 'error', message:
//             e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupLeft',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupLeft was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupLeft was null, expected non-null MesiboProfileFlutter.');
//           try {
//             api.Mesibo_onGroupLeft(arg_profile!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(
//                 error: PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembers',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembers was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembers was null, expected non-null MesiboProfileFlutter.');
//           final List<MesiboGroupMember?>? arg_members = (args[1] as List<
//               Object?>?)?.cast<MesiboGroupMember?>();
//           assert(arg_members !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembers was null, expected non-null List<MesiboGroupMember?>.');
//           try {
//             api.Mesibo_onGroupMembers(arg_profile!, arg_members!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersJoined',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersJoined was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersJoined was null, expected non-null MesiboProfileFlutter.');
//           final List<MesiboGroupMember?>? arg_members = (args[1] as List<
//               Object?>?)?.cast<MesiboGroupMember?>();
//           assert(arg_members !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersJoined was null, expected non-null List<MesiboGroupMember?>.');
//           try {
//             api.Mesibo_onGroupMembersJoined(arg_profile!, arg_members!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersRemoved',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersRemoved was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersRemoved was null, expected non-null MesiboProfileFlutter.');
//           final List<MesiboGroupMember?>? arg_members = (args[1] as List<
//               Object?>?)?.cast<MesiboGroupMember?>();
//           assert(arg_members !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupMembersRemoved was null, expected non-null List<MesiboGroupMember?>.');
//           try {
//             api.Mesibo_onGroupMembersRemoved(arg_profile!, arg_members!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupSettings',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupSettings was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupSettings was null, expected non-null MesiboProfileFlutter.');
//           final MesiboGroupSettings? arg_groupSettings = (args[1] as MesiboGroupSettings?);
//           final MesiboMemberPermissions? arg_memberPermissions = (args[2] as MesiboMemberPermissions?);
//           final List<MesiboGroupPin?>? arg_groupPins = (args[3] as List<
//               Object?>?)?.cast<MesiboGroupPin?>();
//           assert(arg_groupPins !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupSettings was null, expected non-null List<MesiboGroupPin?>.');
//           try {
//             api.Mesibo_onGroupSettings(
//                 arg_profile!, arg_groupSettings, arg_memberPermissions,
//                 arg_groupPins!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupError',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupError was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupError was null, expected non-null MesiboProfileFlutter.');
//           final int? arg_error = (args[1] as int?);
//           assert(arg_error !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboGroupListenerFlutter.Mesibo_onGroupError was null, expected non-null int.');
//           try {
//             api.Mesibo_onGroupError(arg_profile!, arg_error!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// abstract class MesiboPhoneContactsListenerFlutter {
//   static const MessageCodec<Object?> codec = StandardMessageCodec();
//
//   void Mesibo_onPhoneContactsChanged();
//
//   void Mesibo_onPhoneContactsAdded(List<String?> phones);
//
//   void Mesibo_onPhoneContactsDeleted(List<String?> phones);
//
//   static void setup(MesiboPhoneContactsListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboPhoneContactsListenerFlutter.Mesibo_onPhoneContactsChanged',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           try {
//             api.Mesibo_onPhoneContactsChanged();
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(
//                 error: PlatformException(code: 'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboPhoneContactsListenerFlutter.Mesibo_onPhoneContactsAdded',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPhoneContactsListenerFlutter.Mesibo_onPhoneContactsAdded was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final List<String?>? arg_phones = (args[0] as List<Object?>?)?.cast<
//               String?>();
//           assert(arg_phones !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPhoneContactsListenerFlutter.Mesibo_onPhoneContactsAdded was null, expected non-null List<String?>.');
//           try {
//             api.Mesibo_onPhoneContactsAdded(arg_phones!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboPhoneContactsListenerFlutter.Mesibo_onPhoneContactsDeleted',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPhoneContactsListenerFlutter.Mesibo_onPhoneContactsDeleted was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final List<String?>? arg_phones = (args[0] as List<Object?>?)?.cast<
//               String?>();
//           assert(arg_phones !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboPhoneContactsListenerFlutter.Mesibo_onPhoneContactsDeleted was null, expected non-null List<String?>.');
//           try {
//             api.Mesibo_onPhoneContactsDeleted(arg_phones!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code:
//             'error', message: e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// class _MesiboUIBasicCustomizationListenerFlutterCodec
//     extends StandardMessageCodec {
//   const _MesiboUIBasicCustomizationListenerFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MesiboProfileFlutter) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// abstract class MesiboUIBasicCustomizationListenerFlutter {
//   static const MessageCodec<
//       Object?> codec = _MesiboUIBasicCustomizationListenerFlutterCodec();
//
//   void MesiboUI_onClickCallButton(MesiboProfile profile, bool para_video);
//
//   void MesiboUI_onClickToolbar(MesiboProfile profile);
//
//   void MesiboUI_onClickEndToEndEncryptionInfoButton(MesiboProfile profile);
//
//   static void setup(MesiboUIBasicCustomizationListenerFlutter? api,
//       {BinaryMessenger? binaryMessenger}) {
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickCallButton',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickCallButton was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickCallButton was null, expected non-null MesiboProfileFlutter.');
//           final bool? arg_para_video = (args[1] as bool?);
//           assert(arg_para_video !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickCallButton was null, expected non-null bool.');
//           try {
//             api.MesiboUI_onClickCallButton(arg_profile!, arg_para_video!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error:
//             e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code: 'error', message:
//             e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickToolbar',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       } else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickToolbar was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickToolbar was null, expected non-null MesiboProfileFlutter.');
//           try {
//             api.MesiboUI_onClickToolbar(arg_profile!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error: PlatformException(code:
//             'error', message:
//             e.toString()));
//           }
//         });
//       }
//     }
//     {
//       final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//           'com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickEndToEndEncryptionInfoButton',
//           codec, binaryMessenger:
//       binaryMessenger);
//       if (api == null) {
//         channel.setMessageHandler(null);
//       }
//       else {
//         channel.setMessageHandler((Object? message) async {
//           assert(message !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickEndToEndEncryptionInfoButton was null.');
//           final List<Object?> args = (message as List<Object?>?)!;
//           final MesiboProfile? arg_profile = (args[0] as MesiboProfile?);
//           assert(arg_profile !=
//               null, 'Argument for com.mesibo.mesibo_flutter.MesiboUIBasicCustomizationListenerFlutter.MesiboUI_onClickEndToEndEncryptionInfoButton was null, expected non-null MesiboProfileFlutter.');
//           try {
//             api.MesiboUI_onClickEndToEndEncryptionInfoButton(arg_profile!);
//             return wrapResponse(empty:
//             true);
//           } on PlatformException catch (e) {
//             return wrapResponse(error: e);
//           } catch (e) {
//             return wrapResponse(error:
//             PlatformException(code: 'error', message:
//             e.toString()));
//           }
//         });
//       }
//     }
//   }
// }
//
// class _MesiboPhoneContactsManagerFlutterCodec extends StandardMessageCodec {
//   const _MesiboPhoneContactsManagerFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MESiBOFLuTtERclass) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MesiboProfileFlutter) {
//       buffer.putUint8(129);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MESiBOFLuTtERclass.decode(readValue(buffer)!);
//       case 129:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// class mEsiBoflUTTERcLass {
//   mEsiBoflUTTERcLass({BinaryMessenger? binaryMessenger})
//       : _binaryMessenger= binaryMessenger;
//   final BinaryMessenger? _binaryMessenger;
//   static const MessageCodec<
//       Object?> codec = _MesiboPhoneContactsManagerFlutterCodec();
//
//   Future<void> start() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboPhoneContactsManagerFlutter.start',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     }
//     else {
//       return;
//     }
//   }
//
//   Future<void> setListenerDefault() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboPhoneContactsManagerFlutter.setListenerDefault',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> setCountryCode(String arg_phoneOrCode) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboPhoneContactsManagerFlutter.setCountryCode',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_phoneOrCode]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     }
//     else {
//       return;
//     }
//   }
//
//   Future<void> setCountryCodeFromPhoneNumber(String arg_phone,
//       String? arg_code) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboPhoneContactsManagerFlutter.setCountryCodeFromPhoneNumber',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_phone, arg_code]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<MESiBOFLuTtERclass> getCountryCodeFromPhone(String arg_phone) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboPhoneContactsManagerFlutter.getCountryCodeFromPhone',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_phone]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code: 'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as MESiBOFLuTtERclass?)!;
//     }
//   }
//
//   Future<MESiBOFLuTtERclass> getCountryCode() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboPhoneContactsManagerFlutter.getCountryCode',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as MESiBOFLuTtERclass?)!;
//     }
//   }
//
//   Future<MESiBOFLuTtERclass> getPhoneNumberInfo(String arg_phone,
//       String? arg_code, bool arg_format) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboPhoneContactsManagerFlutter.getPhoneNumberInfo',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_phone, arg_code, arg_format]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as MESiBOFLuTtERclass?)!;
//     }
//   }
// }
//
// class meSiBofLuTtErclass {
//   meSiBofLuTtErclass({BinaryMessenger? binaryMessenger})
//       : _binaryMessenger= binaryMessenger;
//   final BinaryMessenger? _binaryMessenger;
//   static const MessageCodec<Object?> codec = StandardMessageCodec();
//
//   Future<void> enable(bool arg_enable) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboEndToEndEncryptionFlutter.enable',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_enable]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<bool> isEnabled() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboEndToEndEncryptionFlutter.isEnabled',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     }
//     else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as bool?)!;
//     }
//   }
//
//   Future<void> enableSecureOnly(bool arg_enable) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboEndToEndEncryptionFlutter.enableSecureOnly',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_enable]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     }
//     else {
//       return;
//     }
//   }
//
//   Future<bool> isActive(String arg_address) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboEndToEndEncryptionFlutter.isActive',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_address]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String,
//         message: replyList[1] as String?,
//         details:
//         replyList[2],);
//     }
//     else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as bool?)!;
//     }
//   }
// }
//
// class _MesiboFlutterCodec extends StandardMessageCodec {
//   const _MesiboFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MesiboProfileFlutter) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// class MesiboFlutter {
//   MesiboFlutter({BinaryMessenger? binaryMessenger}) :
//         _binaryMessenger= binaryMessenger;
//   final BinaryMessenger? _binaryMessenger;
//   static const MessageCodec<Object?> codec = _MesiboFlutterCodec();
//
//   Future<void> setDatabase(String arg_name) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.setDatabase', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_name]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> backupDatabase(String arg_path) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.backupDatabase', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_path]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> restoreDatabase(String arg_path, int arg_age) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.restoreDatabase', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_path, arg_age]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<String> getAppIdForAccessToken() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.getAppIdForAccessToken', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as String?)!;
//     }
//   }
//
//   Future<void> setAccessToken(String arg_token) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.setAccessToken', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_token]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> setPushToken(String arg_token, bool arg_voip) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.setPushToken', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_token, arg_voip]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     }
//     else {
//       return;
//     }
//   }
//
//   Future<void> start() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.start', codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> stop() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.stop', codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<int> getUid() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.getUid', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as int?)!;
//     }
//   }
//
//   Future<String> getAddress() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.getAddress', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String,
//         message: replyList[1] as String?,
//         details:
//         replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code: 'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as String?)!;
//     }
//   }
//
//   Future<int> getTimestamp() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.getTimestamp', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as int?)!;
//     }
//   }
//
//   Future<int> getUniqueMessageId() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.getUniqueMessageId', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as int?)!;
//     }
//   }
//
//   Future<void> syncPhoneContacts() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.syncPhoneContacts', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     }
//     else {
//       return;
//     }
//   }
//
//   Future<void> syncContact(String arg_address, bool arg_contact,
//       bool arg_subscribe, int arg_visibility) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.syncContact', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(<Object?>[
//       arg_address,
//       arg_contact,
//       arg_subscribe,
//       arg_visibility
//     ]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<MesiboProfileFlutter> getSelfProfile() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.getSelfProfile', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code: 'null-error', message:
//       'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as MesiboProfile?)!;
//     }
//   }
//
//   Future<MesiboProfileFlutter> getProfile(String arg_peer,
//       int arg_group) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboFlutter.getProfile', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_peer, arg_group]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as MesiboProfile?)!;
//     }
//   }
// }
//
// class _MesiboInternalFlutterCodec extends StandardMessageCodec {
//   const _MesiboInternalFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MesiboDateTimeFlutter) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is meSibofLuTtERcLass) {
//       buffer.putUint8(129);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MeSiBOFLUttercLass) {
//       buffer.putUint8(130);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is mEsiBoFLuTTERclAss) {
//       buffer.putUint8(131);
//       writeValue(buffer, value.encode());
//     } else if (value is MEsIbOflutteRclass) {
//       buffer.putUint8(132);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MesiboProfileFlutter) {
//       buffer.putUint8(133);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MesiboProfileFlutter) {
//       buffer.putUint8(134);
//       writeValue(buffer, value.encode());
//     }
//     else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MesiboDateTimeFlutter.decode(readValue(buffer)!);
//       case 129:
//         return meSibofLuTtERcLass.decode(readValue(buffer)!);
//       case 130:
//         return MeSiBOFLUttercLass.decode(readValue(buffer)!);
//       case 131:
//         return mEsiBoFLuTTERclAss.decode(readValue(buffer)!);
//       case 132:
//         return MEsIbOflutteRclass.decode(readValue(buffer)!);
//       case 133:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       case 134:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// class mesibOfLUttErclAss {
//   mesibOfLUttErclAss({BinaryMessenger? binaryMessenger})
//       : _binaryMessenger= binaryMessenger;
//   final BinaryMessenger? _binaryMessenger;
//   static const MessageCodec<Object?> codec = _MesiboInternalFlutterCodec();
//
//   Future<void> createGroup(meSibofLuTtERcLass? arg_settings) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.createGroup', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_settings]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> getSettings(MesiboProfileFlutter arg_profile) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.getSettings', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> getMembers(MesiboProfileFlutter arg_profile, int arg_count,
//       bool arg_restart) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.getMembers', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_count, arg_restart]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> addMember(MesiboProfileFlutter arg_profile, String? arg_address,
//       MeSiBOFLUttercLass? arg_permissions, int arg_pin) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.addMember', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_address, arg_permissions, arg_pin]) as List<
//         Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> removeMember(MesiboProfileFlutter arg_profile,
//       String? arg_address) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.removeMember', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_address]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> join(MesiboProfileFlutter arg_profile, int arg_pin) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.join', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_pin]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> leave(MesiboProfileFlutter arg_profile) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.leave', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> deleteGroup(MesiboProfileFlutter arg_profile) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.deleteGroup', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> addPin(MesiboProfileFlutter arg_profile,
//       MeSiBOFLUttercLass? arg_permissions) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.addPin', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_permissions]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     }
//     else {
//       return;
//     }
//   }
//
//   Future<void> editPin(MesiboProfileFlutter arg_profile, int arg_pin,
//       MeSiBOFLUttercLass? arg_permissions) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.editPin', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_pin, arg_permissions]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> removePin(MesiboProfileFlutter arg_profile, int arg_pin) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.removePin', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_pin]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> setProfile(MesiboProfileFlutter arg_profile) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.setProfile', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> sendMessage(mEsiBoFLuTTERclAss arg_message) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.sendMessage', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_message]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> sendPresence(MEsIbOflutteRclass arg_presence) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.sendPresence', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_presence]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<int> createReadSession(MesiboProfileFlutter? arg_profile,
//       int arg_flags, int arg_threadid, String? arg_query) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.createReadSession',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_flags, arg_threadid, arg_query]) as List<
//         Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as int?)!;
//     }
//   }
//
//   Future<void> ReadSessionEnableFlag(int arg_session, int arg_flag,
//       bool arg_set) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.ReadSessionEnableFlag',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_session, arg_flag, arg_set]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<int> ReadSessionRead(int arg_session, int arg_count) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.ReadSessionRead',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_session, arg_count]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as int?)!;
//     }
//   }
//
//   Future<void> ReadSessionSync(int arg_session, int arg_count) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.ReadSessionSync',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_session, arg_count]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> ReadSessionStop(int arg_session) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.ReadSessionStop',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_session]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> ReadSessionRestart(int arg_session) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.ReadSessionRestart',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_session]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<int> ReadSessionMessageCount(int arg_session, int arg_status) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.ReadSessionMessageCount',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_session, arg_status]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as int?)!;
//     }
//   }
//
//   Future<MesiboDateTimeFlutter> getTimestamp(int arg_ts, bool arg_natural,
//       int arg_accuracy) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboInternalFlutter.getTimestamp', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_ts, arg_natural, arg_accuracy]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     } else {
//       return (replyList[0] as MesiboDateTimeFlutter?)!;
//     }
//   }
// }
//
// class _MesiboUIFlutterCodec extends StandardMessageCodec {
//   const _MesiboUIFlutterCodec();
//
//   @override
//   void writeValue(WriteBuffer buffer, Object? value) {
//     if (value is MesiboProfileFlutter) {
//       buffer.putUint8(128);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MeSIBOFLUTTeRClass) {
//       buffer.putUint8(129);
//       writeValue(buffer, value.encode());
//     }
//     else if (value is MesiboUIOptionsFlutter) {
//       buffer.putUint8(130);
//       writeValue(buffer, value.encode());
//     } else {
//       super.writeValue(buffer, value);
//     }
//   }
//
//   @override
//   Object? readValueOfType(int type, ReadBuffer buffer) {
//     switch (type) {
//       case 128:
//         return MesiboProfileFlutter.decode(readValue(buffer)!);
//       case 129:
//         return MeSIBOFLUTTeRClass.decode(readValue(buffer)!);
//       case 130:
//         return MesiboUIOptionsFlutter.decode(readValue(buffer)!);
//       default:
//         return super.readValueOfType(type, buffer);
//     }
//   }
// }
//
// class MesiboUIFlutter {
//   MesiboUIFlutter({BinaryMessenger? binaryMessenger})
//       : _binaryMessenger= binaryMessenger;
//   final BinaryMessenger? _binaryMessenger;
//   static const MessageCodec<Object?> codec = _MesiboUIFlutterCodec();
//
//   Future<MesiboUIOptionsFlutter> getUiDefaults() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.getUiDefaults', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else if (replyList[0] == null) {
//       throw PlatformException(code:
//       'null-error',
//         message: 'Host platform returned null value for non-null return value.',);
//     }
//     else {
//       return (replyList[0] as MesiboUIOptionsFlutter?)!;
//     }
//   }
//
//   Future<void> setUiDefaults(MesiboUIOptionsFlutter arg_opts) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.setUiDefaults', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_opts]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> launchUserList() async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.launchUserList', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> launchMessaging(MesiboProfileFlutter arg_profile) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.launchMessaging', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message: replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> showBasicProfileInfo(MesiboProfileFlutter arg_profile) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.showBasicProfileInfo', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> showEndToEndEncryptionInfo(
//       MesiboProfileFlutter arg_profile) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.showEndToEndEncryptionInfo',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String, message:
//       replyList[1] as String?, details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> setupBasicCustomizationDefault(
//       MeSIBOFLUTTeRClass arg_buttons) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.setupBasicCustomizationDefault',
//         codec, binaryMessenger:
//     _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_buttons]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     } else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String,
//         message: replyList[1] as String?,
//         details: replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> call(MesiboProfileFlutter arg_profile, bool arg_video) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.call', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(
//         <Object?>[arg_profile, arg_video]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message: 'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code: replyList[0]! as String,
//         message: replyList[1] as String?,
//         details:
//         replyList[2],);
//     } else {
//       return;
//     }
//   }
//
//   Future<void> groupCall(MesiboProfileFlutter arg_profile, bool arg_video,
//       bool arg_audio, bool arg_videoMute, bool arg_audioMute) async {
//     final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
//         'com.mesibo.mesibo_flutter.MesiboUIFlutter.groupCall', codec,
//         binaryMessenger:
//         _binaryMessenger);
//     final List<Object?>? replyList = await channel.send(<Object?>[
//       arg_profile,
//       arg_video,
//       arg_audio,
//       arg_videoMute,
//       arg_audioMute
//     ]) as List<Object?>?;
//     if (replyList == null) {
//       throw PlatformException(code:
//       'channel-error', message:
//       'Unable to establish connection on channel.',);
//     }
//     else if (replyList.length > 1) {
//       throw PlatformException(code:
//       replyList[0]! as String, message:
//       replyList[1] as String?, details:
//       replyList[2],);
//     } else {
//       return;
//     }
//   }
// }
//
// abstract class MesiboMessageListener extends MesiboMessageListenerFlutter {}
//
// abstract class MesiboSyncListener {
//   void Mesibo_onSync(MesiboReadSession rs, int count);
// }
//
// abstract class MesiboConnectionListener
//     extends MesiboConnectionListenerFlutter {}
//
// abstract class MesiboPresenceListener extends MesiboPresenceListenerFlutter {}
//
// abstract class MesiboProfileListener extends MesiboProfileListenerFlutter {}
//
// abstract class MesiboGroupListener extends MesiboGroupListenerFlutter {}
//
// abstract class MesiboPhoneContactsListener
//     extends MesiboPhoneContactsListenerFlutter {}
//
// abstract class MesiboUIBasicCustomizationListener
//     extends MesiboUIBasicCustomizationListenerFlutter {}
//
// abstract class MesiboProfileLocalListener {
//   void MesiboProfile_onUpdate(MesiboProfile profile);
// }
//
// class MesiboReadSession {
//   static const int READSESSION_FLAG_READRECEIPT = 1;
//   static const int READSESSION_FLAG_FIFO = 4;
//   static const int READSESSION_FLAG_SUMMARY = 0x10;
//   static const int READSESSION_FLAG_NOMESSAGES = 0x20;
//   static const int READSESSION_FLAG_THREADED = 0x40;
//   static const int READSESSION_FLAG_WITHFILES = 0x80;
//   static const int READSESSION_FLAG_DELETESESSION = 0x200;
//   static const int READSESSION_FLAG_RESETSESSION = 0x400;
//   static const int READSESSION_FLAG_MISSEDCALLS = 0x1000;
//   static const int READSESSION_FLAG_INCOMINGCALLS = 0x2000;
//   static const int READSESSION_FLAG_OUTGOINGCALLS = 0x4000;
//   static const int MESSAGE_COUNT_ALL = -1;
//   static const int MESSAGE_COUNT_SENT = -2;
//   static const int MESSAGE_COUNT_RECEIEVED = -3;
//   static const int MESSAGE_COUNT_FAILED = -4;
//   static final Map<int, MesiboReadSession> objMap = HashMap();
//   int _session, _flags, _threadId;
//   String? _query;
//   MesiboMessageListener _listener;
//   MesiboSyncListener? _syncListener;
//   MesiboProfile? _profile;
//
//   MesiboReadSession(MesiboProfile? profile, MesiboMessageListener listener)
//       :
//         _session= 0,
//         _flags= 0,
//         _threadId= 0,
//         _query= null,
//         _profile= profile,
//         _listener= listener,
//         _syncListener= null;
//
//   static MesiboReadSession? _getSession(int rsid) {
//     if (objMap.containsKey(rsid)) {
//       return objMap[rsid]!;
//     }
//     return null;
//   }
//
//   static void _addSession(int rsid, MesiboReadSession rs) {
//     objMap[rsid] = rs;
//   }
//
//   void setThreadId(int tid) {
//     _threadId = tid;
//   }
//
//   void setQuery(String? query) {
//     _query = query;
//   }
//
//   Future<int> getMessageCount(int status) async {
//     if (0 == _session) {
//       _session = await MyMesibo.getInternal().createReadSession(
//           _profile, _flags, _threadId, _query) as int;
//       MesiboReadSession._addSession(_session, this);
//     }
//     return await MyMesibo.getInternal().ReadSessionMessageCount(
//         _session, status) as int;
//   }
//
//   Future<int> getTotalMessageCount() async {
//     return getMessageCount(MESSAGE_COUNT_ALL);
//   }
//
//   Future<int> getSentMessageCount() async {
//     return getMessageCount(MESSAGE_COUNT_SENT);
//   }
//
//   Future<int> getReceivedMessageCount() async {
//     return getMessageCount(MESSAGE_COUNT_RECEIEVED);
//   }
//
//   Future<int> getUnreadMessageCount() async {
//     return getMessageCount(0x12);
//   }
//
//   Future<int> getFailedMessageCount() async {
//     return getMessageCount(MESSAGE_COUNT_FAILED);
//   }
//
//   void _enableFlag(int flag, bool enable) {
//     if (enable) {
//       _flags |= flag;
//     } else {
//       _flags &= ~flag;
//     }
//   }
//
//   void enableReadReceipt(bool enable) {
//     _enableFlag(READSESSION_FLAG_READRECEIPT, enable);
//   }
//
//   void enableFifo(bool enable) {
//     _enableFlag(READSESSION_FLAG_FIFO, enable);
//   }
//
//   void enableFiles(bool enable) {
//     _enableFlag(READSESSION_FLAG_WITHFILES, enable);
//   }
//
//   void enableThreads(bool enable) {
//     _enableFlag(READSESSION_FLAG_THREADED, enable);
//   }
//
//   void enableMessages(bool enable) {
//     _enableFlag(READSESSION_FLAG_NOMESSAGES, !enable);
//   }
//
//   void enableMissedCalls(bool enable) {
//     _enableFlag(READSESSION_FLAG_MISSEDCALLS, enable);
//   }
//
//   void enableIncomingCalls(bool enable) {
//     _enableFlag(READSESSION_FLAG_INCOMINGCALLS, enable);
//   }
//
//   void enableOutgoingCalls(bool enable) {
//     _enableFlag(READSESSION_FLAG_OUTGOINGCALLS, enable);
//   }
//
//   void enableCalls(bool enable) {
//     _enableFlag(
//         READSESSION_FLAG_MISSEDCALLS | READSESSION_FLAG_INCOMINGCALLS | READSESSION_FLAG_OUTGOINGCALLS,
//         enable);
//   }
//
//   static MesiboReadSession createReadSummarySession(
//       MesiboMessageListener listener) {
//     MesiboReadSession rs = MesiboReadSession(null, listener);
//     rs._flags |= READSESSION_FLAG_SUMMARY;
//     return rs;
//   }
//
//   static MesiboReadSession createReadSession(MesiboMessageListener listener) {
//     return MesiboReadSession(null, listener);
//   }
//
//   Future<int> read(int count) async {
//     if (0 == _session) {
//       _session = await MyMesibo.getInternal().createReadSession(
//           _profile, _flags, _threadId, _query) as int;
//       MesiboReadSession._addSession(_session, this);
//     }
//     return await MyMesibo.getInternal().ReadSessionRead(_session, count) as int;
//   }
//
//   Future<int> sync(int count, MesiboSyncListener listener) async {
//     if (0 == _session) {
//       _session = await MyMesibo.getInternal().createReadSession(
//           _profile, _flags, _threadId, _query) as int;
//       MesiboReadSession._addSession(_session, this);
//     }
//     _syncListener = listener;
//     return await MyMesibo.getInternal().ReadSessionSync(_session, count) as int;
//   }
// }
//
// class MesiboProfile extends MesiboProfileFlutter {
//   MesiboProfile(
//       {super.address, required super.groupId, required super.uid, super.status, super.name, super.imageUrl, super.imagePath, super.thumbnailPath, required super.selfProfile,});
//
//   void save() {
//     MyMesibo.getInternal().setProfile(this);
//   }
//
//   bool isGroup() {
//     return (super.groupId > 0);
//   }
//
//   String? getAddress() {
//     if (isGroup()) return null;
//     return super.address;
//   }
//
//   String? getNameOrAddress() {
//     if (super.name != null && !super.name!.isEmpty) return super.name;
//     return getAddress();
//   }
//
//   MesiboMessage newMessage() {
//     return MesiboMessage(mid: 0,
//         refid: 0,
//         rsid: 0,
//         type:
//         0,
//         flags: 3,
//         status: 0,
//         expiry: -1,
//         origin: 0,
//         fileType: 0,
//         latitude: -720,
//         longitude: -720,
//         profile:
//         this,
//         groupProfile:
//         null,
//         ts: null);
//   }
//
//   MesiboReadSession createReadSession(MesiboMessageListener listener) {
//     return MesiboReadSession(this, listener);
//   }
//
//   MesiboGroupProfile? getGroupProfile() {
//     if (super.groupId > 0) return this as MesiboGroupProfile;
//     return null;
//   }
//
//   void setImageUrl(String? url) {
//     super.imageUrl = url;
//     if (super.selfProfile) {
//       super.imagePath = null;
//     }
//   }
//
//   void setImagePath(String? path) {
//     super.imagePath = path;
//     if (super.selfProfile) {
//       super.imageUrl = null;
//     }
//   }
// }
//
// class MesiboGroupProfile extends MesiboProfile {
//   MesiboGroupProfile(
//       {super.address, required super.groupId, required super.uid, super.status, super.name, super.imageUrl, super.imagePath, super.thumbnailPath, required super.selfProfile,});
//
//   static final Map<String, MesiboGroupProfile> objMap = HashMap();
//   List<WeakReference<MesiboProfileLocalListener>> mProfileListeners = <
//       WeakReference<MesiboProfileLocalListener>>[];
//
//   static String getHashCode(String? address, int? groupId, bool? selfProfile) {
//     if (selfProfile!) return "self";
//     if (groupId! > 0) return "g:${groupId.toString()}";
//     return "a:${address!}";
//   }
//
//   static MesiboGroupProfile? getCachedProfile(String? address, int? groupId,
//       bool? selfProfile) {
//     String hashid = getHashCode(address, groupId, selfProfile);
//     if (objMap.containsKey(hashid)) {
//       log("cached MesiboGroupProfile for ${objMap[hashid]!.name!} ($hashid)");
//       return objMap[hashid]!;
//     }
//     return null;
//   }
//
//   static MesiboGroupProfile createInstance(List<Object?> result,
//       {String? address, int? groupId, int? uid, String? status, String? name, String? imageUrl, String? imagePath, String? thumbnailPath, bool? selfProfile}) {
//     if (null == groupId) {
//       groupId = 0;
//     }
//     if (null == selfProfile) {
//       selfProfile = false;
//     }
//     String hashid = getHashCode(address, groupId, selfProfile);
//     if (objMap.containsKey(hashid)) {
//       MesiboGroupProfile profile = objMap[hashid]!;
//       profile.name = name;
//       profile.status = status;
//       profile.imagePath = imagePath;
//       profile.imageUrl = imageUrl;
//       profile.thumbnailPath = thumbnailPath;
//       return profile;
//     }
//     MesiboGroupProfile profile = MesiboGroupProfile(address:
//     result[0] as String?,
//       groupId: result[1]! as int,
//       uid: result[2]! as int,
//       status:
//       result[3].toString(),
//       name: result[4] as String?,
//       imageUrl: result[5].toString(),
//       // imagePath: result[6] as String?,
//       // thumbnailPath:
//       // result[7] as String?,
//       selfProfile: false,
//     );
//     objMap[hashid] = profile;
//     return profile;
//   }
//
//   void addListener(MesiboProfileLocalListener listener) {
//     WeakReference<MesiboProfileLocalListener> l = WeakReference<
//         MesiboProfileLocalListener>(listener);
//     mProfileListeners.add(l);
//   }
//
//   void removeListener(MesiboProfileLocalListener listener) {
//     mProfileListeners.removeWhere((l) => l.target == listener);
//   }
//
//   void getMembers(int count, bool restart, MesiboGroupListener listener) {
//     MyMesibo.getInternal().setGetMembersListener(listener);
//     MyMesibo.getInternal().getMembers(this, count, restart);
//   }
//
//   void getSettings(MesiboGroupListener listener) {
//     MyMesibo.getInternal().setGroupSettingsListener(listener);
//     MyMesibo.getInternal().getSettings(this);
//   }
//
//   void join(int pin, MesiboGroupListener listener) {
//     MyMesibo.getInternal().setGroupJoinListener(listener);
//     MyMesibo.getInternal().join(this, pin);
//   }
//
//   void addPin(MeSiBOFLUttercLass permissions, MesiboGroupListener listener) {
//     MyMesibo.getInternal().setGroupSettingsListener(listener);
//     MyMesibo.getInternal().addPin(this, permissions);
//   }
//
//   void addMember(String? address, MesiboMemberPermissions? permissions,
//       int pin) {
//     MyMesibo.getInternal().addMember(this, address, permissions, pin);
//   }
//
//   void removeMember(String? address) {
//     MyMesibo.getInternal().removeMember(this, address);
//   }
// }
//
// class MesiboMessage extends mEsiBoFLuTTERclAss {
//   static const int MESIBO_STATUS_UNKNOWN = 0;
//   static const int MESIBO_STATUS_ONLINE = 1;
//   static const int MESIBO_STATUS_OFFLINE = 2;
//   static const int MESIBO_STATUS_SIGNOUT = 3;
//   static const int MESIBO_STATUS_AUTHFAIL = 4;
//   static const int MESIBO_STATUS_STOPPED = 5;
//   static const int MESIBO_STATUS_CONNECTING = 6;
//   static const int MESIBO_STATUS_CONNECTFAILURE = 7;
//   static const int MESIBO_STATUS_NONETWORK = 8;
//   static const int MESIBO_STATUS_ONPREMISEERROR = 9;
//   static const int MESIBO_STATUS_SUSPEND = 10;
//   static const int MESIBO_STATUS_UPDATE = 20;
//   static const int MESIBO_STATUS_MANDUPDATE = 21;
//   static const int MESIBO_STATUS_SHUTDOWN = 22;
//   static const int MESIBO_STATUS_ACTIVITY = -1;
//   static const int CM_MSGSTATUS_DATETIME = 0x24;
//   static const int MESIBO_FLAG_DELIVERYRECEIPT = 0x1;
//   static const int MESIBO_FLAG_READRECEIPT = 0x2;
//   static const int MESIBO_FLAG_TRANSIENT = 0x4;
//   static const int MESIBO_FLAG_PRESENCE = 0x8;
//   static const int MESIBO_FLAG_FORWARDED = 0x80;
//   static const int MESIBO_FLAG_ENCRYPTED = 0x80;
//   static const int MESIBO_FLAG_TLV = 0x100;
//   static const int CLIENT_MSGFLAG_DELETED = (1 << 55);
//   static const int CLIENT_MSGFLAG_SAVEONLY = (1 << 56);
//   static const int CLIENT_MSGFLAG_WIPED = (1 << 57);
//   static const int CLIENT_MSGFLAG_FILETRANSFERRED = (1 << 58);
//   static const int CLIENT_MSGFLAG_FILEFAILED = (1 << 59);
//   static const int MESIBO_FLAG_MODIFY = 0x40000;
//   static const int MESIBO_FLAG_BROADCAST = 0x80000;
//   static const int MESIBO_FLAG_NONBLOCKING = 0x80000;
//   static const int MESIBO_FLAG_DONTSEND = 0x200000;
//   static const int MESIBO_FLAG_LASTMESSAGE = 0x800000;
//   static const int MESIBO_FLAG_EORS = 0x4000000;
//   static const int MESIBO_FLAG_SAVECUSTOM = (1 << 56);
//   static const int MESIBO_FLAG_FILETRANSFERRED = (1 << 58);
//   static const int MESIBO_FLAG_FILEFAILED = (1 << 59);
//   static const int MESIBO_MSGSTATUS_OUTBOX = 0;
//   static const int MESIBO_MSGSTATUS_SENT = 1;
//   static const int MESIBO_MSGSTATUS_DELIVERED = 2;
//   static const int MESIBO_MSGSTATUS_READ = 3;
//   static const int MESIBO_MSGSTATUS_RECEIVEDNEW = 0x12;
//   static const int MESIBO_MSGSTATUS_RECEIVEDREAD = 0x13;
//   static const int MESIBO_MSGSTATUS_CALLMISSED = 0x15;
//   static const int MESIBO_MSGSTATUS_CALLINCOMING = 0x16;
//   static const int MESIBO_MSGSTATUS_CALLOUTGOING = 0x17;
//   static const int MESIBO_MSGSTATUS_CUSTOM = 0x20;
//   static const int MESIBO_MSGSTATUS_E2E = 0x23;
//   static const int MESIBO_MSGSTATUS_DATETIME = 0x24;
//   static const int MESIBO_MSGSTATUS_HEADER = 0x25;
//   static const int MESIBO_MSGSTATUS_INVISIBLE = 0x26;
//   static const int MESIBO_MSGSTATUS_TIMESTAMP = 0x30;
//   static const int MESIBO_MSGSTATUS_FAIL = 0x80;
//   static const int MESIBO_MSGSTATUS_USEROFFLINE = 0x81;
//   static const int MESIBO_MSGSTATUS_INBOXFULL = 0x82;
//   static const int MESIBO_MSGSTATUS_INVALIDDEST = 0x83;
//   static const int MESIBO_MSGSTATUS_EXPIRED = 0x84;
//   static const int MESIBO_MSGSTATUS_BLOCKED = 0x88;
//   static const int MESIBO_MSGSTATUS_GROUPPAUSED = 0x90;
//   static const int MESIBO_MSGSTATUS_NOTMEMBER = 0x91;
//   static const int MESIBO_RESULT_OK = 0;
//   static const int MESIBO_RESULT_FAIL = 0x80;
//   static const int MESIBO_RESULT_GENERROR = 0x81;
//   static const int MESIBO_RESULT_NOSUCHERROR = 0x83;
//   static const int MESIBO_RESULT_INBOXFULL = 0x84;
//   static const int MESIBO_RESULT_BADREQ = 0x85;
//   static const int MESIBO_RESULT_OVERCAPACITY = 0x86;
//   static const int MESIBO_RESULT_RETRYLATER = 0x87;
//   static const int MESIBO_RESULT_E2EERROR = 0x8A;
//   static const int MESIBO_RESULT_TIMEOUT = 0xB0;
//   static const int MESIBO_RESULT_CONNECTFAIL = 0xB1;
//   static const int MESIBO_RESULT_DISCONNECTED = 0xB2;
//   static const int MESIBO_RESULT_REQINPROGRESS = 0xB3;
//   static const int MESIBO_RESULT_BUFFERFULL = 0xB4;
//   static const int MESIBO_RESULT_AUTHFAIL = 0xC0;
//   static const int MESIBO_RESULT_DENIED = 0xC1;
//   static const int MESIBO_ORIGIN_REALTIME = 0;
//   static const int MESIBO_ORIGIN_DBMESSAGE = 1;
//   static const int MESIBO_ORIGIN_DBSUMMARY = 2;
//   static const int MESIBO_ORIGIN_PENDING = 3;
//
//   MesiboMessage(
//       {required super.mid, required super.refid, required super.rsid, required super.type, required super.flags, required super.status, required super.expiry, required super.origin, super.title, super.subtitle, super.footer, super.message, super.filePath, required super.fileType, required super.latitude, required super.longitude, required super.profile, required super.groupProfile, super.ts,});
//
//   static final Map<int, MesiboMessage> objMap = HashMap();
//
//   static MesiboMessage createInstance(List<Object?> result,
//       {int? mid, int? refid, int? rsid, int? type, int? flags, int? status, int? expiry, int? origin, String? title, String? subtitle, String? footer, String? message, String? filePath, int? fileType, double? latitude, double? longitude, MesiboProfileFlutter? profile, MesiboProfileFlutter? groupProfile, MesiboDateTimeFlutter? ts,}) {
//     int hashid = mid!;
//     if (hashid > 0 && objMap.containsKey(hashid)) {
//       MesiboMessage msg = objMap[hashid]!;
//       msg.refid = refid!;
//       msg.rsid = rsid!;
//       msg.type = type!;
//       msg.flags = flags!;
//       msg.status = status!;
//       msg.expiry = expiry!;
//       msg.origin = origin!;
//       msg.title = title;
//       msg.subtitle = subtitle;
//       msg.footer = footer;
//       msg.message = message;
//       msg.filePath = filePath;
//       msg.fileType = fileType!;
//       msg.latitude = latitude!;
//       msg.longitude = longitude!;
//       msg.ts = ts;
//       return msg;
//     }
//     MesiboMessage msg = MesiboMessage(mid:
//     result[0]! as int,
//       refid: result[1]! as int,
//       rsid: result[2]! as int,
//       type:
//       result[3]! as int,
//       flags: result[4]! as int,
//       status: result[5]! as int,
//       expiry: result[6]! as int,
//       origin: result[7]! as int,
//       title:
//       result[8] as String?,
//       subtitle:
//       result[9] as String?,
//       footer: result[10] as String?,
//       message: result[11] as String?,
//       filePath:
//       result[12] as String?,
//       fileType: result[13]! as int,
//       latitude:
//       result[14]! as double,
//       longitude: result[15]! as double,
//       profile:
//       result[16] != null ? MesiboProfileFlutter.decode(
//           result[16]! as List<Object?>) :
//       null,
//       groupProfile: result[17] != null ? MesiboProfileFlutter.decode(
//           result[17]! as List<Object?>) :
//       null,
//       ts: result[18] != null ? MesiboDateTimeFlutter.decode(
//           result[18]! as List<Object?>) :
//       null,);
//     if (hashid > 0) {
//       objMap[hashid] = msg;
//     }
//     return msg;
//   }
//
//   void setInReplyToMessage(MesiboMessage message) {
//     super.refid = message.mid;
//   }
//
//   void setInReplyTo(int messageid) {
//     super.refid = messageid;
//   }
//
//   int getInReplyTo() {
//     return super.refid;
//   }
//
//   bool isReply() {
//     return (super.refid > 0);
//   }
//
//   bool isFailed() {
//     return ((super.status & MESIBO_MSGSTATUS_FAIL) > 0);
//   }
//
//   void _enableFlag(int flags, bool enable) {
//     if (enable) {
//       super.flags |= flags;
//     }
//     else {
//       super.flags &= ~flags;
//     }
//   }
//
//   void enableTransient(bool enable) {
//     _enableFlag(MESIBO_FLAG_TRANSIENT, enable);
//   }
//
//   void enableReadReceipt(bool enable) {
//     _enableFlag(MESIBO_FLAG_READRECEIPT, enable);
//   }
//
//   void enableDeliveryReceipt(bool enable) {
//     _enableFlag(MESIBO_FLAG_DELIVERYRECEIPT, enable);
//   }
//
//   void enableCustom(bool enable) {
//     _enableFlag(MESIBO_FLAG_SAVECUSTOM, enable);
//   }
//
//   void enableModify(bool enable) {
//     _enableFlag(MESIBO_FLAG_MODIFY, enable);
//   }
//
//   void enableBroadcast(bool enable) {
//     _enableFlag(MESIBO_FLAG_BROADCAST, enable);
//   }
//
//   bool isIncoming() {
//     return (MESIBO_MSGSTATUS_RECEIVEDREAD == super.status ||
//         MESIBO_MSGSTATUS_RECEIVEDNEW == super.status);
//   }
//
//   bool isSent() {
//     return (MESIBO_MSGSTATUS_SENT == super.status);
//   }
//
//   bool isDelivered() {
//     return (MESIBO_MSGSTATUS_DELIVERED == super.status);
//   }
//
//   bool isReadByPeer() {
//     return (MESIBO_MSGSTATUS_READ == super.status);
//   }
//
//   bool isReadByUs() {
//     return (MESIBO_MSGSTATUS_RECEIVEDREAD == super.status);
//   }
//
//   bool isUnread() {
//     return (MESIBO_MSGSTATUS_RECEIVEDNEW == super.status);
//   }
//
//   bool isSavedMessage() {
//     return (MESIBO_MSGSTATUS_CUSTOM == super.status);
//   }
//
//   bool isCustom() {
//     return (MESIBO_MSGSTATUS_CUSTOM == super.status);
//   }
//
//   bool isHeader() {
//     return (MESIBO_MSGSTATUS_HEADER == super.status);
//   }
//
//   bool isInvisible() {
//     return (MESIBO_MSGSTATUS_INVISIBLE == super.status);
//   }
//
//   bool isDate() {
//     return (CM_MSGSTATUS_DATETIME == super.status);
//   }
//
//   bool isMessage() {
//     if (isDate()) return false;
//     if (isCall()) return false;
//     if (isCustom()) return false;
//     return true;
//   }
//
//   bool isDeleted() {
//     return ((super.flags & CLIENT_MSGFLAG_DELETED) > 0 ||
//         (super.flags & CLIENT_MSGFLAG_WIPED) > 0);
//   }
//
//   bool isModified() {
//     return ((super.flags & MESIBO_FLAG_MODIFY) > 0);
//   }
//
//   bool isFileTransferFailed() {
//     if (!isRichMessage()) return false;
//     return ((super.flags & CLIENT_MSGFLAG_FILEFAILED) > 0);
//   }
//
//   bool isForwarded() {
//     return ((super.flags & MESIBO_FLAG_FORWARDED) > 0);
//   }
//
//   bool isEndToEndEncrypted() {
//     return ((super.flags & MESIBO_FLAG_ENCRYPTED) > 0);
//   }
//
//   bool isEndToEndEncryptionStatus() {
//     return (MESIBO_MSGSTATUS_E2E == super.status);
//   }
//
//   bool isRichMessage() {
//     if (isDeleted()) return false;
//     return ((super.flags & MESIBO_FLAG_TLV) > 0);
//   }
//
//   bool isPlainMessage() {
//     return !isRichMessage();
//   }
//
//   bool isMissedCall() {
//     return (MESIBO_MSGSTATUS_CALLMISSED == super.status);
//   }
//
//   bool isIncomingCall() {
//     return (MESIBO_MSGSTATUS_CALLINCOMING == super.status);
//   }
//
//   bool isOutgoingCall() {
//     return (MESIBO_MSGSTATUS_CALLOUTGOING == super.status);
//   }
//
//   bool isCall() {
//     return (MESIBO_MSGSTATUS_CALLMISSED == super.status ||
//         MESIBO_MSGSTATUS_CALLINCOMING == super.status ||
//         MESIBO_MSGSTATUS_CALLOUTGOING == super.status);
//   }
//
//   bool isVideoCall() {
//     return (isCall() && (super.type & 1) > 0);
//   }
//
//   bool isVoiceCall() {
//     return (isCall() && (super.type & 1) == 0);
//   }
//
//   bool isPstnCall() {
//     return false;
//   }
//
//   bool isLastMessage() {
//     return ((super.flags & MESIBO_FLAG_LASTMESSAGE) > 0) ? true :
//     false;
//   }
//
//   bool isOutgoing() {
//     if (isCall() || isSavedMessage() || isIncoming()) return false;
//     if (isCustom() || isHeader() || isDate() || isInvisible()) return false;
//     if (super.status <= MESIBO_MSGSTATUS_READ || isFailed()) {
//       return true;
//     }
//     return false;
//   }
//
//   bool isInOutbox() {
//     return (super.status == MESIBO_MSGSTATUS_OUTBOX);
//   }
//
//   bool isDbMessage() {
//     return (super.origin == MESIBO_ORIGIN_DBMESSAGE);
//   }
//
//   bool isDbSummaryMessage() {
//     return (super.origin == MESIBO_ORIGIN_DBSUMMARY);
//   }
//
//   bool isDbPendingMessage() {
//     return (super.origin == MESIBO_ORIGIN_PENDING);
//   }
//
//   bool isRealtimeMessage() {
//     return (super.origin == MESIBO_ORIGIN_REALTIME);
//   }
//
//   bool isPendingMessage() {
//     return (super.origin == MESIBO_ORIGIN_PENDING);
//   }
//
//   bool isGroupMessage() {
//     return (super.groupProfile != null);
//   }
//
//   int getCallDuration() {
//     if (!isCall()) return -1;
//     return super.expiry;
//   }
//
//   MesiboReadSession? getReadSession() {
//     return MesiboReadSession._getSession(super.rsid);
//   }
//
//   MesiboDateTime getTimestamp() {
//     return super.ts! as MesiboDateTime;
//   }
//
//   void send() {
//     MyMesibo.getInternal().sendMessage(this);
//   }
// }
//
// class MesiboPresence extends MEsIbOflutteRclass {
//   static const int MESIBO_PRESENCE_REQUEST = 0;
//   static const int MESIBO_PRESENCE_ONLINE = 1;
//   static const int MESIBO_PRESENCE_OFFLINE = 2;
//   static const int MESIBO_PRESENCE_TYPING = 3;
//   static const int MESIBO_PRESENCE_TYPINGCLEARED = 4;
//   static const int MESIBO_PRESENCE_JOINED = 10;
//   static const int MESIBO_PRESENCE_LEFT = 11;
//   static const int MESIBO_PRESENCE_RESERVED = 255;
//
//   MesiboPresence(
//       {required super.presence, required super.value, required super.profile, required super.groupProfile,});
//
//   void send() {
//     MyMesibo.getInternal().sendPresence(this);
//   }
//
//   void sendTyping() {
//     presence = MESIBO_PRESENCE_TYPING;
//     value = 0;
//     send();
//   }
//
//   void sendJoined() {
//     presence = MESIBO_PRESENCE_JOINED;
//     value = 0;
//     send();
//   }
//
//   void sendLeft() {
//     presence = MESIBO_PRESENCE_LEFT;
//     value = 0;
//     send();
//   }
//
//   void sendRequest() {
//     presence = MESIBO_PRESENCE_REQUEST;
//     value = 0;
//     send();
//   }
// }
//
// class MesiboDateTime extends MesiboDateTimeFlutter {
//   MesiboDateTime(
//       {super.date, super.ndate, super.time, required super.ts, required super.year, required super.month, required super.wday, required super.day, required super.hour, required super.min, required super.sec,});
//
//   String getDate() {
//     return super.date!;
//   }
//
//   String getTime() {
//     return super.time!;
//   }
//
//   Future<String> getDateInNaturalLanguage(int accuracy) async {
//     MesiboDateTime dt = await MyMesibo.getInternal().getTimestamp(
//         super.ts, true, accuracy) as MesiboDateTime;
//     return Future<String>.value(dt.ndate);
//   }
// }
//
// class MesiboEndToEndEncryption extends meSiBofLuTtErclass {}
//
// class MesiboPhoneContactsManager extends mEsiBoflUTTERcLass {
//   void setListener(MesiboPhoneContactsListener listener) {
//     MyMesibo.getInternal().setPhoneContactsListener(listener);
//     super.setListenerDefault();
//   }
//
//   @override
//   Future<MesiboPhoneContact> getPhoneNumberInfo(String arg_phone,
//       String? arg_code, bool arg_format) async {
//     MesiboPhoneContact c = await super.getPhoneNumberInfo(
//         arg_phone, arg_code, arg_format) as MesiboPhoneContact;
//     return Future<MesiboPhoneContact>.value(c);
//   }
//
//   @override
//   Future<MesiboPhoneContact> getCountryCode() async {
//     MesiboPhoneContact c = await super.getCountryCode() as MesiboPhoneContact;
//     return Future<MesiboPhoneContact>.value(c);
//   }
//
//   @override
//   Future<MesiboPhoneContact> getCountryCodeFromPhone(String arg_phone) async {
//     MesiboPhoneContact c = await super.getCountryCodeFromPhone(
//         arg_phone) as MesiboPhoneContact;
//     return Future<MesiboPhoneContact>.value(c);
//   }
// }
//
// class MesiboPhoneContact extends MESiBOFLuTtERclass {
//   static const int PHONETYPE_INVALID = -1;
//   static const int PHONETYPE_MAYBE = 0;
//   static const int PHONETYPE_VALID = 1;
//   static const int PHONETYPE_MOBILE = 2;
//   static const int PHONETYPE_FIXED = 3;
//   static const int PHONETYPE_TOLLFREE = 4;
//   static const int PHONETYPE_PREMIUM = 5;
//   static const int PHONETYPE_VOIP = 6;
//   static const int PHONETYPE_PRIVATE = 7;
//   static const int PHONETYPE_COUNTRY = 10;
//
//   MesiboPhoneContact(
//       {super.profile, super.name, super.phoneNumber, super.nationalNumber, super.formattedPhoneNumber, super.country, super.countryIsoCode, required super.countryPhoneCode, required super.type, required super.valid, required super.possiblyValid,});
// }
//
// class MesiboInternal extends mesibOfLUttErclAss
//     implements
//         MesiboConnectionListenerFlutter,
//         MesiboMessageListenerFlutter,
//         MesiboProfileListenerFlutter,
//         MesiboPresenceListenerFlutter,
//         MesiboGroupListenerFlutter,
//         MesiboPhoneContactsListener,
//         MesiboSyncListenerFlutter {
//   List<WeakReference<MesiboMessageListenerFlutter>> mMessageListeners = <
//       WeakReference<MesiboMessageListenerFlutter>>[];
//   List<WeakReference<MesiboConnectionListenerFlutter>> mConnectionListeners = <WeakReference<MesiboConnectionListenerFlutter>>[];
//   List<WeakReference<MesiboPresenceListenerFlutter>> mPresenceListeners = <
//       WeakReference<MesiboPresenceListenerFlutter>>[];
//   List<WeakReference<MesiboProfileListenerFlutter>> mProfileListeners = <
//       WeakReference<MesiboProfileListenerFlutter>>[];
//   List<WeakReference<MesiboGroupListenerFlutter>> mGroupListeners = <
//       WeakReference<MesiboGroupListenerFlutter>>[];
//   WeakReference<MesiboGroupListenerFlutter>? mCreateGroupListener;
//   WeakReference<MesiboGroupListenerFlutter>? mGetMembersListener;
//   WeakReference<MesiboGroupListenerFlutter>? mGroupSettingsListener;
//   WeakReference<MesiboGroupListenerFlutter>? mGroupJoinListener;
//   WeakReference<MesiboPhoneContactsListener>? mPhoneContactListener;
//
//   MesiboInternal() :
//         super() {
//     _init();
//   }
//
//   void _init() {
//     log("mesibo listener init");
//     MesiboConnectionListenerFlutter.setup(this);
//     MesiboPresenceListenerFlutter.setup(this);
//     MesiboProfileListenerFlutter.setup(this);
//     MesiboGroupListenerFlutter.setup(this);
//     MesiboMessageListenerFlutter.setup(this);
//     MesiboSyncListenerFlutter.setup(this);
//     MesiboPhoneContactsListenerFlutter.setup(this);
//   }
//
//   void setCreateGroupListener(MesiboGroupListener listener) {
//     mCreateGroupListener = WeakReference<MesiboGroupListenerFlutter>(listener);
//   }
//
//   void setGetMembersListener(MesiboGroupListener listener) {
//     mGetMembersListener = WeakReference<MesiboGroupListenerFlutter>(listener);
//   }
//
//   void setGroupSettingsListener(MesiboGroupListener listener) {
//     mGroupSettingsListener =
//         WeakReference<MesiboGroupListenerFlutter>(listener);
//   }
//
//   void setGroupJoinListener(MesiboGroupListener listener) {
//     mGroupJoinListener = WeakReference<MesiboGroupListenerFlutter>(listener);
//   }
//
//   void setPhoneContactsListener(MesiboPhoneContactsListener listener) {
//     mPhoneContactListener =
//         WeakReference<MesiboPhoneContactsListener>(listener);
//   }
//
//   void setListener(Object? listener) {
//     if (null == listener) return;
//     if (listener is MesiboMessageListenerFlutter) {
//       WeakReference<MesiboMessageListenerFlutter> l = WeakReference<
//           MesiboMessageListenerFlutter>(listener);
//       mMessageListeners.add(l);
//     }
//     if (listener is MesiboConnectionListenerFlutter) {
//       WeakReference<MesiboConnectionListenerFlutter> l = WeakReference<
//           MesiboConnectionListenerFlutter>(listener);
//       mConnectionListeners.add(l);
//     }
//     if (listener is MesiboPresenceListenerFlutter) {
//       WeakReference<MesiboPresenceListenerFlutter> l = WeakReference<
//           MesiboPresenceListenerFlutter>(listener);
//       mPresenceListeners.add(l);
//     }
//     if (listener is MesiboProfileListenerFlutter) {
//       WeakReference<MesiboProfileListenerFlutter> l = WeakReference<
//           MesiboProfileListenerFlutter>(listener);
//       mProfileListeners.add(l);
//     }
//     if (listener is MesiboGroupListenerFlutter) {
//       WeakReference<MesiboGroupListenerFlutter> l = WeakReference<
//           MesiboGroupListenerFlutter>(listener);
//       mGroupListeners.add(l);
//     }
//   }
//
//   @override
//   void Mesibo_onMessage(MesiboMessage message) {
//     log("Mesibo_onMessage rsid: ${message.rsid}");
//     if (message.rsid > 0) {
//       MesiboReadSession? rs = MesiboReadSession._getSession(message.rsid);
//       if (null == rs) return;
//       log("Mesibo_onMessage session found: ${message.rsid}");
//       rs._listener.Mesibo_onMessage(message);
//       return;
//     }
//     for (final w in mMessageListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onMessage(message);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onMessageUpdate(MesiboMessage message) {
//     for (final w in mMessageListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onMessageUpdate(message);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onMessageStatus(MesiboMessage message) {
//     for (final w in mMessageListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onMessageStatus(message);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onSync(int session, int count) {
//     log("Mesibo_onSync session search: ${session}");
//     MesiboReadSession? rs = MesiboReadSession._getSession(session);
//     if (null == rs || null == rs._syncListener) return;
//     log("Mesibo_onSync session found: ${session}");
//     rs._syncListener!.Mesibo_onSync(rs, count);
//     return;
//   }
//
//   @override
//   void Mesibo_onConnectionStatus(int status) {
//     for (final w in mConnectionListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onConnectionStatus(status);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onPresence(MesiboPresence presence) {
//     for (final w in mPresenceListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onPresence(presence);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onPresenceRequest(MesiboPresence presence) {
//     for (final w in mPresenceListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onPresenceRequest(presence);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onProfileUpdated(MesiboProfile profile) {
//     log("Mesibo profile updated:  ${profile.name!}");
//     for (final w in mProfileListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onProfileUpdated(profile);
//       }
//     }
//     MesiboGroupProfile gp = profile as MesiboGroupProfile;
//     for (final w in gp.mProfileListeners) {
//       if (null != w.target) {
//         w.target?.MesiboProfile_onUpdate(profile);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onGroupCreated(MesiboProfile profile) {
//     log("Mesibo_onGroupCreated: ${profile.name!}");
//     if (null == mCreateGroupListener || null == mCreateGroupListener!.target)
//       return;
//     mCreateGroupListener!.target?.Mesibo_onGroupCreated(profile);
//   }
//
//   @override
//   void Mesibo_onGroupJoined(MesiboProfile profile) {
//     log("Mesibo_onGroupJoined: ${profile.name!}");
//     for (final w in mGroupListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onGroupJoined(profile);
//       }
//     }
//     if (null == mGroupJoinListener || null == mGroupJoinListener!.target)
//       return;
//     mGroupJoinListener!.target?.Mesibo_onGroupJoined(profile);
//   }
//
//   @override
//   void Mesibo_onGroupLeft(MesiboProfile profile) {
//     log("Mesibo_onGroupLeft: ${profile.name!}");
//     for (final w in mGroupListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onGroupLeft(profile);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onGroupMembers(MesiboProfile profile,
//       List<MesiboGroupMember?> members) {
//     if (null == mGetMembersListener || null == mGetMembersListener!.target)
//       return;
//     mGetMembersListener!.target?.Mesibo_onGroupMembers(profile, members);
//   }
//
//   @override
//   void Mesibo_onGroupMembersJoined(MesiboProfile profile,
//       List<MesiboGroupMember?> members) {
//     for (final w in mGroupListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onGroupMembersJoined(profile, members);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onGroupMembersRemoved(MesiboProfile profile,
//       List<MesiboGroupMember?> members) {
//     for (final w in mGroupListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onGroupMembersRemoved(profile, members);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onGroupSettings(MesiboProfile profile,
//       MesiboGroupSettings? groupSettings,
//       MesiboMemberPermissions? memberPermissions,
//       List<MesiboGroupPin?> groupPins) {
//     if (null == mGroupSettingsListener ||
//         null == mGroupSettingsListener!.target) return;
//     mGroupSettingsListener!.target?.Mesibo_onGroupSettings(
//         profile, groupSettings, memberPermissions, groupPins);
//   }
//
//   @override
//   void Mesibo_onGroupError(MesiboProfile profile, int error) {
//     for (final w in mGroupListeners) {
//       if (null != w.target) {
//         w.target?.Mesibo_onGroupError(profile, error);
//       }
//     }
//   }
//
//   @override
//   void Mesibo_onPhoneContactsChanged() {
//     if (null == mPhoneContactListener || null == mPhoneContactListener!.target)
//       return;
//     mPhoneContactListener!.target?.Mesibo_onPhoneContactsChanged();
//   }
//
//   @override
//   void Mesibo_onPhoneContactsAdded(List<String?> phones) {
//     if (null == mPhoneContactListener || null == mPhoneContactListener!.target)
//       return;
//     mPhoneContactListener!.target?.Mesibo_onPhoneContactsAdded(phones);
//   }
//
//   @override
//   void Mesibo_onPhoneContactsDeleted(List<String?> phones) {
//     if (null == mPhoneContactListener || null == mPhoneContactListener!.target)
//       return;
//     mPhoneContactListener!.target?.Mesibo_onPhoneContactsDeleted(phones);
//   }
// }
//
// class MyMesibo extends MesiboFlutter {
//   static MyMesibo? _instance = null;
//   static MesiboInternal? _internalInstance = null;
//   static MesiboEndToEndEncryption? _e2ee = null;
//   static MesiboPhoneContactsManager? _phoneContactManager = null;
//   static const int MESIBO_STATUS_UNKNOWN = 0;
//   static const int MESIBO_STATUS_ONLINE = 1;
//   static const int MESIBO_STATUS_OFFLINE = 2;
//   static const int MESIBO_STATUS_SIGNOUT = 3;
//   static const int MESIBO_STATUS_AUTHFAIL = 4;
//   static const int MESIBO_STATUS_STOPPED = 5;
//   static const int MESIBO_STATUS_CONNECTING = 6;
//   static const int MESIBO_STATUS_CONNECTFAILURE = 7;
//   static const int MESIBO_STATUS_NONETWORK = 8;
//   static const int MESIBO_STATUS_ONPREMISEERROR = 9;
//   static const int MESIBO_STATUS_SUSPEND = 10;
//   static const int MESIBO_STATUS_UPDATE = 20;
//   static const int MESIBO_STATUS_MANDUPDATE = 21;
//   static const int MESIBO_STATUS_SHUTDOWN = 22;
//
//   factory MyMesibo(){
//     if (_instance != null) {
//       return _instance!;
//     }
//     _instance = MyMesibo._init();
//     return _instance!;
//   }
//
//   static MyMesibo getInstance() {
//     if (null == _instance) {
//       _instance = MyMesibo();
//     }
//     return _instance!;
//   }
//
//   static MesiboInternal getInternal() {
//     return _internalInstance!;
//   }
//
//   MyMesibo._init() : super(){
//     _internalInstance = MesiboInternal();
//     _e2ee = MesiboEndToEndEncryption();
//     _phoneContactManager = MesiboPhoneContactsManager();
//   }
//
//   void setListener(Object listener) {
//     _internalInstance?.setListener(listener);
//   }
//
//   @override
//   Future<MesiboProfile> getProfile(String? arg_peer, int? arg_group) async {
//     MesiboGroupProfile? profile = MesiboGroupProfile.getCachedProfile(
//         arg_peer, arg_group, false);
//     if (profile != null) return Future<MesiboProfile>.value(profile);
//     profile =
//     await super.getProfile(arg_peer!, arg_group!) as MesiboGroupProfile;
//     return Future<MesiboProfile>.value(profile);
//   }
//
//   Future<MesiboProfile> getUserProfile(String peer) async {
//     return getProfile(peer, 0);
//   }
//
//   Future<MesiboProfile> getGroupProfile(int groupId) async {
//     return getProfile(null, groupId);
//   }
//
//   void createGroup(meSibofLuTtERcLass settings, MesiboGroupListener listener) {
//     _internalInstance?.setCreateGroupListener(listener);
//     _internalInstance?.createGroup(settings);
//   }
//
//   MesiboPhoneContactsManager getPhoneContactsManager() {
//     return _phoneContactManager!;
//   }
//
//   MesiboEndToEndEncryption e2ee() {
//     return _e2ee!;
//   }
// }
//
// class MesiboGroupSettings extends meSibofLuTtERcLass {
//   MesiboGroupSettings(
//       {super.name, super.flags, super.callFlags, super.callDuration, super.videoResolution, super.expiry,});
// }
//
// class MesiboMemberPermissions extends MeSiBOFLUttercLass {
//   MesiboMemberPermissions(
//       {super.flags, super.adminFlags, super.callFlags, super.callDuration, super.videoResolution, super.expiry,});
// }
//
// class MesiboGroupPin extends mESiBOFluttErcLass {
//   MesiboGroupPin({required super.pin, super.permissions,});
// }
//
// class MesiboGroupMember extends MEsIBOfluTterClass {
//   MesiboGroupMember(
//       {super.profile, required super.admin, required super.owner,});
//
//   bool isAdmin() {
//     return super.admin;
//   }
//
//   bool isOwner() {
//     return super.admin;
//   }
//
//   MesiboProfile getProfile() {
//     return super.profile! as MesiboProfile;
//   }
// }
//
// class MesiboUI extends MesiboUIFlutter {
//   void setupBasicCustomization(MesiboUIButtons buttons,
//       MesiboUIBasicCustomizationListener? listener) {
//     buttons.hasListerner = false;
//     if (null != listener) buttons.hasListerner = true;
//     super.setupBasicCustomizationDefault(buttons);
//   }
//
//   @override
//   Future<MesiboUIOptions> getUiDefaults() async {
//     MesiboUIOptions opts = await super.getUiDefaults() as MesiboUIOptions;
//     return Future<MesiboUIOptions>.value(opts);
//   }
// }
//
// class MesiboUIButtons extends MeSIBOFLUTTeRClass {
//   MesiboUIButtons(
//       {super.message, super.audioCall, super.videoCall, super.groupAudioCall, super.groupVideoCall, super.endToEndEncryptionInfo, super.hasListerner,});
// }
//
// class MesiboUIOptions extends MesiboUIOptionsFlutter {
//   MesiboUIOptions(
//       {super.appName, required super.enableForward, required super.enableSearch, required super.enableBackButton, required super.e2eIndicator, super.messageListTitle, super.userListTitle, super.createGroupTitle, super.selectContactTitle, super.selectGroupContactsTitle, super.forwardTitle, super.forwardedTitle, super.userOnlineIndicationTitle, super.onlineIndicationTitle, super.offlineIndicationTitle, super.connectingIndicationTitle, super.noNetworkIndicationTitle, super.suspendedIndicationTitle, super.typingIndicationTitle, super.joinedIndicationTitle, super.e2eeActive, super.e2eeIdentityChanged, super.e2eeInactive, super.emptyUserListMessage, super.emptyMessageListMessage, super.emptySearchListMessage, required super.showRecentInForward, required super.convertSmilyToEmoji, required super.toolbarColor, required super.statusBarColor, required super.toolbarTextColor, required super.userListTypingIndicationColor, required super.userListStatusColor, required super.userListBackgroundColor, required super.messageBackgroundColorForMe, required super.messageBackgroundColorForPeer, required super.titleBackgroundColorForMe, required super.titleBackgroundColorForPeer, required super.messagingBackgroundColor, required super.maxImageFileSize, required super.maxVideoFileSize, required super.verticalImageWidth, required super.horizontalImageWidth, super.recentUsersTitle, super.allUsersTitle, super.groupMembersTitle, super.cancelTitle, super.missedVoiceCallTitle, super.missedVideoCallTitle, super.deletedMessageTitle, super.deleteMessagesTitle, super.deleteForEveryoneTitle, super.deleteForMeTitle, super.deleteTitle,});
// }
//
// abstract class B extends BinaryMessenger {}
//
// void log(String message) {}
//
