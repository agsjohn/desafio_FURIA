import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/data/furia_data.dart';
import 'package:my_app/ui/_core/app_theme.dart';
import 'package:my_app/ui/_core/widgets/appbar/status_provider.dart';
import 'package:my_app/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  FuriaData furiaData = FuriaData();
  await furiaData.getData();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => furiaData),
        ChangeNotifierProvider(create: (context) => StatusProvider()),
      ],
      child: FuriaChatApp(),
    ),
  );
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
