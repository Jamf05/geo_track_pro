part of '../design.dart';

class StylesToken {
  StylesToken._internal();

  static const BorderRadius borderR4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius borderR8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderR12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius borderR16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderR20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius borderR24 = BorderRadius.all(Radius.circular(24));
  static const BorderRadius borderR25 = BorderRadius.all(Radius.circular(25));

  static const BorderSide borderSW1 = BorderSide(
    width: 1.0,
    style: BorderStyle.solid,
  );
  static const BorderSide borderSW2 = BorderSide(width: 2.0, style: BorderStyle.solid);
  static const BorderSide borderSW8 = BorderSide(width: 8.0, style: BorderStyle.solid);
  static const BorderSide borderSW24 = BorderSide(width: 24.0, style: BorderStyle.solid);
}
