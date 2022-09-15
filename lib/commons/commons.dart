import 'package:flutter/cupertino.dart';

void navigation(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => widget),
  );
}

void pushNavigation(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    CupertinoPageRoute(builder: (context) => widget),
  );
}
