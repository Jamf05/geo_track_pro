// ignore_for_file: library_private_types_in_public_api

part of '../design.dart';

class StylesFoundation {
  _BoxDecoration get boxDecoration => _BoxDecoration._resolve(brightness);

  _ButtonStyle get buttonStyle => _ButtonStyle._resolve(brightness);

  static final ScrollBehavior scrollBehavior = const ScrollBehavior().copyWith(
    physics: const BouncingScrollPhysics(),
  );

  static const EdgeInsets contentPaddingInput = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  static final List<BoxShadow> boxShadow = <BoxShadow>[
    BoxShadow(
      color: ColorsToken.black.withValues(alpha: 0.2),
      offset: const Offset(0, 2),
      blurRadius: 5,
    ),
  ];
  static final List<BoxShadow> boxShadowDark = <BoxShadow>[
    BoxShadow(
      color: ColorsToken.white.withValues(alpha: 0.2),
      offset: const Offset(0, 2),
      blurRadius: 5,
    ),
  ];

  static final List<BoxShadow> boxShadowAvart = <BoxShadow>[
    BoxShadow(
      color: ColorsToken.black.withValues(alpha: 0.25),
      offset: const Offset(0, 4),
      blurRadius: 5,
    ),
  ];

  static final _Degraded degraded = _Degraded._();
  static final _InputBorder inputBorder = _InputBorder._();

  final Brightness brightness;
  static StylesFoundation of(Brightness brightness) =>
      StylesFoundation._internal(brightness);
  StylesFoundation._internal(this.brightness);

  // elevatedButtonTheme

