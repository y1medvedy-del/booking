import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:booking/features/splash/presentation/splash_screen.dart';

class GlobalStayApp extends StatelessWidget {
  const GlobalStayApp({super.key});

  static const Color _brandColor = Color(0xFFF88A2A);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlobalStay',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      theme: ThemeData(
        primaryColor: _brandColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brandColor,
          primary: _brandColor,
        ),
        scaffoldBackgroundColor: Colors.white,
        splashColor: _brandColor.withValues(alpha: 0.12),
        highlightColor: _brandColor.withValues(alpha: 0.08),
        focusColor: _brandColor.withValues(alpha: 0.12),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: _brandColor,
          selectionColor: _brandColor.withValues(alpha: 0.24),
          selectionHandleColor: _brandColor,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: _brandColor,
        ),
        // Material 3 на Android включает stretch-эффект у списков.
        // Пока используем Material 2, чтобы скролл вел себя привычнее.
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
