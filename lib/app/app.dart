import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

/// Main application widget
class FinTrackApp extends StatelessWidget {
  FinTrackApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FinTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: _appRouter.config(),
    );
  }
}

