import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/app_theme.dart';
import 'core/router/app_router.dart';

// ── Configuration ─────────────────────────────────────────────────────────────
// Store these in environment variables or a secrets manager before shipping.
// Never commit real keys to version control.
const String _supabaseUrl = 'https://ijgrjsvfurhbgchbkcui.supabase.co';
const String _supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlqZ3Jqc3ZmdXJoYmdjaGJrY3VpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxODExNjEsImV4cCI6MjA4ODc1NzE2MX0.Rg5Xjal__VwmN3QNcR_aWIwloauJpiP37g8YFtnXfvQ';
const String mapboxAccessToken = 'YOUR_MAPBOX_ACCESS_TOKEN';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Transparent status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Mapbox token must be set before any MapWidget is rendered
  MapboxOptions.setAccessToken(mapboxAccessToken);

  // Supabase — safe to initialize even with placeholder URL in dev
  await Supabase.initialize(
    url: _supabaseUrl,
    anonKey: _supabaseAnonKey,
  );

  runApp(
    const ProviderScope(
      child: AlaskaAtlasApp(),
    ),
  );
}

class AlaskaAtlasApp extends ConsumerWidget {
  const AlaskaAtlasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Alaska Atlas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
