import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class PageRouter {

  static pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static push(BuildContext context, Widget route) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) {
          return route;
        }
      ),
    );
  }

}