import 'package:flutter/material.dart';

class DangerButton extends StatelessWidget {
  final String text;
  final Widget child;
  final VoidCallback onPressed;

  const DangerButton({
    this.text,
    this.child,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: RaisedButton(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
        color: Theme.of(context).errorColor,
        child: child == null ?
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        ) :
        child,
        onPressed: onPressed
      ),
    );
  }

}