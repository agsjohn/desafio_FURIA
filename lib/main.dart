import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/ui/_core/app_theme.dart';
import 'package:my_app/ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
