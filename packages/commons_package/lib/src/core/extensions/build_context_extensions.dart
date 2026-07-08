import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  /// Returns the current [ThemeData] for this [BuildContext].
  ThemeData get theme => Theme.of(this);

  /// Returns the current [MediaQueryData] for this [BuildContext].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the current [TextTheme] for this [BuildContext].
  TextTheme get textTheme => theme.textTheme;

  /// Returns the current [ColorScheme] for this [BuildContext].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the current [Brightness] for this [BuildContext].
  Brightness get brightness => mediaQuery.platformBrightness;
}