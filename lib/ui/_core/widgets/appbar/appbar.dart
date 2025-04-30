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
      child: StatusIndicator(),
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
