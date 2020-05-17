import 'package:flutter/material.dart';

class ScaffoldSnackBar {

  static success(BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey, String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
    ));
  }

  static failure(BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey, String error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        error,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

}


