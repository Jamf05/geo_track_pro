// ignore_for_file: library_private_types_in_public_api

part of '../design.dart';

class FontsTheme {
  final _Poppins poppins;
  final _AppBar appBar;
  final _Title title;
  final _Subtitle subtitle;
  final _Paragraph paragraph;
  final _TextButton textButton;
  final _ElevatedButton elevatedButton;
  final _OutlinedButton outlinedButton;
  final _InputDecoration inputDecoration;

  const FontsTheme({
    required this.poppins,
    required this.appBar,
    required this.title,
    required this.subtitle,
    required this.paragraph,
    required this.textButton,
    required this.elevatedButton,
    required this.outlinedButton,
    required this.inputDecoration,
  });
}

class FontsFoundation {
  final Brightness brightness;
  FontsFoundation._internal(this.brightness);

  FontsTheme get theme {
    switch (brightness) {
      case Brightness.light:
        return FontsTheme(
          poppins: _PoppinsLight._(),
          appBar: _AppBarLight._(),
          title: _TitleLight._(),
          subtitle: _SubtitleLight._(),
          paragraph: _ParagraphLight._(),
          textButton: _TextButtonLight._(),
          elevatedButton: _ElevatedButtonLight._(),
          outlinedButton: _OutlinedButtonLight._(),
          inputDecoration: _InputDecorationLight._(),
        );
      case Brightness.dark:
        return FontsTheme(
          poppins: _PoppinsDark._(),
          appBar: _AppBarDark._(),
          title: _TitleDark._(),
          subtitle: _SubtitleDark._(),
          paragraph: _ParagraphDark._(),
          textButton: _TextButtonDark._(),
          elevatedButton: _ElevatedButtonDark._(),
          outlinedButton: _OutlinedButtonDark._(),
          inputDecoration: _InputDecorationDark._(),
        );
    }
  }

  static FontsFoundation of(Brightness brightness) =>
      FontsFoundation._internal(brightness);
}

// _Poppins

abstract class _Poppins {
  final TextStyle value;
  _Poppins(this.value);
}

class _PoppinsLight implements _Poppins {
  @override
  final TextStyle value = FontsToken.poppins.copyWith(color: ColorsToken.black);
  _PoppinsLight._();
}

class _PoppinsDark implements _Poppins {
  @override
  final TextStyle value = FontsToken.poppins.copyWith(color: ColorsToken.white);
  _PoppinsDark._();
}

// _AppBar

abstract class _AppBar {
  final TextStyle homeTitle;
  final TextStyle pageTitle;
  final TextStyle homeSubtitle;

  _AppBar._(this.homeTitle, this.pageTitle, this.homeSubtitle);
}

class _AppBarLight implements _AppBar {
  late final TextStyle homeTitle;
  late final TextStyle pageTitle;
  late final TextStyle homeSubtitle;

  _AppBarLight._() {
    const white = ColorsToken.white;
    const black = ColorsToken.black;
    homeTitle = FontsToken.poppinsSb24.copyWith(color: white);
    pageTitle = FontsToken.poppinsSb20.copyWith(color: black);
    homeSubtitle = FontsToken.poppinsM12.copyWith(color: white);
  }
}

class _AppBarDark implements _AppBar {
  late final TextStyle homeTitle;
  late final TextStyle pageTitle;
  late final TextStyle homeSubtitle;

  _AppBarDark._() {
    const white = ColorsToken.white;
    homeTitle = FontsToken.poppinsSb24.copyWith(color: white);
    pageTitle = FontsToken.poppinsSb20.copyWith(color: white);
    homeSubtitle = FontsToken.poppinsM12.copyWith(color: white);
  }
}

// _Title

abstract class _Title {
  final TextStyle h1Eb40;
  final TextStyle h1B36;
  final TextStyle h1B32;
  final TextStyle h1B24;
  final TextStyle h1B20;
  final TextStyle h1B18;
  final TextStyle h1B16;
  final TextStyle h1B14;

  _Title(
    this.h1Eb40,
    this.h1B36,
    this.h1B32,
    this.h1B24,
    this.h1B20,
    this.h1B18,
    this.h1B16,
    this.h1B14,
  );
}

class _TitleLight implements _Title {
  late final TextStyle h1Eb40;
  late final TextStyle h1B36;
  late final TextStyle h1B32;
  late final TextStyle h1B24;
  late final TextStyle h1B20;
  late final TextStyle h1B18;
  late final TextStyle h1B16;
  late final TextStyle h1B14;

