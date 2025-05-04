import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:furia_chat_bot/data/furia_data.dart';
import 'package:furia_chat_bot/data/palavras_negrito.dart';
import 'package:furia_chat_bot/data/respostas.dart';
import 'package:furia_chat_bot/ui/_core/app_colors.dart';
import 'package:furia_chat_bot/ui/_core/app_themes/app_theme_manager.dart';
import 'package:furia_chat_bot/ui/_core/widgets/appbar/appbar.dart';
import 'package:furia_chat_bot/ui/_core/widgets/appbar/status_provider.dart';
import 'package:furia_chat_bot/ui/_core/widgets/chat_message.dart';
import 'package:furia_chat_bot/ui/_core/widgets/build_text_response.dart';
import 'package:furia_chat_bot/ui/_core/widgets/chat_message_wrapper.dart';
import 'package:furia_chat_bot/ui/_core/widgets/quiz_validator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  List<ChatMessage> messages = [];
  final horizontalScrollController = ScrollController();
  final scrollController = ScrollController();
  final textFieldController = TextEditingController();
  final TapGestureRecognizer tapRecognizer = TapGestureRecognizer();
  late FuriaData furiaData;
  late StatusProvider statusProvider;
  late AppThemeManager appThemeManager;

  GlobalKey userMessageKey = GlobalKey();

  bool showLeftShadow = false;
  bool showRightShadow = false;
  bool faq = false;
  bool quiz = false;
  bool buttons = false;
  int perguntaQuiz = 0;
  Future? currentOperation;
  bool isCancelled = false;
  double? lastBotMessageHeight;
  bool isAtBottom = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        isAtBottom =
            scrollController.position.pixels ==
            scrollController.position.maxScrollExtent;
      } else {
        isAtBottom = false;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusProvider = Provider.of<StatusProvider>(context, listen: false);
      statusProvider.addListener(statusListener);
      horizontalScrollController.addListener(updateShadowVisibility);
      updateShadowVisibility();
    });
  }

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
      resizeToAvoidBottomInset: true,
      appBar: getAppBar(context: context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    bool isLastUserMessage =
                        msg.isUser &&
                        index == messages.lastIndexWhere((m) => m.isUser);
                    final isLastIndex = index == messages.length - 1;
                    return ChatMessageWrapper(
                      key: isLastIndex ? userMessageKey : null,
                      scrollIfLastUser: isLastUserMessage,
                      child: msg,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 60,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        controller: horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 12,
                          children:
                              (faq == false && quiz == false
                                      ? [
                                        'Jogadores',
                                        'Últimos jogos',
                                        'Resultados da equipe',
                                        'Faq',
                                        'Quiz',
                                      ]
                                      : faq == true
                                      ? List<String>.generate(
                                        8,
                                        (i) => '${i + 1}',
                                      )
                                      : ['a', 'b', 'c', 'd', 'S'])
                                  .map(
                                    (text) => Container(
                                      child: buildOptionButton(text),
                                    ),
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
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 24),
                    hintText: "Digite sua mensagem",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        style: appThemeManager.iconButtonStyle,
                        onPressed:
                            buttons == true
                                ? () {
                                  String texto = textFieldController.text;
                                  textFieldController.clear();
                                  userClick(texto);
                                }
                                : null,
                        icon: Icon(
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
            ],
          ),
        ),
      ),
    );
  }

  void userClick(String option) async {
    isCancelled = true;
    await currentOperation;

    isCancelled = false;

    currentOperation = handleUserClick(option);
  }

  Future<void> handleUserClick(String option) async {
    if (option.isEmpty) return;

    addUserMessage(option);

    Widget responseWidget = getDefaultResponse();

    if (!faq && !quiz) {
      responseWidget = handleReponses(option);
    } else if (faq) {
      responseWidget = handleFaq(option);
    } else {
      if (perguntaQuiz + 2 == furiaData.listQuiz.length) {
        responseWidget = handleQuiz(option);
        addNoUserMessage(responseWidget);

        await Future.delayed(Duration(seconds: 5));
        if (isCancelled || !mounted) return;

        responseWidget = Text.rich(
          TextSpan(children: buildTextSpans("OPS", numerosNegrito)),
        );
        addNoUserMessage(responseWidget);
        animateVerticalScroll();

        await Future.delayed(Duration(milliseconds: 800));
        if (isCancelled || !mounted) return;

        responseWidget = Text.rich(
          TextSpan(
            children: buildTextSpans(
              "Quiz finalizado, o que gostaria de saber/perguntar?",
              numerosNegrito,
            ),
          ),
        );
      } else {
        responseWidget = handleQuiz(option);
      }
    }

    if (isCancelled || !mounted) return;

    addNoUserMessage(responseWidget);

    animateVerticalScroll();
    animateHorizontalScroll();
  }

  void addNoUserMessage(Widget responseWidget) {
    setState(() {
      messages.add(ChatMessage(isUser: false, child: responseWidget));
    });
  }

  void addUserMessage(String option) {
    setState(() {
      messages.add(
        ChatMessage(
          isUser: true,
          child: Text(option, style: TextStyle(color: Colors.black)),
        ),
      );
    });
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
      'Desculpe, não entendi. Por favor, utilize os botões de mensagem ou digite de acordo com os botões.',
    );
  }

  Widget handleReponses(String option) {
    for (int i = 0; i < respostas.length; i++) {
      if (respostas.keys.elementAt(i).toLowerCase().withoutDiacriticalMarks ==
          option.toLowerCase().withoutDiacriticalMarks) {
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
        var palavras = PalavrasNegrito(maisPalavras: placarNegrito);
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
      case 4:
        String quizInicial = furiaData.listQuiz[perguntaQuiz].getPergunta();
        quiz = true;
        return Text.rich(
          TextSpan(children: buildTextSpans(quizInicial, numerosNegrito)),
        );
      default:
        return getDefaultResponse();
    }
  }

  Widget handleFaq(String option) {
    int? escolha = int.tryParse(option);
    String faqInicial = "\n\n${furiaData.toStringFaqInicial()}";
    if (escolha != null) {
      if (escolha == furiaData.listFaq[0].perguntas.length + 1) {
        faq = false;
        return Text.rich(
          TextSpan(
            children: buildTextSpans("Você saiu do FAQ. ", numerosNegrito),
          ),
        );
      } else if (escolha == 1) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: furiaData.listFaq.elementAt(0).respostas[escolha - 1],
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  color: Colors.blue,
                ),
                recognizer:
                    tapRecognizer
                      ..onTap = () {
                        launchUrl(
                          Uri.parse(
                            furiaData.listFaq.elementAt(0).respostas[escolha -
                                1],
                          ),
                        );
                      },
              ),
              TextSpan(children: buildTextSpans(faqInicial, numerosNegrito)),
            ],
          ),
        );
      } else {
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

  Widget handleQuiz(String option) {
    bool repostaCerta = quizValidator(
      option,
      furiaData.listQuiz[perguntaQuiz].resposta ?? '',
    );
    if (option.toLowerCase() == "s" || option.toLowerCase() == "sair") {
      perguntaQuiz = 0;
      quiz = false;
      return Text.rich(
        TextSpan(
          children: buildTextSpans("Você saiu do Quiz. ", numerosNegrito),
        ),
      );
    } else {
      perguntaQuiz++;
      String mensagem;
      if (perguntaQuiz + 1 == furiaData.listQuiz.length) {
        mensagem =
            "Parabéns, resposta certa, vamos para a última pergunta: \n\n${furiaData.listQuiz[perguntaQuiz].pergunta}";
        Text.rich(TextSpan(children: buildTextSpans(mensagem, numerosNegrito)));
        perguntaQuiz = 0;
        quiz = false;
      } else {
        if (repostaCerta == false) {
          mensagem =
              "Puts, parece que você errou, a resposta certa era a letra: "
              "${furiaData.listQuiz[perguntaQuiz - 1].resposta?.toUpperCase()}\nPróxima pergunta\n\n${furiaData.listQuiz[perguntaQuiz].getPergunta()}";
        } else {
          mensagem =
              "Parabéns, resposta certa, vamos para a próxima pergunta: \n\n${furiaData.listQuiz[perguntaQuiz].getPergunta()}";
        }
      }
      return Text.rich(
        TextSpan(children: buildTextSpans(mensagem, numerosNegrito)),
      );
    }
  }

  void animateVerticalScroll() {
    if (messages.length > 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
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
  void didChangeMetrics() {
    final wasAtBottom = isAtBottom;
    if (wasAtBottom) {
      if (userMessageKey.currentContext != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    tapRecognizer.dispose();
    statusProvider.removeListener(statusListener);
    scrollController.dispose();
    horizontalScrollController.dispose();
    textFieldController.dispose();
    super.dispose();
  }
}
