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
  var scrollController = ScrollController();
  var textFieldController = TextEditingController();
  late FuriaData furiaData;
  bool faq = false;
  bool quiz = false;

  @override
  Widget build(BuildContext context) {
    //double largura = MediaQuery.of(context).size.width;
    // double altura = MediaQuery.of(context).size.height;

    furiaData = Provider.of<FuriaData>(context);

    return Scaffold(
      appBar: getAppBar(context: context),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: textFieldController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Type a message",
            border: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            suffixIcon: Container(
              margin: EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(0, 255, 255, 255),
                ),
                child: Icon(Icons.send_rounded, color: AppColors.mainColor),
                onPressed: () {
                  String texto = textFieldController.text;
                  textFieldController.clear();
                  userClick(texto);
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messages[index];
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      faq == false
                          ? [
                            buildOptionButton('Jogadores'),
                            buildOptionButton('Últimos jogos'),
                            buildOptionButton('Resultados da equipe'),
                            buildOptionButton('Faq'),
                          ]
                          : [
                            buildOptionButton('1'),
                            buildOptionButton('2'),
                            buildOptionButton('3'),
                            buildOptionButton('4'),
                            buildOptionButton('5'),
                            buildOptionButton('6'),
                            buildOptionButton('7'),
                            buildOptionButton('8'),
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

      Widget responseWidget = Text(
        'Desculpe, não entendi.',
        style: TextStyle(color: Colors.black),
      );
      if (faq == false && quiz == false) {
        if (respostas.keys.elementAt(0).toLowerCase() == option.toLowerCase()) {
          String jogadoresTexto = furiaData.toStringListJogadores();
          responseWidget = Text.rich(
            TextSpan(children: buildTextSpans(jogadoresTexto, palavrasNegrito)),
          );
        } else if (respostas.keys.elementAt(1).toLowerCase() ==
            option.toLowerCase()) {
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
        } else if (respostas.keys.elementAt(2).toLowerCase() ==
            option.toLowerCase()) {
          var palavras = PalavrasNegrito(
            maisPalavras: furiaData.getResultadosEquipeEventos(),
          );
          String resultadosEquipe = furiaData.toStringResultadosEquipe();
          responseWidget = Text.rich(
            TextSpan(
              children: buildTextSpans(resultadosEquipe, palavras.maisPalavras),
            ),
          );
        } else if (respostas.keys.elementAt(3).toLowerCase() ==
            option.toLowerCase()) {
          String faqInicial = furiaData.toStringFaqInicial();
          faq = true;
          responseWidget = Text.rich(
            TextSpan(children: buildTextSpans(faqInicial, numerosNegrito)),
          );
        }
      } else if (faq == true) {
        int? escolha = int.tryParse(option);
        print(escolha);
        if (escolha != null) {
          if (escolha == furiaData.listFaq[0].perguntas.length + 1) {
            String faqSair = "Você saiu do FAQ. ";
            faq = false;
            responseWidget = Text.rich(
              TextSpan(children: buildTextSpans(faqSair, numerosNegrito)),
            );
          } else {
            String faqInicial = "\n\n${furiaData.toStringFaqInicial()}";
            responseWidget = Text.rich(
              TextSpan(
                children: buildTextSpans(
                  furiaData.listFaq.elementAt(0).respostas[escolha - 1] +
                      faqInicial,
                  numerosNegrito,
                ),
              ),
            );
          }
        }
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
