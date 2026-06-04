// ignore_for_file: library_private_types_in_public_api

part of '../design.dart';

class FontsFoundation {
  final Brightness brightness;
  static FontsFoundation of(Brightness brightness) =>
      FontsFoundation._internal(brightness);
  FontsFoundation._internal(this.brightness);

  _Poppins get poppins => _Poppins._resolve(brightness);
  _AppBar get appBar => _AppBar._resolve(brightness);
  _Title get title => _Title._resolve(brightness);
  _Subtitle get subtitle => _Subtitle._resolve(brightness);
  _Paragraph get paragraph => _Paragraph._resolve(brightness);
  _TextButton get textButton => _TextButton._resolve(brightness);
  _ElevatedButton get elevatedButton => _ElevatedButton._resolve(brightness);
  _OutlinedButton get outlinedButton => _OutlinedButton._resolve(brightness);
  _InputDecoration get inputDecoration => _InputDecoration._resolve(brightness);
}

// _Poppins

abstract class _Poppins {
  final TextStyle value;
  _Poppins(this.value);

  static _Poppins _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _PoppinsLight._();
      case Brightness.dark:
        return _PoppinsDark._();
    }
  }
}

class _PoppinsLight implements _Poppins {
  _PoppinsLight._();
  @override
  final TextStyle value = FontsToken.poppins.copyWith(color: ColorsToken.black);
}

class _PoppinsDark implements _Poppins {
  _PoppinsDark._();
  @override
  final TextStyle value = FontsToken.poppins.copyWith(color: ColorsToken.white);
}

// _AppBar

abstract class _AppBar {
  final TextStyle homeTitle;
  final TextStyle pageTitle;
  final TextStyle homeSubtitle;
  _AppBar(this.homeTitle, this.pageTitle, this.homeSubtitle);

  static _AppBar _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _AppBarLight._();
      case Brightness.dark:
        return _AppBarDark._();
    }
  }
}

class _AppBarLight implements _AppBar {
  _AppBarLight._();
  @override
  final TextStyle homeTitle =
      FontsToken.poppinsSb24.copyWith(color: ColorsToken.white);
  @override
  final TextStyle pageTitle =
      FontsToken.poppinsSb20.copyWith(color: ColorsToken.black);
  @override
  final TextStyle homeSubtitle =
      FontsToken.poppinsM12.copyWith(color: ColorsToken.white);
}

class _AppBarDark implements _AppBar {
  _AppBarDark._();
  @override
  final TextStyle homeTitle =
      FontsToken.poppinsSb24.copyWith(color: ColorsToken.white);
  @override
  final TextStyle pageTitle =
      FontsToken.poppinsSb20.copyWith(color: ColorsToken.white);
  @override
  final TextStyle homeSubtitle =
      FontsToken.poppinsM12.copyWith(color: ColorsToken.white);
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

  _Title(this.h1Eb40, this.h1B36, this.h1B32, this.h1B24, this.h1B20,
      this.h1B18, this.h1B16, this.h1B14);

  static _Title _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _TitleLight._();
      case Brightness.dark:
        return _TitleDark._();
    }
  }
}

class _TitleLight implements _Title {
  @override
  final TextStyle h1Eb40 =
      FontsToken.poppinsEb40.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h1B36 =
      FontsToken.poppinsB36.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h1B32 =
      FontsToken.poppinsB32.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h1B24 =
      FontsToken.poppinsB24.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h1B20 =
      FontsToken.poppinsB20.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h1B18 =
      FontsToken.poppinsB18.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h1B16 =
      FontsToken.poppinsB16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h1B14 =
      FontsToken.poppinsB14.copyWith(color: ColorsFoundation.text.black);

  _TitleLight._();
}

class _TitleDark implements _Title {
  @override
  final TextStyle h1Eb40 =
      FontsToken.poppinsEb40.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h1B36 =
      FontsToken.poppinsB36.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h1B32 =
      FontsToken.poppinsB32.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h1B24 =
      FontsToken.poppinsB24.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h1B20 =
      FontsToken.poppinsB20.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h1B18 =
      FontsToken.poppinsB18.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h1B16 =
      FontsToken.poppinsB16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h1B14 =
      FontsToken.poppinsB14.copyWith(color: ColorsFoundation.text.white);

  _TitleDark._();
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

  _Subtitle(this.h2Sb24, this.h2Sb20, this.h2Sb18, this.h2Sb16, this.h2Sb14,
      this.h2Sb12, this.h2Sb10);

  static _Subtitle _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _SubtitleLight._();
      case Brightness.dark:
        return _SubtitleDark._();
    }
  }
}

class _SubtitleLight implements _Subtitle {
  @override
  final TextStyle h2Sb24 =
      FontsToken.poppinsSb24.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h2Sb20 =
      FontsToken.poppinsSb20.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h2Sb18 =
      FontsToken.poppinsSb18.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h2Sb16 =
      FontsToken.poppinsSb16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h2Sb14 =
      FontsToken.poppinsSb14.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h2Sb12 =
      FontsToken.poppinsSb12.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle h2Sb10 =
      FontsToken.poppinsSb10.copyWith(color: ColorsFoundation.text.black);

  _SubtitleLight._();
}

class _SubtitleDark implements _Subtitle {
  @override
  final TextStyle h2Sb24 =
      FontsToken.poppinsSb24.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h2Sb20 =
      FontsToken.poppinsSb20.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h2Sb18 =
      FontsToken.poppinsSb18.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h2Sb16 =
      FontsToken.poppinsSb16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h2Sb14 =
      FontsToken.poppinsSb14.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h2Sb12 =
      FontsToken.poppinsSb12.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle h2Sb10 =
      FontsToken.poppinsSb10.copyWith(color: ColorsFoundation.text.white);

