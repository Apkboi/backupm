/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesPngsGen get pngs => const $AssetsImagesPngsGen();
  $AssetsImagesSvgsGen get svgs => const $AssetsImagesSvgsGen();
}

class $AssetsImagesPngsGen {
  const $AssetsImagesPngsGen();

  /// File path: assets/images/pngs/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/pngs/background.png');

  /// File path: assets/images/pngs/brain.png
  AssetGenImage get brain =>
      const AssetGenImage('assets/images/pngs/brain.png');

  /// File path: assets/images/pngs/insight.png
  AssetGenImage get insight =>
      const AssetGenImage('assets/images/pngs/insight.png');

  /// File path: assets/images/pngs/onboarding1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/pngs/onboarding1.png');

  /// File path: assets/images/pngs/onboarding2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/pngs/onboarding2.png');

  /// File path: assets/images/pngs/onboarding3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/pngs/onboarding3.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [background, brain, insight, onboarding1, onboarding2, onboarding3];
}

class $AssetsImagesSvgsGen {
  const $AssetsImagesSvgsGen();

  /// File path: assets/images/svgs/apple.svg
  String get apple => 'assets/images/svgs/apple.svg';

  /// File path: assets/images/svgs/arrow_left.svg
  String get arrowLeft => 'assets/images/svgs/arrow_left.svg';

  /// File path: assets/images/svgs/background.svg
  String get background => 'assets/images/svgs/background.svg';

  /// File path: assets/images/svgs/backspace.svg
  String get backspace => 'assets/images/svgs/backspace.svg';

  /// File path: assets/images/svgs/biometric_btn.svg
  String get biometricBtn => 'assets/images/svgs/biometric_btn.svg';

  /// File path: assets/images/svgs/brain.svg
  String get brain => 'assets/images/svgs/brain.svg';

  /// File path: assets/images/svgs/google.svg
  String get google => 'assets/images/svgs/google.svg';

  /// File path: assets/images/svgs/insights.svg
  String get insights => 'assets/images/svgs/insights.svg';

  /// File path: assets/images/svgs/onboarding1.svg
  String get onboarding1 => 'assets/images/svgs/onboarding1.svg';

  /// File path: assets/images/svgs/user_emoji.svg
  String get userEmoji => 'assets/images/svgs/user_emoji.svg';

  /// List of all assets
  List<String> get values => [
        apple,
        arrowLeft,
        background,
        backspace,
        biometricBtn,
        brain,
        google,
        insights,
        onboarding1,
        userEmoji
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
