import 'package:flutter/material.dart';
import 'package:my_app/data/furia_data.dart';
import 'package:my_app/data/palavras_negrito.dart';
import 'package:my_app/data/respostas.dart';
import 'package:my_app/ui/_core/app_colors.dart';
import 'package:my_app/ui/_core/widgets/appbar.dart';
import 'package:my_app/ui/_core/widgets/chat_message.dart';
import 'package:my_app/ui/_core/widgets/build_text_response.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [];
  ScrollController scrollController = ScrollController();
  late FuriaData furiaData;

  @override
  Widget build(BuildContext context) {
    //double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    furiaData = Provider.of<FuriaData>(context);

    return Scaffold(
      appBar: getAppBar(context: context),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(),
      ),
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
              margin: EdgeInsets.only(bottom: altura * 0.08),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildOptionButton('Jogadores'),
                    buildOptionButton('Últimos jogos'),
                    buildOptionButton('Resultados da equipe'),
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
      messages.add(
        ChatMessage(
          isUser: true,
          child: Text(option, style: TextStyle(color: Colors.white)),
        ),
      );

      Widget responseWidget;
      if (respostas[option] == 0) {
        String jogadoresTexto = furiaData.toStringListJogadores();
        responseWidget = Text.rich(
          TextSpan(children: buildTextSpans(jogadoresTexto, palavrasNegrito)),
        );
      } else if (respostas[option] == 1) {
        var palavras = PalavrasNegrito(
          maisPalavras: furiaData.getUltimosJogosTimes(),
        );
        palavras.addPalavras(furiaData.getUltimosJogoEventos());
        String ultimosJogos = furiaData.toStringUltimosJogos();
        responseWidget = Text.rich(
          TextSpan(
            children: buildTextSpans(ultimosJogos, palavras.maisPalavras),
          ),
        );
      } else if (respostas[option] == 2) {
        var palavras = PalavrasNegrito(
          maisPalavras: furiaData.getResultadosEquipeEventos(),
        );
        String resultadosEquipe = furiaData.toStringResultadosEquipe();
        responseWidget = Text.rich(
          TextSpan(
            children: buildTextSpans(resultadosEquipe, palavras.maisPalavras),
          ),
        );
      } else {
        responseWidget = Text(
          'Desculpe, não entendi.',
          style: TextStyle(color: Colors.black),
        );
      }

      messages.add(ChatMessage(isUser: false, child: responseWidget));
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
