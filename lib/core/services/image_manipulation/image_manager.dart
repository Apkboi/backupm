import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';


class ImageManager {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromCamera(
      {bool? shouldCompress, bool? shouldCrop}) async {
    var permission = await Permission.camera.request();

    if (permission.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        if (shouldCrop ?? false) {
          final imageFile2 = await _cropImage(imageFile);
          imageFile = File(imageFile2!.path);
        }
        if (shouldCompress ?? false) {
          imageFile = await _compressImage(imageFile);
        }

        bool sizeIsAcurate =
            await fileSizeIsAccurate(imageFile, FileType.image);

        if (!sizeIsAcurate) {
          return null;
        }

        return imageFile;
      }

      return null;
    } else {
      return null;
    }
  }

  Future<File?> pickImageFromGallery(
      {bool? shouldCompress, bool? shouldCrop}) async {
    var permission = await Permission.photos.request();
    logger.i(permission.isGranted);

    logger.i('Uploading');
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // if(){}
      if (shouldCrop ?? false) {
        final imageFile2 = await _cropImage(imageFile);

        imageFile = File(imageFile2!.path);
      }
      if (shouldCompress ?? false) {
        imageFile = await _compressImage(imageFile);
      }

      bool sizeIsAcurate = await fileSizeIsAccurate(imageFile, FileType.image);

      if (!sizeIsAcurate) {
        return null;
      }

      return imageFile;
    }
    return null;
  }

  Future<CroppedFile?> _cropImage(File imageFile) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Triberly',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Triberly',
        ),
      ],
    );
  }

  Future<File> _compressImage(File imageFile) async {
    final tempDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final targetPath =
        "${tempDir?.absolute.path}/img_${Random().nextInt(10000)}.jpg";

    final result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      quality: 88,
    );

    if (result != null) {
      return File(result.path);
    } else {
      throw Exception("Failed to compress image");
    }
  }

  Future<File?> showPhotoSourceDialog(BuildContext context,
      {bool? shouldCompress, bool? shouldCrop}) {
    return showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 45.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TextView(
                text: 'Upload Image',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              34.verticalSpace,
              CustomButton(
                child: const Text('Open Camera'),
                onPressed: () async {
                  try {
                    await pickImageFromCamera(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
              20.verticalSpace,
              CustomOutlinedButton(
                child: const Text('Open from gallery'),
                onPressed: () async {
                  try {
                    await pickImageFromGallery(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File?> showDocumentSourceDialog(BuildContext context,
      {bool? shouldCompress, bool? shouldCrop}) {
    return showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 45.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TextView(
                text: 'Upload Image',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              34.verticalSpace,
              CustomButton(
                child: TextView(text: 'Open Camera'),
                onPressed: () async {
                  try {
                    await pickImageFromCamera(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
              20.verticalSpace,
              CustomOutlinedButton(
                child: const TextView(text: 'Upload from gallery'),
                onPressed: () async {
                  try {
                    await pickImageFromGallery(shouldCrop: shouldCrop)
                        .then((value) => Navigator.pop(context, value));
                  } catch (e) {
                    logger.e(e.toString());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<String>> fetchFiles(
      {bool allowMultiple = false,
      String? title,
      FileType fileType = FileType.any,
      bool? checkSize = true,
      List<String>? allowedExtensions}) async {
    try {
      FilePicker filePicker = FilePicker.platform;
      FilePickerResult? result = await filePicker.pickFiles(
        type: fileType,
        allowCompression: true,
        dialogTitle: title ?? 'SELECT FILE',
        withData: true,
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );
      if (result != null) {
        if (checkSize!) {
          var all = await Future.wait(result.files
              .map((e) => fileSizeIsAccurate(File(e.path ?? ""), fileType)));

          if (all.any((element) => !element)) {
            return [];
          }
        }

        return result.files.map((file) => file.path!).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> fileSizeIsAccurate(File file, FileType fileType) async {
    switch (fileType) {
      case FileType.any:
        var isOk = await _fileIsOk((5), file);
        if (!isOk) {
          CustomDialogs.error("Files uploaded should be less that 5MB");
        }
        return isOk;
      case FileType.media:
        var isOk = await _fileIsOk((10), file);
        if (!isOk) {
          CustomDialogs.error("Files uploaded should be less that 10MB");
        }
        return isOk;
      case FileType.image:
        var isOk = await _fileIsOk((5), file);
        if (!isOk) {
          CustomDialogs.error("Images uploaded should be less that 5MB");
        }
        return isOk;
      case FileType.video:
        var isOk = await _fileIsOk((20), file);
        if (!isOk) {
          CustomDialogs.error("Videos uploaded should be less that 20MB");
        }
        return isOk;
      case FileType.audio:
        var isOk = await _fileIsOk((20), file);
        if (!isOk) {
          CustomDialogs.error("Audio files uploaded should be less that 20MB");
        }
        return isOk;
      case FileType.custom:
        var isOk = await _fileIsOk((10), file);
        if (!isOk) {
          CustomDialogs.error("Files files uploaded should be less that 10MB");
        }
        return isOk;
    }
  }

  Future<bool> _fileIsOk(int max, File file) async {
    // int fileSize = await file.length();

    // return true;

    if (file.existsSync()) {
      // Get the file size
      int fileSizeInBytes = (file.lengthSync() / (1024 * 1024)).round();
      logger.e("FILE SIZE ${fileSizeInBytes}");
      try {
        return fileSizeInBytes <= max;
      } catch (e) {
        logger.e(e);
        return false;
      }
    } else {
      return false;
    }
  }
}
