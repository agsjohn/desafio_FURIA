import 'package:flutter/material.dart';
import 'package:my_app/ui/_core/widgets/appbar/status_indicator.dart';

AppBar getAppBar({required BuildContext context, String? title}) {
  return AppBar(
    title: title != null ? Text(title) : null,
    centerTitle: true,
    surfaceTintColor: Colors.black,
    shadowColor: Colors.white,
    automaticallyImplyLeading: false,
    toolbarHeight: 84,
    leadingWidth: 200,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
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
              StatusIndicator(),
            ],
          ),
        ],
      ),
    ),
    actions: [
      Container(
        padding: EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, size: 24),
        ),
      ),
    ],
  );
}
