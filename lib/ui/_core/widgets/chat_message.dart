import 'package:flutter/material.dart';
import 'package:my_app/ui/_core/app_colors.dart';

class ChatMessage extends StatelessWidget {
  final Widget child;
  final bool isUser;

  const ChatMessage({super.key, required this.child, required this.isUser});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;

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
              color: isUser ? AppColors.mainColor : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
