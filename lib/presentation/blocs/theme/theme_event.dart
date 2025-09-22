import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final ThemeMode themeMode;
  final String themeName;

  ToggleTheme(this.themeMode, this.themeName);
}

class LoadTheme extends ThemeEvent {}