  _TitleLight._() {
    final Color colorDefault = ColorsFoundation.text.black;
    h1Eb40 = FontsToken.poppinsEb40.copyWith(color: colorDefault);
    h1B36 = FontsToken.poppinsB36.copyWith(color: colorDefault);
    h1B32 = FontsToken.poppinsB32.copyWith(color: colorDefault);
    h1B24 = FontsToken.poppinsB24.copyWith(color: colorDefault);
    h1B20 = FontsToken.poppinsB20.copyWith(color: colorDefault);
    h1B18 = FontsToken.poppinsB18.copyWith(color: colorDefault);
    h1B16 = FontsToken.poppinsB16.copyWith(color: colorDefault);
    h1B14 = FontsToken.poppinsB14.copyWith(color: colorDefault);
  }
}

class _TitleDark implements _Title {
  late final TextStyle h1Eb40;
  late final TextStyle h1B36;
  late final TextStyle h1B32;
  late final TextStyle h1B24;
  late final TextStyle h1B20;
  late final TextStyle h1B18;
  late final TextStyle h1B16;
  late final TextStyle h1B14;

  _TitleDark._() {
    final Color colorDefault = ColorsFoundation.text.white;
    h1Eb40 = FontsToken.poppinsEb40.copyWith(color: colorDefault);
    h1B36 = FontsToken.poppinsB36.copyWith(color: colorDefault);
    h1B32 = FontsToken.poppinsB32.copyWith(color: colorDefault);
    h1B24 = FontsToken.poppinsB24.copyWith(color: colorDefault);
    h1B20 = FontsToken.poppinsB20.copyWith(color: colorDefault);
    h1B18 = FontsToken.poppinsB18.copyWith(color: colorDefault);
    h1B16 = FontsToken.poppinsB16.copyWith(color: colorDefault);
    h1B14 = FontsToken.poppinsB14.copyWith(color: colorDefault);
  }
}

// _Subtitle

abstract class _Subtitle {
  final TextStyle h2Sb24;
  final TextStyle h2Sb20;
  final TextStyle h2Sb18;
  final TextStyle h2Sb16;
  final TextStyle h2Sb14;
  final TextStyle h2Sb12;
  final TextStyle h2Sb10;

  _Subtitle(
    this.h2Sb24,
    this.h2Sb20,
    this.h2Sb18,
    this.h2Sb16,
    this.h2Sb14,
    this.h2Sb12,
    this.h2Sb10,
  );
}

class _SubtitleLight implements _Subtitle {
  late final TextStyle h2Sb24;
  late final TextStyle h2Sb20;
  late final TextStyle h2Sb18;
  late final TextStyle h2Sb16;
  late final TextStyle h2Sb14;
  late final TextStyle h2Sb12;
  late final TextStyle h2Sb10;

  _SubtitleLight._() {
    final Color colorDefault = ColorsFoundation.text.black;
    h2Sb24 = FontsToken.poppinsSb24.copyWith(color: colorDefault);
    h2Sb20 = FontsToken.poppinsSb20.copyWith(color: colorDefault);
    h2Sb18 = FontsToken.poppinsSb18.copyWith(color: colorDefault);
    h2Sb16 = FontsToken.poppinsSb16.copyWith(color: colorDefault);
    h2Sb14 = FontsToken.poppinsSb14.copyWith(color: colorDefault);
    h2Sb12 = FontsToken.poppinsSb12.copyWith(color: colorDefault);
    h2Sb10 = FontsToken.poppinsSb10.copyWith(color: colorDefault);
  }
}

class _SubtitleDark implements _Subtitle {
  late final TextStyle h2Sb24;
  late final TextStyle h2Sb20;
  late final TextStyle h2Sb18;
  late final TextStyle h2Sb16;
  late final TextStyle h2Sb14;
  late final TextStyle h2Sb12;
  late final TextStyle h2Sb10;

  _SubtitleDark._() {
    final Color colorDefault = ColorsFoundation.text.white;
    h2Sb24 = FontsToken.poppinsSb24.copyWith(color: colorDefault);
    h2Sb20 = FontsToken.poppinsSb20.copyWith(color: colorDefault);
    h2Sb18 = FontsToken.poppinsSb18.copyWith(color: colorDefault);
    h2Sb16 = FontsToken.poppinsSb16.copyWith(color: colorDefault);
    h2Sb14 = FontsToken.poppinsSb14.copyWith(color: colorDefault);
    h2Sb12 = FontsToken.poppinsSb12.copyWith(color: colorDefault);
    h2Sb10 = FontsToken.poppinsSb10.copyWith(color: colorDefault);
  }
}

