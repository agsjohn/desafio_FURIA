import 'package:flutter/material.dart';
import 'package:furia_chat_bot/ui/_core/app_themes/app_theme_manager.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final Widget child;
  final bool isUser;

  const ChatMessage({super.key, required this.child, required this.isUser});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    var appThemeManager = Provider.of<AppThemeManager>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            constraints: BoxConstraints(maxWidth: largura * 0.7),
            decoration: BoxDecoration(
              color:
                  isUser
                      ? appThemeManager.mainColor
                      : const Color.fromRGBO(77, 77, 77, 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

extension DiacriticsAwareString on String {
  static const diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËĚèéêëěðČÇçčÐĎďÌÍÎÏìíîïĽľÙÚÛÜŮùúûüůŇÑñňŘřŠšŤťŸÝÿýŽž';
  static const nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEEeeeeeeCCccDDdIIIIiiiiLlUUUUUuuuuuNNnnRrSsTtYYyyZz';

  String get withoutDiacriticalMarks => splitMapJoin(
    '',
    onNonMatch:
        (char) =>
            char.isNotEmpty && diacritics.contains(char)
                ? nonDiacritics[diacritics.indexOf(char)]
                : char,
  );
}
