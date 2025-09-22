import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final String themeName;

  const ThemeState({
    required this.lightTheme,
    required this.darkTheme,
    required this.themeMode,
    required this.themeName
  });

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  List<Object> get props => [ lightTheme, darkTheme, themeMode, themeName ];
}
