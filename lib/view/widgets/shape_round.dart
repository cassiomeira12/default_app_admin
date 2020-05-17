import 'package:flutter/material.dart';

class ShapeRound extends StatelessWidget {
  final Widget children;

  const ShapeRound(@required this.children);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(
          width: 1,
          color: Theme.of(context).hintColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        )
      ),
      child: children,
    );
  }

}