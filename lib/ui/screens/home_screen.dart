import 'package:flutter/material.dart';
import 'package:my_app/ui/_core/app_colors.dart';
import 'package:my_app/ui/screens/chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    double fontSize = altura > largura ? largura * 0.05 : altura * 0.04;
    double buttonFontSize = altura > largura ? largura * 0.04 : altura * 0.035;
    double buttonSize = altura > largura ? double.infinity : altura * 0.4;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: altura * 0.025),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      fontSize =
                          altura > largura ? largura * 0.04 : altura * 0.1;
                      double imageSize =
                          altura > largura ? altura * 0.4 : largura * 0.3;
                      return Image.asset(
                        'assets/logo_furia1.png',
                        height: imageSize,
                      );
                    },
                  ),
                  Column(
                    spacing: altura * 0.04,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Desperte seu poder. Abrace a ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                            ),
                          ),
                          Text(
                            "FURIA!",
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: buttonSize,
                        child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
