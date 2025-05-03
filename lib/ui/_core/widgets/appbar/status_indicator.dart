import 'package:flutter/material.dart';
import 'package:furia_chat_bot/ui/_core/widgets/appbar/status_provider.dart';
import 'package:provider/provider.dart';

class StatusIndicator extends StatefulWidget {
  const StatusIndicator({super.key});

  @override
  State<StatusIndicator> createState() => _StatusIndicatorState();
}

class _StatusIndicatorState extends State<StatusIndicator> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final status = Provider.of<StatusProvider>(context, listen: false);
      Future.delayed(Duration(seconds: 1), () {
        status.setOnline(true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = Provider.of<StatusProvider>(context).isOnline;

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: isOnline ? Color.fromARGB(255, 75, 255, 3) : Colors.grey,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          width: 12,
          height: 12,
        ),
        Text(isOnline ? "Online" : "Offline"),
      ],
    );
  }
}