// _Paragraph

abstract class _Paragraph {
  final TextStyle b1R18;
  final TextStyle b1R16;
  final TextStyle b1R12;
  final TextStyle b1M18;
  final TextStyle b1M16;
  final TextStyle b1M14;
  final TextStyle b1M12;
  final TextStyle b2R16;
  final TextStyle b2R14;
  final TextStyle b2R12;
  final TextStyle b2R10;

  _Paragraph(
    this.b1R18,
    this.b1R16,
    this.b1R12,
    this.b1M18,
    this.b1M16,
    this.b1M14,
    this.b1M12,
    this.b2R16,
    this.b2R14,
    this.b2R12,
    this.b2R10,
  );
}

class _ParagraphLight implements _Paragraph {
  late final TextStyle b1R18;
  late final TextStyle b1R16;
  late final TextStyle b1R12;
  late final TextStyle b1M18;
  late final TextStyle b1M16;
  late final TextStyle b1M14;
  late final TextStyle b1M12;
  late final TextStyle b2R16;
  late final TextStyle b2R14;
  late final TextStyle b2R12;
  late final TextStyle b2R10;

  _ParagraphLight._() {
    final Color colorDefault = ColorsFoundation.text.black;
    const TextStyle r18Style = FontsToken.poppinsR18;
    const TextStyle r16Style = FontsToken.poppinsR16;
    const TextStyle r12Style = FontsToken.poppinsR12;
    const TextStyle m18Style = FontsToken.poppinsM18;
    const TextStyle m16Style = FontsToken.poppinsM16;
    const TextStyle m14Style = FontsToken.poppinsM14;
    const TextStyle m12Style = FontsToken.poppinsM12;
    const TextStyle r10Style = FontsToken.poppinsR10;
    
    b1R18 = r18Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b1R16 = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b1R12 = r12Style.copyWith(color: colorDefault);

    b1M18 = m18Style.copyWith(color: colorDefault);
    b1M16 = m16Style.copyWith(color: colorDefault);
    b1M14 = m14Style.copyWith(color: colorDefault);
    b1M12 = m12Style.copyWith(color: colorDefault);

    // ignore: prefer-moving-to-variable
    b2R16 = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b2R14 = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b2R12 = r12Style.copyWith(color: colorDefault);
    b2R10 = r10Style.copyWith(color: colorDefault);
  }
}

class _ParagraphDark implements _Paragraph {
  late final TextStyle b1R18;
  late final TextStyle b1R16;
  late final TextStyle b1R12;
  late final TextStyle b1M18;
  late final TextStyle b1M16;
  late final TextStyle b1M14;
  late final TextStyle b1M12;
  late final TextStyle b2R16;
  late final TextStyle b2R14;
  late final TextStyle b2R12;
  late final TextStyle b2R10;

  _ParagraphDark._() {
    final Color colorDefault = ColorsFoundation.text.white;
    const TextStyle r18Style = FontsToken.poppinsR18;
    const TextStyle r16Style = FontsToken.poppinsR16;
    const TextStyle r12Style = FontsToken.poppinsR12;
    const TextStyle m18Style = FontsToken.poppinsM18;
    const TextStyle m16Style = FontsToken.poppinsM16;
    const TextStyle m14Style = FontsToken.poppinsM14;
    const TextStyle m12Style = FontsToken.poppinsM12;
    const TextStyle r10Style = FontsToken.poppinsR10;
    
    b1R18 = r18Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b1R16 = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b1R12 = r12Style.copyWith(color: colorDefault);

    b1M18 = m18Style.copyWith(color: colorDefault);
    b1M16 = m16Style.copyWith(color: colorDefault);
    b1M14 = m14Style.copyWith(color: colorDefault);
    b1M12 = m12Style.copyWith(color: colorDefault);

    // ignore: prefer-moving-to-variable
    b2R16 = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b2R14 = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    b2R12 = r12Style.copyWith(color: colorDefault);
    b2R10 = r10Style.copyWith(color: colorDefault);
  }
}

abstract class _ElevatedButton {
  final TextStyle primary;
  final TextStyle primaryA;
  final TextStyle primaryB;
  final TextStyle negative;

  _ElevatedButton(this.primary, this.primaryA, this.primaryB, this.negative);
}

class _ElevatedButtonLight implements _ElevatedButton {
  late final TextStyle primary;
  late final TextStyle primaryA;
  late final TextStyle primaryB;
  late final TextStyle negative;

