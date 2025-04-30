import 'package:flutter/material.dart';
import 'package:my_app/data/furia_data.dart';
import 'package:my_app/data/palavras_negrito.dart';
import 'package:my_app/data/respostas.dart';
import 'package:my_app/ui/_core/app_colors.dart';
import 'package:my_app/ui/_core/app_themes/app_theme_manager.dart';
import 'package:my_app/ui/_core/app_themes/app_theme1.dart';
import 'package:my_app/ui/_core/widgets/appbar/appbar.dart';
import 'package:my_app/ui/_core/widgets/appbar/status_provider.dart';
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
  final ScrollController horizontalScrollController = ScrollController();
  late FuriaData furiaData;
  late StatusProvider statusProvider;
  late AppThemeManager appThemeManager;
  var scrollController = ScrollController();
  var textFieldController = TextEditingController();
  bool showLeftShadow = false;
  bool showRightShadow = false;
  bool faq = false;
  bool quiz = false;
  bool buttons = false;

  void statusListener() {
    if (statusProvider.isOnline) {
      setState(() {
        buttons = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    appThemeManager = Provider.of<AppThemeManager>(context);
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
                style: AppTheme1.iconButtonStyle,
                onPressed:
                    buttons == true
                        ? () {
                          String texto = textFieldController.text;
                          textFieldController.clear();
                          userClick(texto);
                        }
                        : null,
                child: Icon(
                  Icons.send_rounded,
                  color:
                      buttons == true
                          ? appThemeManager.mainColor
                          : AppColors.lightBlack,
                  size: 24,
                ),
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
    if (option.isEmpty) return;

    setState(() {
      addUserMessage(option);
      animateHorizontalScroll();

      Widget responseWidget = getDefaultResponse();

      if (faq == false && quiz == false) {
        responseWidget = handleReponses(option);
      } else if (faq == true) {
        responseWidget = handleFaq(option);
      }

      messages.add(ChatMessage(isUser: false, child: responseWidget));
    });

    animateVerticalScroll();
  }

  void addUserMessage(String option) {
    messages.add(
      ChatMessage(
        isUser: true,
        child: Text(option, style: TextStyle(color: Colors.black)),
      ),
    );
  }

  void animateHorizontalScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      horizontalScrollController.animateTo(
        horizontalScrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    });
  }

  Widget getDefaultResponse() {
    return Text(
      'Desculpe, não entendi.',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget handleReponses(String option) {
    for (int i = 0; i < respostas.length; i++) {
      if (respostas.keys.elementAt(i).toLowerCase() == option.toLowerCase()) {
        return buildResponseForOption(i);
      }
    }
    return getDefaultResponse();
  }

  Widget buildResponseForOption(int index) {
    switch (index) {
      case 0:
        String jogadoresTexto = furiaData.toStringListJogadores();
        return Text.rich(
          TextSpan(children: buildTextSpans(jogadoresTexto, palavrasNegrito)),
        );
      case 1:
        var palavras = PalavrasNegrito(
          maisPalavras: furiaData.getUltimosJogosTimes(),
        );
        palavras.addPalavras(furiaData.getUltimosJogoEventos());
        String ultimosJogos = furiaData.toStringUltimosJogos();
        return Text.rich(
          TextSpan(
            children: buildTextSpans(ultimosJogos, palavras.maisPalavras),
          ),
        );
      case 2:
        var palavras = PalavrasNegrito(
          maisPalavras: furiaData.getResultadosEquipeEventos(),
        );
        String resultadosEquipe = furiaData.toStringResultadosEquipe();
        return Text.rich(
          TextSpan(
            children: buildTextSpans(resultadosEquipe, palavras.maisPalavras),
          ),
        );
      case 3:
        String faqInicial = furiaData.toStringFaqInicial();
        faq = true;
        return Text.rich(
          TextSpan(children: buildTextSpans(faqInicial, numerosNegrito)),
        );
      default:
        return getDefaultResponse();
    }
  }

  Widget handleFaq(String option) {
    int? escolha = int.tryParse(option);
    if (escolha != null) {
      if (escolha == furiaData.listFaq[0].perguntas.length + 1) {
        faq = false;
        return Text.rich(
          TextSpan(
            children: buildTextSpans("Você saiu do FAQ. ", numerosNegrito),
          ),
        );
      } else {
        String faqInicial = "\n\n${furiaData.toStringFaqInicial()}";
        return Text.rich(
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
    return getDefaultResponse();
  }

  void animateVerticalScroll() {
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
        style:
            buttons == true
                ? ButtonStyle()
                : appThemeManager.outlineButtonStyle,
        onPressed: () => buttons == true ? userClick(text) : null,
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusProvider = Provider.of<StatusProvider>(context, listen: false);
      statusProvider.addListener(statusListener);
      updateShadowVisibility();
    });

    horizontalScrollController.addListener(updateShadowVisibility);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateShadowVisibility();
    });
  }

  @override
  void dispose() {
    statusProvider.removeListener(statusListener);
    scrollController.dispose();
    horizontalScrollController.dispose();
    super.dispose();
  }
}
