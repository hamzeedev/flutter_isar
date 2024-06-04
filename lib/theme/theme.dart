
import 'package:flutter/material.dart';

// ! light
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.blueGrey.shade300,
    primary: Colors.blueGrey.shade200,
    secondary: Colors.blueGrey.shade400,
    inversePrimary: Colors.blueGrey.shade800,
  )
);

// ! Dark
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.blueGrey.shade900,
    primary: Colors.blueGrey.shade800,
    secondary: Colors.blueGrey.shade700,
    inversePrimary: Colors.blueGrey.shade300,
  )
);