  _ElevatedButtonLight._() {
    final base = FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.white);
    primary = base;
    primaryA = base;
    primaryB = base;
    negative = base;
  }
}

class _ElevatedButtonDark implements _ElevatedButton {
  late final TextStyle primary;
  late final TextStyle primaryA;
  late final TextStyle primaryB;
  late final TextStyle negative;

  _ElevatedButtonDark._() {
    final Color colorDefault = ColorsFoundation.text.black;
    final TextStyle baseStyle = FontsToken.poppinsM16.copyWith(color: colorDefault);
    primary = baseStyle;
    primaryA = baseStyle;
    primaryB = baseStyle;
    negative = baseStyle;
  }
}

abstract class _TextButton {
  final TextStyle whiteAndBlack;
  final TextStyle positive;
  final TextStyle negative;

  _TextButton(this.whiteAndBlack, this.positive, this.negative);
}

class _TextButtonLight implements _TextButton {
  late final TextStyle whiteAndBlack;
  late final TextStyle positive;
  late final TextStyle negative;

  _TextButtonLight._() {
    const base = FontsToken.poppinsM16;
    whiteAndBlack = base.copyWith(color: ColorsFoundation.text.black);
    positive = base.copyWith(color: ColorsFoundation.action.positive);
    negative = base.copyWith(color: ColorsFoundation.action.negative);
  }
}

class _TextButtonDark implements _TextButton {
  late final TextStyle whiteAndBlack;
  late final TextStyle positive;
  late final TextStyle negative;

  _TextButtonDark._() {
    const base = FontsToken.poppinsM16;
    whiteAndBlack = base.copyWith(color: ColorsFoundation.text.white);
    positive = base.copyWith(color: ColorsFoundation.action.positive);
    negative = base.copyWith(color: ColorsFoundation.action.negative);
  }
}

abstract class _OutlinedButton {
  final TextStyle primary;
  final TextStyle primaryB;

  _OutlinedButton(this.primary, this.primaryB);
}

class _OutlinedButtonLight implements _OutlinedButton {
  late final TextStyle primary;
  late final TextStyle primaryB;

  _OutlinedButtonLight._() {
    const TextStyle baseStyle = FontsToken.poppinsM16;
    primary = baseStyle.copyWith(color: ColorsFoundation.primary);
    primaryB = baseStyle.copyWith(color: ColorsFoundation.primaryB);
  }
}

class _OutlinedButtonDark implements _OutlinedButton {
  late final TextStyle primary;
  late final TextStyle primaryB;

  _OutlinedButtonDark._() {
    const TextStyle baseStyle = FontsToken.poppinsM16;
    primary = baseStyle.copyWith(color: ColorsFoundation.primary);
    primaryB = baseStyle.copyWith(color: ColorsFoundation.primaryB);
  }
}

abstract class _InputDecoration {
  final TextStyle style;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final TextStyle errorStyle;

  _InputDecoration(
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
  );
}

class _InputDecorationLight implements _InputDecoration {
  late final TextStyle style;
  late final TextStyle hintStyle;
  late final TextStyle labelStyle;
  late final TextStyle errorStyle;

  _InputDecorationLight._() {
    final Color colorDefault = ColorsFoundation.text.grey;
    const TextStyle r16Style = FontsToken.poppinsR16;
    const TextStyle r11Style = FontsToken.poppinsR11;
    style = r16Style.copyWith(color: ColorsFoundation.text.black);
    // ignore: prefer-moving-to-variable
    hintStyle = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    labelStyle = r16Style.copyWith(color: colorDefault);
    errorStyle = r11Style.copyWith(
      color: ColorsFoundation.action.negative,
    );
  }
}

class _InputDecorationDark implements _InputDecoration {
  late final TextStyle style;
  late final TextStyle hintStyle;
  late final TextStyle labelStyle;
  late final TextStyle errorStyle;

  _InputDecorationDark._() {
    final Color colorDefault = ColorsFoundation.text.white;
    const TextStyle r16Style = FontsToken.poppinsR16;
    const TextStyle r11Style = FontsToken.poppinsR11;
    // ignore: prefer-moving-to-variable
    style = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    hintStyle = r16Style.copyWith(color: colorDefault);
    // ignore: prefer-moving-to-variable
    labelStyle = r16Style.copyWith(color: colorDefault);
    errorStyle = r11Style.copyWith(
      color: ColorsFoundation.action.negative,
    );
  }
}
