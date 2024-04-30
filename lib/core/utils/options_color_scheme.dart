import 'dart:ui';

class OptionsColorScheme {
  final Color bgColor;
  final Color textColor;

  OptionsColorScheme({required this.bgColor, required this.textColor});

  factory OptionsColorScheme.fromIndex(int index) {
    final colors = [
      {'bgColor': const Color(0xFFCBF5E5), 'textColor': const Color(0xFF176448)},
      {'bgColor': const Color(0xFFC2D6FF), 'textColor': const Color(0xFF162664)},
      {'bgColor': const Color(0xFFFBDFB1), 'textColor': const Color(0xFF162664)},
      {'bgColor': const Color(0xFFC2EFFF), 'textColor': const Color(0xFF164564)}, // Corrected hex code
    ];

    final arrayLength = colors.length;
    final adjustedIndex = index % arrayLength;
    final colorMap = colors[adjustedIndex];

    return OptionsColorScheme(
      bgColor: colorMap['bgColor'] as Color,
      textColor: colorMap['textColor'] as Color,
    );
  }
}


