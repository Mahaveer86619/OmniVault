import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_vault/core/theme/pallete.dart';

// ThemeData lightMode = ThemeData(
//   colorScheme: ColorScheme.light(
//     //* BACKGROUND and SURFACE
//     surface: Pallete.,
//     onSurface: Pallete.lightEverliOnSurface,
//     background: Pallete.lightEverliBackground,
//     onBackground: Pallete.lightEverliOnBackground,

//     //* PRIMARY
//     primary: Pallete.lightEverliPrimary,
//     onPrimary: Pallete.lightEverliOnPrimary,
//     primaryContainer: Pallete.lightEverliPrimary.withAlpha(70),
//     onPrimaryContainer: Pallete.lightEverliOnBackground,

//     //* SECONDARY
//     secondary: Pallete.lightEverliSecondary,
//     onSecondary: Pallete.lightEverliOnSecondary,
//     secondaryContainer: Pallete.lightEverliSecondary.withAlpha(70),
//     onSecondaryContainer: Pallete.lightEverliOnBackground,

//     //* TERTIARY
//     tertiary: Pallete.lightEverliSuccess,
//     onTertiary: Pallete.lightEverliOnSuccess,
//     tertiaryContainer: Pallete.lightEverliSuccess.withAlpha(70),
//     onTertiaryContainer: Pallete.lightEverliOnBackground,

//     //* ERROR
//     error: Pallete.errorColor,
//     onError: Colors.white,
//     errorContainer: Pallete.errorColor.withAlpha(70), // 30% opacity
//     onErrorContainer: Colors.black,
//   ),
//   useMaterial3: true,
//   textTheme: GoogleFonts.nunitoSansTextTheme(),
//   splashColor: Colors.transparent,
//   highlightColor: Colors.transparent,
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     enableFeedback: false,
//     showSelectedLabels: true,
//     showUnselectedLabels: true,
//     selectedItemColor: Pallete.lightEverliPrimary,
//     unselectedItemColor: Pallete.lightEverliSecondary,
//     selectedIconTheme: IconThemeData(color: Pallete.lightEverliPrimary),
//     unselectedIconTheme: IconThemeData(color: Pallete.lightEverliSecondary),
//     selectedLabelStyle: TextStyle(color: Pallete.lightEverliPrimary),
//     unselectedLabelStyle: TextStyle(color: Pallete.lightEverliSecondary),
//   ),
// );

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    //* BACKGROUND and SURFACE
    surface: Pallete.surface,
    onSurface: Pallete.onSurface,
    background: Pallete.background,
    onBackground: Pallete.onBackground,

    //* PRIMARY
    primary: Pallete.primary,
    onPrimary: Pallete.onPrimary,
    primaryContainer: Pallete.primary.withAlpha(70),
    onPrimaryContainer: Pallete.onPrimary,

    //* SECONDARY
    secondary: Pallete.primary,
    onSecondary: Pallete.onPrimary,
    secondaryContainer: Pallete.primary.withAlpha(70),
    onSecondaryContainer: Pallete.onPrimary,

    //* TERTIARY
    tertiary: Pallete.successColor,
    onTertiary: Pallete.onPrimary,
    tertiaryContainer: Pallete.successColor.withAlpha(70),
    onTertiaryContainer: Pallete.onPrimary,

    //* ERROR
    error: Pallete.errorColor,
    onError: Pallete.onPrimary,
    errorContainer: Pallete.errorColor.withAlpha(70),
    onErrorContainer: Pallete.onPrimary,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.nunitoSansTextTheme(),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.shifting,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: Pallete.onBackground,
    unselectedItemColor: Pallete.inactiveBottomBarItemColor,
    selectedIconTheme: IconThemeData(color: Pallete.onBackground),
    unselectedIconTheme:
        IconThemeData(color: Pallete.inactiveBottomBarItemColor),
    selectedLabelStyle: TextStyle(color: Pallete.onBackground),
    unselectedLabelStyle: TextStyle(color: Pallete.inactiveBottomBarItemColor),
  ),
);