  ButtonStyle get elevatedButtonStylePrimary => ElevatedButton.styleFrom(
    foregroundColor: ColorsFoundation.text.white,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    backgroundColor: ColorsFoundation.primary,
    disabledBackgroundColor: ColorsFoundation.action.disabledTransparent,
    textStyle: FontsFoundation.of(brightness).elevatedButton.primary,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  ButtonStyle get elevatedButtonStylePrimaryA => ElevatedButton.styleFrom(
    foregroundColor: brightness == Brightness.dark
        ? ColorsFoundation.text.black
        : ColorsFoundation.text.white,
    disabledForegroundColor: ColorsFoundation.text.blackGrey,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    backgroundColor: brightness == Brightness.dark
        ? ColorsFoundation.secondaryA
        : ColorsFoundation.primaryA,
    disabledBackgroundColor: ColorsFoundation.action.disabledSolid,
    textStyle: FontsFoundation.of(brightness).elevatedButton.primaryA,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  ButtonStyle get elevatedButtonStylePrimaryAVariant =>
      ElevatedButton.styleFrom(
        foregroundColor: ColorsFoundation.text.white,
        disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: ColorsFoundation.primaryA,
        disabledBackgroundColor: ColorsFoundation.action.disabledTransparent,
        textStyle: FontsFoundation.of(brightness).elevatedButton.primaryA,
        shape: RoundedRectangleBorder(
          borderRadius: StylesToken.borderR16,
          side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
        ),
      );

  ButtonStyle get elevatedButtonStylePrimaryB => ElevatedButton.styleFrom(
    foregroundColor: brightness == Brightness.dark
        ? ColorsFoundation.text.black
        : ColorsFoundation.text.white,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    backgroundColor: brightness == Brightness.dark
        ? ColorsFoundation.secondaryA
        : ColorsFoundation.primaryA,
    disabledBackgroundColor: brightness == Brightness.dark
        ? ColorsFoundation.background.white
        : ColorsFoundation.action.disabledTransparent,
    textStyle: FontsFoundation.of(brightness).elevatedButton.primaryB,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  ButtonStyle get elevatedButtonStyleWhite => ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: FontsFoundation.of(
      brightness,
    ).elevatedButton.primaryB.color,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    backgroundColor: ColorsFoundation.of(brightness).toggleSwitch.witheAndBlack,
    disabledBackgroundColor: ColorsFoundation.action.disabledTransparent,
    textStyle: FontsFoundation.of(brightness).elevatedButton.primaryB,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  ButtonStyle get elevatedButtonStyleNegative => ElevatedButton.styleFrom(
    foregroundColor: ColorsFoundation.text.white,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    backgroundColor: brightness == Brightness.dark
        ? ColorsFoundation.action.darkNegative
        : ColorsFoundation.action.negative,
    disabledBackgroundColor: ColorsFoundation.action.disabledSolid,
    textStyle: FontsFoundation.of(brightness).elevatedButton.negative,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  // textButtonStyle

  ButtonStyle get textButtonStyleWhite => TextButton.styleFrom(
    foregroundColor: FontsFoundation.of(
      brightness,
    ).textButton.whiteAndBlack.color,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.all(5.0),
    backgroundColor: Colors.transparent,
    textStyle: FontsFoundation.of(brightness).textButton.whiteAndBlack,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  ButtonStyle get textButtonStylePositive => TextButton.styleFrom(
    foregroundColor: ColorsFoundation.action.positive,
    disabledForegroundColor: ColorsFoundation.action.positive,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    backgroundColor: ColorsFoundation.of(brightness).toggleSwitch.witheAndBlack,
    textStyle: FontsFoundation.of(brightness).textButton.positive,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  ButtonStyle get textButtonStyleModalSelectItem => TextButton.styleFrom(
    elevation: 0,
    textStyle: FontsFoundation.of(brightness).paragraph.b2R16,
    foregroundColor: brightness == Brightness.dark
        ? ColorsFoundation.text.white
        : ColorsFoundation.secondaryC,
    fixedSize: const Size(double.infinity, 48),
    alignment: Alignment.centerLeft,
    backgroundColor: brightness == Brightness.dark
        ? ColorsFoundation.background.black
        : ColorsFoundation.background.white,
  );

  ButtonStyle get textButtonStyleModalCancel => TextButton.styleFrom(
    elevation: 0,
    textStyle: FontsFoundation.of(brightness).paragraph.b2R16,
    foregroundColor: brightness == Brightness.dark
        ? ColorsFoundation.background.white
        : ColorsFoundation.background.black,
    fixedSize: const Size(double.infinity, 48),
    alignment: Alignment.centerLeft,
    backgroundColor: brightness == Brightness.dark
        ? ColorsFoundation.background.black
        : ColorsFoundation.background.white,
  );

  ButtonStyle get textButtonStyleModalCancelCalendar => TextButton.styleFrom(
    elevation: 0,
    textStyle: FontsFoundation.of(brightness).paragraph.b2R16,
    foregroundColor: brightness == Brightness.dark
        ? ColorsFoundation.background.white
        : ColorsFoundation.background.black,
    fixedSize: const Size(double.infinity, 48),
    alignment: Alignment.centerLeft,
    backgroundColor: brightness == Brightness.light
        ? ColorsFoundation.background.white
        : ColorsFoundation.background.blackGrey,
  );

  // outlinedButtonStyle

  ButtonStyle get outlinedButtonStylePrimaryB => OutlinedButton.styleFrom(
    foregroundColor: ColorsFoundation.primaryB,
    disabledForegroundColor: ColorsFoundation.text.blackGrey,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: ColorsFoundation.background.white,
    disabledBackgroundColor: ColorsFoundation.text.whiteGrey,
    textStyle: FontsFoundation.of(brightness).outlinedButton.primaryB,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW2.copyWith(color: ColorsFoundation.primaryB),
    ),
    side: StylesToken.borderSW2.copyWith(color: ColorsFoundation.primaryB),
  );

  ButtonStyle get outlinedButtonStyleNegative => OutlinedButton.styleFrom(
    foregroundColor: ColorsFoundation.action.negative,
    disabledForegroundColor: ColorsFoundation.action.negative,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: ColorsFoundation.background.white,
    disabledBackgroundColor: ColorsFoundation.text.whiteGrey,
    textStyle: FontsFoundation.of(brightness).outlinedButton.primaryB,
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW2.copyWith(
        color: ColorsFoundation.action.negative,
      ),
    ),
    side: StylesToken.borderSW2.copyWith(
      color: ColorsFoundation.action.negative,
    ),
  );
}

class _Degraded {
  final LinearGradient one = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: ColorsFoundation.degraded.one,
  );
  final LinearGradient two = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: ColorsFoundation.degraded.two,
  );
  final LinearGradient three = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: ColorsFoundation.degraded.three,
  );

  final LinearGradient four = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: ColorsFoundation.degraded.two,
  );
  final LinearGradient five = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: ColorsFoundation.degraded.four,
  );

  _Degraded._();
}

