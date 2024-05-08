import 'package:flutter/material.dart';

import '../../constants/package_exports.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  String get currentRouteName => GoRouter.of(this)
      .routerDelegate
      .currentConfiguration
      .last
      .matchedLocation;


}
