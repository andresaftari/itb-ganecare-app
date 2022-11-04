import 'package:flutter/material.dart';
import 'package:itb_ganecare/repositories/app_data_repository.dart';

final darkTheme = buildDarkTheme();
final lightTheme = buildLightTheme();

ThemeData buildDarkTheme() {
  Brightness brightness = Brightness.dark;

  Color primary = const Color(0xFF00ACEA); //blue
  Color primaryLight = const Color(0xFF00ACEA);
  Color primaryDark = const Color(0xff007db7);
  Color secondary = const Color(0xFFFF9100); //orange
  Color secondaryLight = const Color(0xffffc246);
  Color secondaryDark = const Color(0xffc56200);
  Color accent = const Color(0xFFAAAAAA);
  Color accentLight = const Color(0xFF636063);
  Color accentDark = Colors.white;
  Color background = const Color(0xFF2B282B);

  return getTheme(
    brightness,
    primary,
    primaryLight,
    primaryDark,
    secondary,
    secondaryLight,
    secondaryDark,
    accent,
    accentLight,
    accentDark,
    background,
  );
}

ThemeData buildLightTheme() {
  Brightness brightness = Brightness.light;
  Color primary = const Color(0xFF00ACEA); //blue
  Color primaryLight = const Color(0xff65DEFF);
  Color primaryDark = const Color(0xff007db7);
  Color secondary = const Color(0xFFFF9100); //orange
  Color secondaryLight = const Color(0xffffc246);
  Color secondaryDark = const Color(0xffc56200);
  Color accent = Colors.grey;

  Color? accentLight = Colors.grey[400];
  Color? accentDark = Colors.grey[900];

  Color background = Colors.white;
  // Color labelPurple = Color();
  // Color labelBlue = Color();
  // Color labelYellow = Color();
  return getTheme(
    brightness,
    primary,
    primaryLight,
    primaryDark,
    secondary,
    secondaryLight,
    secondaryDark,
    accent,
    accentLight,
    accentDark,
    background,
  );
}

ThemeData getTheme(
    brightness,
    primary,
    primaryLight,
    primaryDark,
    secondary,
    secondaryLight,
    secondaryDark,
    accent,
    accentLight,
    accentDark,
    background,
    ) {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: brightness,

    //player chat color
    primaryColor: primary,
    primaryColorLight: primaryLight,
    primaryColorDark: primaryDark,
    secondaryHeaderColor: secondaryLight,

    //for random icons
    indicatorColor: secondary,

    tabBarTheme: TabBarTheme(
      labelColor: secondaryDark,
      unselectedLabelColor: accent,
    ),
    backgroundColor: background,

    // cardColor: ,
    // canvasColor: ,
    dialogBackgroundColor: background,

    // Define the default font family.
    fontFamily: 'Comfortaa',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        fontSize: 20.0,
        fontFamily: "Comfortaa",
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Comfortaa',
      ),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentLight), textSelectionTheme: TextSelectionThemeData(selectionColor: background, selectionHandleColor: accentDark,),
  );
}

class ThemeNotifier with ChangeNotifier {
  AppDataRepository appDataRepository;
  ThemeData? _themeData;

  ThemeNotifier(this._themeData, {required this.appDataRepository});

  getTheme() {
    // harus pake variable ini karena kalau baca dari local ga bisa tanpa async
    return _themeData;
  }

  toggleTheme() async {
    final isDarkMode = await appDataRepository.toggleDarkMode();

    if (isDarkMode != null) {
      if (isDarkMode) {
        _themeData = darkTheme;
      } else {
        _themeData = lightTheme;
      }
    }
    // notifyListeners();
  }
}
