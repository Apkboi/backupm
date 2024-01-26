import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
import 'package:mentra/features/authentication/data/models/login_preview_response.dart';
import 'package:mentra/features/authentication/data/models/register_payload.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';
import 'package:path_provider/path_provider.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkService _networkService;

  AuthRepositoryImpl(this._networkService);

  @override
  Future<AuthSuccessResponse> register(RegistrationPayload payload) async {
    try {
      final String file = await getAbsolutePath(payload.avatar);
      var formData = FormData.fromMap(payload.toJson());
      formData.files.addAll([
        MapEntry(
            "avatar",
            MultipartFile.fromFileSync(
              file,
            )),
      ]);

      logger.i(formData.files.toString());

      final response = await _networkService.call(
        UrlConfig.register, RequestMethod.post,
        formData: formData,
        // data: formData
      );

      return AuthSuccessResponse.fromJson(response.data);
    } catch (e) {
      logger.i(e.toString());
      rethrow;
    }
  }

  @override
  Future sendOtp(String email) async {
    final response = await _networkService
        .call(UrlConfig.sendOtp, RequestMethod.post, data: {
      "field": "email",
      "value": email,
    });

    return response.data;
  }

  @override
  Future<SuccessResponse> verifyOtp(String email, String otp) async {
    final response = await _networkService.call(
        UrlConfig.verifyOtp, RequestMethod.post,
        data: {"email": email, "code": otp});

    return SuccessResponse.fromJson(response.data);
  }

  @override
  Future<AuthSuccessResponse> login(String email, String password) async {
    final response = await _networkService.call(
        UrlConfig.login, RequestMethod.post,
        data: {"email": email, "password": password});

    return AuthSuccessResponse.fromJson(response.data);
  }

  @override
  Future<LoginPreviewResponse> loginPreview(String email) async {
    final response = await _networkService.call(
        UrlConfig.loginPreview, RequestMethod.post,
        data: {"email": email});

    return LoginPreviewResponse.fromJson(response.data);
  }
}

Future<String> getAbsolutePath(String assetPath) async {
  // final ByteData data = await rootBundle.load(assetPath);
  // ByteData bytes = await rootBundle.load(assetPath);
  final tempDir = await getApplicationDocumentsDirectory();
  final tempFile = File('${tempDir.path}/avatar.png');

  Image blankImage = Image(height: 100, width: 100);

  // Save the image to the specified output path
  tempFile.writeAsBytesSync(Uint8List.fromList(encodePng(blankImage)));

  // var file = await tempFile.create();
  // var fileSizeInBytes = await file.length();
  // double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
  // logger.i(fileSizeInMB);
  // tempFile.writeAsBytes(bytes.buffer.asUint8List());

  return tempFile.path;
}
