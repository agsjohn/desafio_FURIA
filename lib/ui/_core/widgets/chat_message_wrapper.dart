import 'package:flutter/material.dart';

class ChatMessageWrapper extends StatefulWidget {
  final Widget child;
  final bool scrollIfLastUser;

  const ChatMessageWrapper({
    super.key,
    required this.child,
    this.scrollIfLastUser = false,
  });

  @override
  ChatMessageWrapperState createState() => ChatMessageWrapperState();
}

class ChatMessageWrapperState extends State<ChatMessageWrapper> {
  bool hasScrolled = false;

  @override
  void initState() {
    super.initState();
    maybeScroll();
  }

  void maybeScroll() {
    if (widget.scrollIfLastUser && !hasScrolled) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        hasScrolled = true;

        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
