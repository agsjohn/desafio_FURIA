import 'package:flutter/material.dart';

class StatusIndicator extends StatefulWidget {
  const StatusIndicator({super.key});

  @override
  State<StatusIndicator> createState() => _StatusIndicatorState();
}

class _StatusIndicatorState extends State<StatusIndicator> {
  bool isOnline = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isOnline = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          width: 58,
          height: 58,
          margin: EdgeInsets.only(right: 8),
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/logo_furia.png"),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Furia bot",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color:
                        isOnline
                            ? Color.fromARGB(255, 75, 255, 3)
                            : Colors.grey,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: 12,
                  height: 12,
                ),
                Text(isOnline ? "Online" : "Offline"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
