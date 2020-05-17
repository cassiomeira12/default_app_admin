import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Widget child;
  final VoidCallback onPressed;

  const SecondaryButton({
    this.text,
    this.child,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).hintColor),
        ),
        color: Theme.of(context).backgroundColor,
        child: child == null ?
          Text(
            text,
            style: Theme.of(context).textTheme.body2,
          ) :
          child,
        onPressed: onPressed,
      ),
    );
  }

}