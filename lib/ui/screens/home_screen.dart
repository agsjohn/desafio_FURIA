import 'package:flutter/material.dart';
import 'package:furia_chat_bot/ui/_core/app_colors.dart';
import 'package:furia_chat_bot/ui/_core/app_themes/app_theme_manager.dart';
import 'package:furia_chat_bot/ui/_core/widgets/appbar/status_provider.dart';
import 'package:furia_chat_bot/ui/screens/chat_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    double fontSize = altura > largura ? largura * 0.05 : altura * 0.04;
    double buttonFontSize = altura > largura ? largura * 0.04 : altura * 0.035;
    double buttonSize = altura > largura ? largura * 0.9 : altura * 0.4;
    double imageSize = altura > largura ? largura * 0.6 : altura * 0.4;
    final status = Provider.of<StatusProvider>(context, listen: false);
    var appThemeManager = Provider.of<AppThemeManager>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              spacing: altura * 0.04,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo_furia_grande.png',
                  height: imageSize,
                  alignment: Alignment.bottomCenter,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Desperte seu poder. Abrace a ",
                      style: TextStyle(
                        color: AppColors.homeTextColor,
                        fontSize: fontSize,
                      ),
                    ),
                    Text(
                      "FURIA!",
                      style: TextStyle(
                        color: appThemeManager.appTheme.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: buttonSize,
                  height:
                      altura > largura ? buttonSize * 0.1 : buttonSize * 0.15,
                  child: ElevatedButton(
                    onPressed: () {
                      status.setOnline(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Bora!",
                      style: TextStyle(
                        fontSize: buttonFontSize,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
