import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/core/di/injection.dart';
import 'package:grok/core/config/environment_config.dart';
import 'package:grok/core/navigation/navigation_service.dart';

import 'package:grok/core/config/routes.dart';

// REPOSITORIES
import 'package:grok/data/repositories/auth_repository.dart';
import 'package:grok/data/repositories/holerite_repository.dart';
import 'package:grok/data/repositories/ponto_repository.dart';

// BLOCS
import 'package:grok/presentation/blocs/theme/theme_bloc.dart';
import 'package:grok/presentation/blocs/theme/theme_state.dart';

import 'package:grok/presentation/blocs/auth/auth_bloc.dart';

import 'package:grok/presentation/blocs/holerite/holerite_bloc.dart';
import 'package:grok/presentation/blocs/holerite_detail/holerite_detail_bloc.dart';
import 'package:grok/presentation/blocs/holerite_detail_pdf/holerite_detail_pdf_bloc.dart';

import 'package:grok/presentation/blocs/ponto/ponto_bloc.dart';
import 'package:grok/presentation/blocs/ponto_detail/ponto_detail_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvironmentConfig.init('production');
  await setupDependencies();
  await initializeDateFormatting('pt_BR', null);
  runApp(Grok());
}

class Grok extends StatelessWidget {
  final NavigationService navigationService = NavigationService();

  Grok({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        
        BlocProvider(create: (context) => AuthBloc(getIt<AuthRepository>())),

        BlocProvider(create: (context) => HoleriteBloc(getIt<HoleriteRepository>())),
        BlocProvider(create: (context) => HoleriteDetailBloc(getIt<HoleriteRepository>())),
        BlocProvider(create: (context) => HoleriteDetailPdfBloc(getIt<HoleriteRepository>())),

        BlocProvider(create: (context) => PontoBloc(getIt<PontoRepository>())),
        BlocProvider(create: (context) => PontoDetailBloc(getIt<PontoRepository>())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark ? true : false;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: isDark ? Color(0xff212121) : Colors.white,
              systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
            ),
          );
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigationService.navigatorKey,
            theme: themeState.lightTheme,
            darkTheme: themeState.darkTheme,
            themeMode: themeState.themeMode,
            locale: Locale('pt', 'BR'),
            supportedLocales: [
              Locale('pt', 'BR'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: '/login',
            routes: Routes.get()
          );
        },
      ),
    );
  }
}