class _InputBorder {
  static final OutlineInputBorder _defect = OutlineInputBorder(
    borderRadius: StylesToken.borderR16,
    borderSide: StylesToken.borderSW1.copyWith(
      color: ColorsToken.chineseSilver,
    ),
  );

  static final OutlineInputBorder _defaultError = OutlineInputBorder(
    borderRadius: StylesToken.borderR16,
    borderSide: StylesToken.borderSW1.copyWith(
      color: ColorsFoundation.action.negative,
    ),
  );

  final OutlineInputBorder alt = OutlineInputBorder(
    borderRadius: StylesToken.borderR16,
    borderSide: StylesToken.borderSW1.copyWith(color: Colors.transparent),
  );

  final OutlineInputBorder border = _defect;
  final OutlineInputBorder enabledBorder = _defect;
  final OutlineInputBorder focusedBorder = _defect;
  final OutlineInputBorder errorBorder = _defaultError;
  final OutlineInputBorder focusedErrorBorder = _defaultError;

  _InputBorder._();
}

// _BoxDecoration

abstract class _BoxDecoration {
  final BoxDecoration boxDecorationGuage;
  _BoxDecoration(this.boxDecorationGuage);

  static _BoxDecoration _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _BoxDecorationLight._();
      case Brightness.dark:
        return _BoxDecorationDark._();
    }
  }
}

class _BoxDecorationLight implements _BoxDecoration {
  @override
  final BoxDecoration boxDecorationGuage = BoxDecoration(
    color: ColorsFoundation.background.white,
    boxShadow: StylesFoundation.boxShadow,
    borderRadius: BorderRadius.circular(10.0),
  );
  _BoxDecorationLight._();
}

class _BoxDecorationDark implements _BoxDecoration {
  @override
  final BoxDecoration boxDecorationGuage = BoxDecoration(
    color: ColorsFoundation.background.black,
    boxShadow: StylesFoundation.boxShadow,
    border: Border(
      top: BorderSide(color: ColorsFoundation.background.white),
      bottom: BorderSide(color: ColorsFoundation.background.white),
      left: BorderSide(color: ColorsFoundation.background.white),
      right: BorderSide(color: ColorsFoundation.background.white),
    ),
    borderRadius: BorderRadius.circular(10.0),
  );
  _BoxDecorationDark._();
}

// _BoxDecoration

abstract class _ButtonStyle {
  final ButtonStyle elevatedButtonStyleWhiteGrey;
  final ButtonStyle textButtonStyleNegative;
  final ButtonStyle outlinedButtonStylePrimaryB;
  final ButtonStyle elevatedButtonStyleWhiteGrey2;

  _ButtonStyle(
    this.elevatedButtonStyleWhiteGrey,
    this.textButtonStyleNegative,
    this.outlinedButtonStylePrimaryB,
    this.elevatedButtonStyleWhiteGrey2,
  );

  static _ButtonStyle _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _ButtonStyleLight._();
      case Brightness.dark:
        return _ButtonStyleDark._();
    }
  }
}

