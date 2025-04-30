import 'package:flutter/material.dart';
import 'package:my_app/data/furia_data.dart';
import 'package:my_app/data/palavras_negrito.dart';
import 'package:my_app/data/respostas.dart';
import 'package:my_app/ui/_core/app_colors.dart';
import 'package:my_app/ui/_core/widgets/appbar/appbar.dart';
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
  final ScrollController horizontalScrollController = ScrollController();
  bool showLeftShadow = false;
  bool showRightShadow = false;
  var textFieldController = TextEditingController();
  late FuriaData furiaData;
  bool faq = false;
  bool quiz = false;

  @override
  Widget build(BuildContext context) {
    furiaData = Provider.of<FuriaData>(context);

    return Scaffold(
      appBar: getAppBar(context: context),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 24, right: 23, left: 22),
        child: TextField(
          controller: textFieldController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 24),
            hintText: "Digite sua mensagem",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            suffixIcon: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(0, 255, 255, 255),
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: AppColors.mainColor,
                  size: 24,
                ),
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
            SizedBox(
              height: 65,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      controller: horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 12,
                        children:
                            (faq == false
                                    ? [
                                      'Jogadores',
                                      'Últimos jogos',
                                      'Resultados da equipe',
                                      'Faq',
                                    ]
                                    : List<String>.generate(
                                      8,
                                      (i) => '${i + 1}',
                                    ))
                                .map(
                                  (text) =>
                                      Container(child: buildOptionButton(text)),
                                )
                                .toList(),
                      ),
                    ),
                  ),

                  if (showLeftShadow)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Theme.of(context).scaffoldBackgroundColor,
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withAlpha(0),
                            ],
                          ),
                        ),
                      ),
                    ),

                  if (showRightShadow)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Theme.of(context).scaffoldBackgroundColor,
                              Theme.of(
                                context,
                              ).scaffoldBackgroundColor.withAlpha(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void userClick(String option) {
    if (option == "") {
      return;
    }
    setState(() {
      messages.add(
        ChatMessage(
          isUser: true,
          child: Text(
            option,
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        horizontalScrollController.animateTo(
          horizontalScrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      });

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
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

  void updateShadowVisibility() {
    final maxScroll = horizontalScrollController.position.maxScrollExtent;
    final offset = horizontalScrollController.offset;

    setState(() {
      showLeftShadow = offset > 0;
      showRightShadow = offset < maxScroll;
    });
  }

  @override
  void initState() {
    super.initState();

    horizontalScrollController.addListener(updateShadowVisibility);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateShadowVisibility();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    horizontalScrollController.dispose();
    super.dispose();
  }
}
