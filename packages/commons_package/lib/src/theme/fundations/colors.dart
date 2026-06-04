// ignore_for_file: library_private_types_in_public_api

part of '../design.dart';

/// For more information see:
/// https://m3.material.io/styles/color/the-color-system/color-roles

class ColorsFoundation {
  final Brightness brightness;
  static ColorsFoundation of(Brightness brightness) =>
      ColorsFoundation._internal(brightness);
  ColorsFoundation._internal(this.brightness);

  // primary

  static const Color primary = ColorsToken.oxfordBlue;
  static const Color primaryA = ColorsToken.yaleBlue;
  static const Color primaryB = ColorsToken.blueYonder;
  static const Color primaryC = ColorsToken.ceruleanFrost;

  // secondary

  static const Color secondary = ColorsToken.lightSkyBlue;
  static const Color secondaryA = ColorsToken.babyBlueEyes;
  static const Color secondaryB = ColorsToken.freshAir;
  static const Color secondaryC = ColorsToken.water;

  static const _Text text = _Text._();

  _Icon get icon => _Icon._resolve(brightness);

  static final _Background background = _Background._();

  static final _Action action = _Action._();

  static const _DegradedColor degraded = _DegradedColor._();

  static const _AdvanceArea advanceArea = _AdvanceArea._();

  _ToggleSwitch get toggleSwitch => _ToggleSwitch._resolve(brightness);
}

class _DegradedColor {
  final List<Color> one = const <Color>[
    ColorsToken.richBlack1,
    ColorsToken.yInMnBlue,
    ColorsToken.richBlack2,
  ];

  final List<Color> two = const <Color>[
    ColorsToken.lightSkyBlue,
    ColorsToken.white,
  ];

  final List<Color> three = const <Color>[
    ColorsToken.yaleBlue,
    ColorsToken.ghostWhite,
  ];

  final List<Color> four = const <Color>[
    ColorsToken.lightSkyBlue,
    ColorsToken.eerieBlack,
  ];

  const _DegradedColor._();
}

class _Text {
  final Color primary = ColorsToken.oxfordBlue;
  final Color black = ColorsToken.eerieBlack;
  final Color blackGrey = ColorsToken.slateGray;
  final Color grey = ColorsToken.chineseSilver;
  final Color whiteGrey = ColorsToken.antiFlashWhite;
  final Color whiteBlue = ColorsToken.ghostWhite;
  final Color white = ColorsToken.white;
  final Color blueLigth = ColorsToken.yaleBlue;
  final Color light = ColorsToken.lotion;

  const _Text._();
}

abstract class _Icon {
  final Color appBarIcon;
  final Color elevatedButtonNeutral;
  final Color elevatedButtonBasic;

  const _Icon._(
      this.appBarIcon, this.elevatedButtonNeutral, this.elevatedButtonBasic);

  static _Icon _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _IconLight._();
      case Brightness.dark:
        return _IconDark._();
    }
  }
}

class _IconLight implements _Icon {
  @override
  Color get appBarIcon => ColorsToken.white;

  @override
  Color get elevatedButtonBasic => ColorsToken.black;

  @override
  Color get elevatedButtonNeutral => ColorsToken.slateGray;

  _IconLight._();
}

class _IconDark implements _Icon {
  @override
  Color get appBarIcon => ColorsToken.white;
  @override
  Color get elevatedButtonBasic => ColorsToken.white;

  @override
  Color get elevatedButtonNeutral => ColorsToken.white;

  _IconDark._();
}

class _Background {
  final Color dark = ColorsToken.eerieBlack2;
  final Color white = ColorsToken.white;
  final Color light = ColorsToken.lotion;
  final Color splash = ColorsToken.richBlack;
  final Color onDisabled = ColorsToken.cadetGrey;
  final Color brightGrey = ColorsToken.brightGray;
  final Color disabled = ColorsToken.columbiaBlue;
  final Color disabledSolid = ColorsToken.antiFlashWhite;
  final Color black = ColorsToken.eerieBlack;
  final Color grayShadow = ColorsToken.gray;
  final Color whiteBlue = ColorsToken.ghostWhite;
  final Color blackGrey = ColorsToken.slateGray;
  final Color whiteGrey = ColorsToken.lightGrayishBlue;
  final Color antiFlashWhiteGrey = ColorsToken.antiFlashWhite;