class _ButtonStyleLight implements _ButtonStyle {
  _ButtonStyleLight._();
  @override
  ButtonStyle get elevatedButtonStyleWhiteGrey => ElevatedButton.styleFrom(
    foregroundColor: ColorsFoundation.text.black,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    backgroundColor: ColorsFoundation.text.whiteGrey,
    elevation: 0,
    disabledBackgroundColor: ColorsFoundation.action.disabledTransparent,
    textStyle: FontsToken.poppinsM16.copyWith(
      color: ColorsFoundation.text.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  @override
  ButtonStyle get textButtonStyleNegative => TextButton.styleFrom(
    foregroundColor: ColorsFoundation.action.negative,
    disabledForegroundColor: ColorsFoundation.action.negative,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    backgroundColor: ColorsFoundation.background.white,
    textStyle: FontsToken.poppinsM16.copyWith(
      color: ColorsFoundation.action.negative,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  @override
  ButtonStyle get outlinedButtonStylePrimaryB => OutlinedButton.styleFrom(
    foregroundColor: ColorsFoundation.primaryB,
    disabledForegroundColor: ColorsFoundation.text.blackGrey,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: ColorsFoundation.background.white,
    disabledBackgroundColor: ColorsFoundation.text.whiteGrey,
    textStyle: FontsToken.poppinsM16.copyWith(color: ColorsFoundation.primaryB),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW2.copyWith(color: ColorsFoundation.primaryB),
    ),
    side: StylesToken.borderSW2.copyWith(color: ColorsFoundation.primaryB),
  );

  @override
  ButtonStyle get elevatedButtonStyleWhiteGrey2 => ElevatedButton.styleFrom(
    foregroundColor: ColorsFoundation.text.black,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: ColorsFoundation.text.whiteGrey,
    elevation: 0,
    disabledBackgroundColor: ColorsFoundation.action.disabledTransparent,
    textStyle: FontsToken.poppinsM16.copyWith(
      color: ColorsFoundation.text.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );
}

class _ButtonStyleDark implements _ButtonStyle {
  _ButtonStyleDark._();
  @override
  ButtonStyle get elevatedButtonStyleWhiteGrey => ElevatedButton.styleFrom(
    foregroundColor: ColorsFoundation.text.blackGrey,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    backgroundColor: ColorsFoundation.background.white,
    elevation: 0,
    disabledBackgroundColor: ColorsFoundation.action.disabledTransparent,
    textStyle: FontsToken.poppinsM16.copyWith(
      color: ColorsFoundation.text.blackGrey,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  @override
  ButtonStyle get textButtonStyleNegative => TextButton.styleFrom(
    foregroundColor: ColorsFoundation.action.darkNegative,
    disabledForegroundColor: ColorsFoundation.action.negative,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    backgroundColor: ColorsFoundation.background.dark,
    textStyle: FontsToken.poppinsM16.copyWith(
      color: ColorsFoundation.action.darkNegative,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );

  @override
  ButtonStyle get outlinedButtonStylePrimaryB => OutlinedButton.styleFrom(
    foregroundColor: ColorsFoundation.secondaryB,
    disabledForegroundColor: ColorsFoundation.text.blackGrey,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: ColorsFoundation.background.black,
    disabledBackgroundColor: ColorsFoundation.text.whiteGrey,
    textStyle: FontsToken.poppinsM16.copyWith(
      color: ColorsFoundation.secondaryB,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW2.copyWith(color: ColorsFoundation.secondaryB),
    ),
    side: StylesToken.borderSW2.copyWith(color: ColorsFoundation.secondaryB),
  );

  @override
  ButtonStyle get elevatedButtonStyleWhiteGrey2 => ElevatedButton.styleFrom(
    foregroundColor: ColorsFoundation.text.blackGrey,
    disabledForegroundColor: ColorsFoundation.action.disabledTransparent,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    backgroundColor: ColorsFoundation.background.white,
    elevation: 0,
    disabledBackgroundColor: ColorsFoundation.action.disabledTransparent,
    textStyle: FontsToken.poppinsM16.copyWith(
      color: ColorsFoundation.text.blackGrey,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: StylesToken.borderR16,
      side: StylesToken.borderSW1.copyWith(color: Colors.transparent),
    ),
  );
}
