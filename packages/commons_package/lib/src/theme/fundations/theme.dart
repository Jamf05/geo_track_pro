part of '../design.dart';

class ThemeFoundation {
  ThemeFoundation._internal();
  static final ThemeData light = ThemeData(

      /**
     * scaffoldBackgroundColor
     */
      scaffoldBackgroundColor: ColorsFoundation.background.light,
      /**
     * appBarTheme
     */
      appBarTheme: AppBarTheme(
        elevation: 1,
        centerTitle: true,
        titleTextStyle: FontsFoundation.of(Brightness.light).appBar.pageTitle,
        backgroundColor: ColorsFoundation.primaryC,
      ),
      /**
     * brightness
     */
      brightness: Brightness.light,
      /**
     * primaryColor
     */
      primaryColor: ColorsFoundation.primary,
      /**
     * colorScheme
     */
      colorScheme: const ColorScheme.light(primary: ColorsFoundation.primaryA),
      /**
     * textButtonTheme
     */
      textButtonTheme: TextButtonThemeData(
          style: StylesFoundation.of(Brightness.light).textButtonStyleWhite),
      /**
     * elevatedButtonTheme
     */
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: StylesFoundation.of(Brightness.light)
              .elevatedButtonStylePrimaryA),
      /**
     * outlinedButtonTheme
     */
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: StylesFoundation.of(Brightness.light)
              .outlinedButtonStylePrimaryB),
      /*
      * titleMedium
      */
      textTheme: TextTheme(
          titleMedium:
              FontsFoundation.of(Brightness.light).inputDecoration.style),
      /**
     * inputDecorationTheme
     */
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: StylesFoundation.contentPaddingInput,
        border: StylesFoundation.inputBorder.border,
        enabledBorder: StylesFoundation.inputBorder.enabledBorder,
        focusedBorder: StylesFoundation.inputBorder.focusedBorder,
        errorBorder: StylesFoundation.inputBorder.errorBorder,
        focusedErrorBorder: StylesFoundation.inputBorder.focusedErrorBorder,
        filled: true,
        fillColor: ColorsToken.white,
        hintStyle:
            FontsFoundation.of(Brightness.light).inputDecoration.hintStyle,
        labelStyle:
            FontsFoundation.of(Brightness.light).inputDecoration.labelStyle,
        errorStyle:
            FontsFoundation.of(Brightness.light).inputDecoration.errorStyle,
      ),
      /**
     * checkboxTheme
     */
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(ColorsFoundation.primary),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(width: 1.5, color: ColorsToken.slateGray)),
          side: const BorderSide(width: 1.5, color: ColorsToken.slateGray)),
      unselectedWidgetColor: ColorsToken.slateGray,
      /**
     * divider
     */
      dividerColor: ColorsToken.antiFlashWhite,
      dividerTheme:
          const DividerThemeData(color: ColorsToken.antiFlashWhite, space: 16),
      /**
     * floatingAction
     */
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsFoundation.primary,
          foregroundColor: ColorsToken.white),
      /**
     * radioTheme
     */
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsFoundation.primary;
          }
          return ColorsFoundation.primary;
        }),
      ),
      /**
     * fontFamily
     */
      fontFamily: FontFamilyToken.poppins,
      /**
     * primaryTextTheme
     */
      primaryTextTheme: const TextTheme(
        bodyLarge: FontsToken.poppinsM16,
        bodyMedium: FontsToken.poppinsM14,
        bodySmall: FontsToken.poppinsM12,
        displayLarge: FontsToken.poppinsM16,
        displayMedium: FontsToken.poppinsM14,
        displaySmall: FontsToken.poppinsM12,
      ));

  static final ThemeData dark = ThemeData(

      /**
     * scaffoldBackgroundColor
     */
      scaffoldBackgroundColor: ColorsFoundation.background.dark,
      /**
     * appBarTheme
     */
      appBarTheme: AppBarTheme(
          elevation: 1,
          centerTitle: true,
          foregroundColor: ColorsToken.white,
          titleTextStyle: FontsFoundation.of(Brightness.dark).appBar.pageTitle),
      /**
     * brightness
     */
      brightness: Brightness.dark,
      /**
     * primaryColor
     */
      primaryColor: ColorsFoundation.secondary,
      /**
     * colorScheme
     */
      colorScheme: const ColorScheme.dark(primary: ColorsFoundation.secondary),
      /**
     * textButtonTheme
     */
      textButtonTheme: TextButtonThemeData(
          style: StylesFoundation.of(Brightness.dark).textButtonStyleWhite),
      /**
     * elevatedButtonTheme
     */
      elevatedButtonTheme: ElevatedButtonThemeData(
          style:
              StylesFoundation.of(Brightness.dark).elevatedButtonStylePrimaryB),
      /**
     * outlinedButtonTheme
     */
      outlinedButtonTheme: OutlinedButtonThemeData(
          style:
              StylesFoundation.of(Brightness.dark).outlinedButtonStylePrimaryB),
      /*
      * titleMedium
      */
      textTheme: TextTheme(
          titleMedium:
              FontsFoundation.of(Brightness.dark).inputDecoration.style),
      /**
     * inputDecorationTheme
     */
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: StylesFoundation.contentPaddingInput,
        border: StylesFoundation.inputBorder.border,
        enabledBorder: StylesFoundation.inputBorder.enabledBorder,
        focusedBorder: StylesFoundation.inputBorder.focusedBorder,
        errorBorder: StylesFoundation.inputBorder.errorBorder,
        focusedErrorBorder: StylesFoundation.inputBorder.focusedErrorBorder,
        filled: true,
        fillColor: ColorsFoundation.background.dark,
        hintStyle:
            FontsFoundation.of(Brightness.dark).inputDecoration.hintStyle,
        labelStyle:
            FontsFoundation.of(Brightness.dark).inputDecoration.labelStyle,
        errorStyle:
            FontsFoundation.of(Brightness.dark).inputDecoration.errorStyle,
      ),
      /**
     * checkboxTheme
     */
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(ColorsFoundation.secondary),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(width: 1.5, color: ColorsToken.slateGray)),
          side: const BorderSide(width: 1.5, color: ColorsToken.slateGray)),
      unselectedWidgetColor: ColorsToken.slateGray,
      /**
     * divider
     */
      dividerColor: ColorsToken.antiFlashWhite,
      dividerTheme:
          const DividerThemeData(color: ColorsToken.antiFlashWhite, space: 16),
      /**
     * floatingAction
     */
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorsFoundation.secondary,
          foregroundColor: ColorsFoundation.text.black),
      /**
     * radioTheme
     */
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return ColorsFoundation.secondary;
          }
          return ColorsFoundation.secondary;
        }),
      ),
      /**
     * fontFamily
     */
      fontFamily: FontFamilyToken.poppins,
      /**
     * primaryTextTheme
     */
      primaryTextTheme: TextTheme(
        bodyLarge: FontsToken.poppinsM16.copyWith(color: Colors.red),
        bodyMedium: FontsToken.poppinsM14.copyWith(color: Colors.red),
        bodySmall: FontsToken.poppinsM12.copyWith(color: Colors.red),
        displayLarge: FontsToken.poppinsM16.copyWith(color: Colors.red),
        displayMedium: FontsToken.poppinsM14.copyWith(color: Colors.red),
        displaySmall: FontsToken.poppinsM12.copyWith(color: Colors.red),
        headlineLarge: FontsToken.poppinsM16.copyWith(color: Colors.red),
        headlineMedium: FontsToken.poppinsM14.copyWith(color: Colors.red),
        headlineSmall: FontsToken.poppinsM12.copyWith(color: Colors.red),
        titleLarge: FontsToken.poppinsM16.copyWith(color: Colors.red),
        titleMedium: FontsToken.poppinsM14.copyWith(color: Colors.red),
        titleSmall: FontsToken.poppinsM12.copyWith(color: Colors.red),
        labelLarge: FontsToken.poppinsM16.copyWith(color: Colors.red),
        labelMedium: FontsToken.poppinsM14.copyWith(color: Colors.red),
        labelSmall: FontsToken.poppinsM12.copyWith(color: Colors.red),
      ));
}
