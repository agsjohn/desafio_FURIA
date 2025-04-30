import 'package:flutter/material.dart';
import 'package:my_app/ui/_core/app_themes/app_theme_manager.dart';
import 'package:my_app/ui/_core/widgets/appbar/status_indicator.dart';
import 'package:provider/provider.dart';

AppBar getAppBar({required BuildContext context, String? title}) {
  var appThemeManager = Provider.of<AppThemeManager>(context);

  return AppBar(
    title: title != null ? Text(title) : null,
    centerTitle: true,
    backgroundColor: appThemeManager.theme.scaffoldBackgroundColor,
    surfaceTintColor: Colors.black,
    shadowColor: appThemeManager.mainColor,
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
      IconButton(
        icon: Icon(Icons.color_lens, size: 24),
        onPressed: () {
          appThemeManager.toggleTheme();
        },
      ),
      Container(
        padding: EdgeInsets.only(right: 16),
        child: IconButton(
          icon: Icon(Icons.close, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ],
  );
}
