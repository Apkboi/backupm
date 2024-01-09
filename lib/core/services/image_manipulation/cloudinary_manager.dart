// import 'dart:io';
//
// import 'package:cloudinary/cloudinary.dart';
// import 'package:triberly/core/_core.dart';
//
// class CloudinaryManager {
//   static final Cloudinary cloudinary = Cloudinary.unsignedConfig(
//     cloudName: 'prodevs-outsourcing-inc',
//   );
//
//   static Future<String> uploadFile({
//     required String filePath,
//     required File file,
//     String folder = 'triberly-staging',
//     String fileName = '',
//     CloudinaryResourceType resourceType = CloudinaryResourceType.auto,
//     void Function(int count, int total)? progressCallback,
//   }) async {
//     try {
//       final response = await cloudinary.unsignedUpload(
//         file: file.path,
//         fileBytes: file.readAsBytesSync(),
//         uploadPreset: 'gqb5v6me',
//         folder: folder,
//         fileName: Helpers.generateUniqueId(),
//         resourceType: resourceType,
//         progressCallback: progressCallback,
//       );
//
//       if (response.isSuccessful) {
//         logger.e(response.secureUrl);
//         return response.secureUrl ?? '';
//       } else {
//         throw Exception(
//             'Cloudinary upload failed: ${response.error ?? "Unknown error"}');
//       }
//     } catch (e) {
//       throw Exception('Error uploading to Cloudinary: $e');
//     }
//   }
// }
