import 'dart:ui';

import '_utils.dart';

extension StringExtension on String {

  Color toColor() {
    String hexCode = replaceAll('#', '');

    if (hexCode.length == 6) {
      hexCode = 'FF$hexCode'; // Add alpha value if not provided
    }

    return Color(int.parse(hexCode, radix: 16));
  }


  String formatAmount() {
    if ((int.tryParse(this) ?? 0) > 1) {
      String amount = replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      return amount;
    }

    return this;
  }

  String removeHTML() {
    // return parser.parse(this).text ?? '';

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String parsedstring1 = replaceAll(exp, ' ');

    return parsedstring1.replaceAll('&nbsp', '');
  }

  String removeCommas() {
    String amount = replaceAll(',', '');
    return amount;
  }

  String replacePlus234() {
    if (substring(0, 1) == "+") {
      if (substring(4,5) != "0") {
        String phoneNumber = replaceRange(0, 4, '0');
        return phoneNumber;
      } else {
        String phoneNumber = replaceRange(0, 4, '');
        return phoneNumber;
      }
    } else {
      return this;
    }
  }

  bool get isNum => CustomUtils.isNum(this);

  bool get isNumericOnly => CustomUtils.isNumericOnly(this);

  bool get isAlphabetOnly => CustomUtils.isAlphabetOnly(this);

  bool get isBool => CustomUtils.isBool(this);

  bool get isVectorFileName => CustomUtils.isVector(this);

  bool get isImageFileName => CustomUtils.isImage(this);

  bool get isAudioFileName => CustomUtils.isAudio(this);

  bool get isVideoFileName => CustomUtils.isVideo(this);

  bool get isTxtFileName => CustomUtils.isTxt(this);

  bool get isDocumentFileName => CustomUtils.isWord(this);

  bool get isExcelFileName => CustomUtils.isExcel(this);

  bool get isPPTFileName => CustomUtils.isPPT(this);

  bool get isAPKFileName => CustomUtils.isAPK(this);

  bool get isPDFFileName => CustomUtils.isPDF(this);

  bool get isHTMLFileName => CustomUtils.isHTML(this);

  bool get isURL => CustomUtils.isURL(this);

  bool get isEmail => CustomUtils.isEmail(this);

  bool get isPhoneNumber => CustomUtils.isPhoneNumber(this);

  bool get isDateTime => CustomUtils.isDateTime(this);

  bool get isMD5 => CustomUtils.isMD5(this);

  bool get isSHA1 => CustomUtils.isSHA1(this);

  bool get isSHA256 => CustomUtils.isSHA256(this);

  bool get isBinary => CustomUtils.isBinary(this);

  bool get isIPv4 => CustomUtils.isIPv4(this);

  bool get isIPv6 => CustomUtils.isIPv6(this);

  bool get isHexadecimal => CustomUtils.isHexadecimal(this);

  bool get isPalindrom => CustomUtils.isPalindrom(this);

  String get formatDatetime => CustomUtils.formatDateTime(this);

  bool get isPassport => CustomUtils.isPassport(this);

  bool get isCurrency => CustomUtils.isCurrency(this);

  bool get isCpf => CustomUtils.isCpf(this);

  bool get isCnpj => CustomUtils.isCnpj(this);

  bool isCaseInsensitiveContains(String b) =>
      CustomUtils.isCaseInsensitiveContains(this, b);

  bool isCaseInsensitiveContainsAny(String b) =>
      CustomUtils.isCaseInsensitiveContainsAny(this, b);

  String? get capitalize => CustomUtils.capitalize(this);

  String? get getTime => CustomUtils.getTime(this);

  String? get getDate => CustomUtils.getDate(this);

  String? get getDateWithText => CustomUtils.getDateWithText(this);

  String? get getTimeWithText => CustomUtils.getTimeWithText(this);

  String? get capitalizeFirst => CustomUtils.capitalizeFirst(this);

  String get removeAllWhitespace => CustomUtils.removeAllWhitespace(this);

  String get removeFormat => CustomUtils.removeFormat(this);

  String? get camelCase => CustomUtils.camelCase(this);

  String? get paramCase => CustomUtils.paramCase(this);

  String numericOnly({bool firstWordOnly = false}) =>
      CustomUtils.numericOnly(this, firstWordOnly: firstWordOnly);

  String createPath([Iterable? segments]) {
    final path = startsWith('/') ? this : '/$this';
    return CustomUtils.createPath(path, segments);
  }
}

extension NumExtension on num {
  num? getDiscount(num discount) =>
      CustomUtils.getDiscountedPrice(this, discount);
}