  _SubtitleDark._();
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

  _Paragraph(this.b1R18, this.b1R16, this.b1R12, this.b1M18, this.b1M16,
      this.b1M14, this.b1M12, this.b2R16, this.b2R14, this.b2R12, this.b2R10);

  static _Paragraph _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _ParagraphLight._();
      case Brightness.dark:
        return _ParagraphDark._();
    }
  }
}

class _ParagraphLight implements _Paragraph {
  @override
  final TextStyle b1R18 =
      FontsToken.poppinsR18.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b1R16 =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b1R12 =
      FontsToken.poppinsR12.copyWith(color: ColorsFoundation.text.black);

  @override
  final TextStyle b1M18 =
      FontsToken.poppinsM18.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b1M16 =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b1M14 =
      FontsToken.poppinsM14.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b1M12 =
      FontsToken.poppinsM12.copyWith(color: ColorsFoundation.text.black);

  @override
  final TextStyle b2R16 =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b2R14 =
      FontsToken.poppinsR14.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b2R12 =
      FontsToken.poppinsR12.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle b2R10 =
      FontsToken.poppinsR10.copyWith(color: ColorsFoundation.text.black);

  _ParagraphLight._();
}

class _ParagraphDark implements _Paragraph {
  @override
  final TextStyle b1R18 =
      FontsToken.poppinsR18.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b1R16 =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b1R12 =
      FontsToken.poppinsR12.copyWith(color: ColorsFoundation.text.white);

  @override
  final TextStyle b1M18 =
      FontsToken.poppinsM18.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b1M16 =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b1M14 =
      FontsToken.poppinsM14.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b1M12 =
      FontsToken.poppinsM12.copyWith(color: ColorsFoundation.text.white);

  @override
  final TextStyle b2R16 =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b2R14 =
      FontsToken.poppinsR14.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b2R12 =
      FontsToken.poppinsR12.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle b2R10 =
      FontsToken.poppinsR10.copyWith(color: ColorsFoundation.text.white);

  _ParagraphDark._();
}

abstract class _ElevatedButton {
  final TextStyle primary;
  final TextStyle primaryA;
  final TextStyle primaryB;
  final TextStyle negative;

  _ElevatedButton(this.primary, this.primaryA, this.primaryB, this.negative);

  static _ElevatedButton _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _ElevatedButtonLight._();
      case Brightness.dark:
        return _ElevatedButtonDark._();
    }
  }
}

class _ElevatedButtonLight implements _ElevatedButton {
  @override
  final TextStyle primary =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle primaryA =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle primaryB =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle negative =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.white);

  _ElevatedButtonLight._();
}

class _ElevatedButtonDark implements _ElevatedButton {
  @override
  final TextStyle primary =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle primaryA =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle primaryB =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle negative =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.black);

  _ElevatedButtonDark._();
}

abstract class _TextButton {
  final TextStyle whiteAndBlack;
  final TextStyle positive;
  final TextStyle negative;

  _TextButton(this.whiteAndBlack, this.positive, this.negative);

  static _TextButton _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _TextButtonLight._();
      case Brightness.dark:
        return _TextButtonDark._();
    }
  }
}

class _TextButtonLight implements _TextButton {
  @override
  final TextStyle whiteAndBlack =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle positive =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.action.positive);
  @override
  final TextStyle negative =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.action.negative);
  _TextButtonLight._();
}

class _TextButtonDark implements _TextButton {
  @override
  final TextStyle whiteAndBlack =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle positive =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.action.positive);
  @override
  final TextStyle negative =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.action.negative);
  _TextButtonDark._();
}

abstract class _OutlinedButton {
  final TextStyle primary;
  final TextStyle primaryB;

  _OutlinedButton(this.primary, this.primaryB);

  static _OutlinedButton _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _OutlinedButtonLight._();
      case Brightness.dark:
        return _OutlinedButtonDark._();
    }
  }
}

class _OutlinedButtonLight implements _OutlinedButton {
  @override
  final TextStyle primary =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.primary);
  @override
  final TextStyle primaryB =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.primaryB);

  _OutlinedButtonLight._();
}

class _OutlinedButtonDark implements _OutlinedButton {
  @override
  final TextStyle primary =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.primary);
  @override
  final TextStyle primaryB =
      FontsToken.poppinsM16.copyWith(color: ColorsFoundation.primaryB);

  _OutlinedButtonDark._();
}

abstract class _InputDecoration {
  final TextStyle style;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final TextStyle errorStyle;

  _InputDecoration(
      this.style, this.hintStyle, this.labelStyle, this.errorStyle);

  static _InputDecoration _resolve(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return _InputDecorationLight._();
      case Brightness.dark:
        return _InputDecorationDark._();
    }
  }
}

class _InputDecorationLight implements _InputDecoration {
  @override
  final TextStyle style =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.black);
  @override
  final TextStyle hintStyle =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.grey);
  @override
  final TextStyle labelStyle =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.grey);
  @override
  final TextStyle errorStyle =
      FontsToken.poppinsR11.copyWith(color: ColorsFoundation.action.negative);

  _InputDecorationLight._();
}

class _InputDecorationDark implements _InputDecoration {
  @override
  final TextStyle style =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle hintStyle =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle labelStyle =
      FontsToken.poppinsR16.copyWith(color: ColorsFoundation.text.white);
  @override
  final TextStyle errorStyle =
      FontsToken.poppinsR11.copyWith(color: ColorsFoundation.action.negative);

  _InputDecorationDark._();
}
