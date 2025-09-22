import 'package:flutter/material.dart';

import 'package:grok/presentation/screens/login_screen.dart';
import 'package:grok/presentation/screens/home_screen.dart';
import 'package:grok/presentation/screens/profile_screen.dart';

import 'package:grok/presentation/screens/holerite/holerite_screen.dart';
import 'package:grok/presentation/screens/holerite/holerite_detail_screen.dart';
import 'package:grok/presentation/screens/holerite/holerite_detail_pdf_screen.dart';

import 'package:grok/presentation/screens/ponto/ponto_screen.dart';
import 'package:grok/presentation/screens/ponto/ponto_detail_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> get() {
    return {
      '/login': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(),
      '/profile': (context) => ProfileScreen(),

      '/holerite': (context) => HoleriteScreen(),
      '/holerite/detail': (context) => HoleriteDetailScreen(),
      '/holerite/detail/pdf': (context) => HoleriteDetailPdfScreen(),

      '/ponto': (context) => PontoScreen(),
      '/ponto/detail': (context) => PontoDetailScreen()
    };
  }
}