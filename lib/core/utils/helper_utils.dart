import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as launch;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../_core.dart';
import '_utils.dart';

class Helpers {
  static String getFileName(File file, {String? prefix}) {
    var name = file.path.split('/').last;
    if (prefix != null) {
      name = "$prefix.${name.split(".").last}";
    }
    return name;
  }

  static num? calculateDistance(num? lat1, num? lon1, num? lat2, num? lon2) {
    if (lat1 == null || lon1 == null || lat2 == null || lon2 == null) {
      return null;
    }

    const double earthRadius = 6371;

    double degreesToRadians(num degrees) {
      return degrees * pi / 180;
    }

    num dLat = degreesToRadians(lat2 - lat1);
    num dLon = degreesToRadians(lon2 - lon1);

    num a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(lat1)) *
            cos(degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    num c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return (earthRadius * c).floor();
  }

  static launchRawUrl(String data) async {
    final launcher = UrlLauncher();

    await launcher.launchRawUrl(data);
  }

  static launchUrl(String? data) async {
    final launcher = UrlLauncher();

    if (data == null) {
      await launcher.launchURL(
        'https://app.google.io/',
      );
      return;
    }

    if (data.isEmail) {
      await launcher.sendEmail(data);

      return;
    }

    if (data.isPhoneNumber) {
      await launcher.dialPhoneNumber(data);
      return;
    }

    await launcher.launchURL(data);
  }

  static launchInappWebView(String url) {
    launch.launchUrl(Uri.parse(url),
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration());
  }

  static void share(String text) {
    Share.share(text);
  }

  static String generateUniqueId() {
    // Create uuid object
    var uuid = const Uuid();

    return uuid.v1();
  }

  static bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0, int maxLines = 3}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: minWidth,
        maxWidth: window.physicalSize.width,
      );
    return textPainter.didExceedMaxLines;
  }

  static Future copy(String text) async {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    ).then(
      (value) => CustomDialogs.showToast('Copied to clipboard'),
    );
  }

  static Future<String> deviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (!Platform.isIOS && !Platform.isAndroid) {
      return 'N/A';
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      return androidInfo.model;
    }

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.utsname.machine ?? 'N/A';
  }

  static Future<String> get selfIP async {
    final ipv4 = await Ipify.ipv4();

    return ipv4;
  }

  static String? calculateAge(String dateOfBirth) {
    if (dateOfBirth.isEmpty) {
      return null;
    }
    DateTime dob = DateTime.parse(dateOfBirth);

    DateTime now = DateTime.now();

    Duration difference = now.difference(dob);

    int age = (difference.inDays / 365).floor();

    return age.toString();
  }

  static void launchTelegram(String groupName) async {
    String url = "https://t.me/$groupName";

    if (await launch.canLaunchUrl(Uri.parse(url))) {
      await launch.launchUrl(
        Uri.parse(url),
        mode: launch.LaunchMode.externalApplication,
      );
    }
  }
}
