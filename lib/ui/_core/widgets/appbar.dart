import 'package:flutter/material.dart';

AppBar getAppBar({required BuildContext context, String? title}) {
  double largura = MediaQuery.of(context).size.width;

  return AppBar(
    title: title != null ? Text(title) : null,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(100),
            ),
            width: largura * 0.16,
            height: largura * 0.16,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: largura * 0.045,
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 75, 255, 3),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    width: largura * 0.03,
                    height: largura * 0.03,
                  ),
                  Text("Online now"),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    toolbarHeight: largura * 0.2,
    leadingWidth: largura * 0.8,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.close),
      ),
    ],
  );
}
