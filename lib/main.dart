import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/ui/_core/app_theme.dart';
//import 'package:my_app/ui/screens/chat_screen.dart';
import 'package:my_app/ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(FuriaChatApp());
}

class FuriaChatApp extends StatelessWidget {
  const FuriaChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FURIA Chatbot',
      theme: AppTheme.appTheme,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
