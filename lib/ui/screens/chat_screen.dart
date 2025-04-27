import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/data/respostas.dart';
import 'package:my_app/ui/_core/app_colors.dart';
import 'package:my_app/ui/_core/widgets/appbar.dart';
import 'package:my_app/ui/_core/widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(context: context),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: TextFormField(),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.all(8.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messages[index];
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: largura * 0.15),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildOptionButton('Últimos jogos'),
                    buildOptionButton('Próximos jogos'),
                    buildOptionButton('Info do time'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void userClick(String option) {
    setState(() {
      messages.add(ChatMessage(text: option, isUser: true));
      messages.add(
        ChatMessage(
          text: respostas[option] ?? 'Desculpe, não entendi.',
          isUser: false,
        ),
      );
    });
    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget buildOptionButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mainColor,
          side: BorderSide(width: 1.0, color: AppColors.mainColor),
        ),
        onPressed: () => userClick(text),
        child: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