  _Background._();
}

class _AdvanceArea {
  final Color bco = ColorsToken.lightSeaGreen;
  final Color bpo = ColorsToken.blueberry;
  final Color eo = ColorsToken.veryLightBlue;
  final Color oa = ColorsToken.raspberryPink;
  final Color sdt = ColorsToken.orange;
  final Color cei = ColorsToken.jonquil;

  const _AdvanceArea._();
}

class _Action {
  final Color informative = ColorsToken.pictonBlue;
  final Color positive = ColorsToken.salem;
  final Color warning = ColorsToken.orangeYellow;
  final Color negative = ColorsToken.ueRed;
  final Color darkNegative = ColorsToken.mediumVermilion;
  final Color disabledSolid = ColorsToken.antiFlashWhite;
  final Color disabledTransparent = ColorsToken.antiFlashWhite.withValues(alpha: 26);
  final Color actionRegister = ColorsToken.lightGrayishBlue;

  _Action._();
}

abstract class _ToggleSwitch {
  final Color background;
  final Color witheAndBlack;
  final Color blackAndWithe;
  final Color foregroundIcon;
  final Color backgroundIcon;
  final Color expandedButtonColapse;
  final Color tableHeaderBackground;
  final Color expandedButtonExpanded;
  final Color tableHeaderBorderBottom;
  final Color signinTaeButton;
  final Color sectionSelect;

  _ToggleSwitch._(
    this.background,
    this.backgroundIcon,
    this.foregroundIcon,
    this.blackAndWithe,
    this.expandedButtonExpanded,
    this.expandedButtonColapse,
    this.witheAndBlack,
    this.tableHeaderBackground,
    this.tableHeaderBorderBottom,
    this.signinTaeButton,
    this.sectionSelect,
  );

  static _ToggleSwitch _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _ToggleSwitchLight._();
      case Brightness.dark:
        return _ToggleSwitchDark._();
    }
  }
}

class _ToggleSwitchLight implements _ToggleSwitch {
  @override
  final Color background = ColorsToken.brightGray2;

  @override
  final Color backgroundIcon = ColorsToken.charlestonGreen;

  @override
  final Color foregroundIcon = ColorsToken.brightGray2;

  _ToggleSwitchLight._();

  @override
  Color get blackAndWithe => ColorsToken.black;

  @override
  Color get expandedButtonExpanded => ColorsToken.yaleBlue;

  @override
  Color get expandedButtonColapse => ColorsToken.ghostWhite;

  @override
  Color get witheAndBlack => ColorsToken.white;

  @override
  Color get tableHeaderBackground => ColorsToken.ghostWhite;

  @override
  Color get tableHeaderBorderBottom => ColorsToken.lightSkyBlue;

  @override
  Color get signinTaeButton => ColorsToken.antiFlashWhite;

  @override
  Color get sectionSelect => ColorsToken.antiFlashWhite;
}

class _ToggleSwitchDark implements _ToggleSwitch {
  _ToggleSwitchDark._();

  @override
  final Color background = ColorsToken.charlestonGreen;

  @override
  final Color backgroundIcon = ColorsToken.brightGray2;

  @override
  final Color foregroundIcon = ColorsToken.charlestonGreen;

  @override
  Color get blackAndWithe => ColorsToken.white;

  @override
  Color get expandedButtonExpanded => ColorsToken.babyBlueEyes;

  @override
  Color get expandedButtonColapse => ColorsToken.slateGray;

  @override
  Color get witheAndBlack => ColorsToken.eerieBlack2;

  @override
  Color get tableHeaderBackground => ColorsToken.ceruleanFrost;

  @override
  Color get tableHeaderBorderBottom => ColorsToken.oxfordBlue;

  @override
  Color get signinTaeButton => ColorsToken.antiFlashWhite;

  @override
  Color get sectionSelect => ColorsToken.jet;
}
