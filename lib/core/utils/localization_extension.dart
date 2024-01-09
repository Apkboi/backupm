//  
//   // import 'package:mentra/generated/l10n.dart';
//
// extension StringLocalization on String {
//   String get i18n {
//     final convertedString = _toLowerCamelCase(this);
//
//     switch (convertedString) {
//       case 'connections':
//     return S.current.connections;
// case 'triberly':
//     return S.current.triberly;
// case 'createAnAccount':
//     return S.current.createAnAccount;
// case 'yourPersonalInformation':
//     return S.current.yourPersonalInformation;
//       default:
//         return this;
//     }
//   }
//
//  
//   String _toLowerCamelCase(String text) {
//     if (text.isEmpty) return text;
//
//     final words = text.trim().split(' ');
//     final capitalized = words.map((word) {
//       if (word == words.first) return word.toLowerCase();
//       return word[0].toUpperCase() + word.substring(1).toLowerCase();
//     });
//
//     return capitalized.join();
//   }
// }
//  