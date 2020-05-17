import 'package:flutter/material.dart';

class LightButton extends StatelessWidget {
  final Alignment alignment;
  final String text;
  final VoidCallback onPressed;

  const LightButton({
    this.alignment,
    this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: FlatButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: onPressed
      ),
    );
  }

}