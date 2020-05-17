import 'package:flutter/material.dart';

class BackgroundCard extends StatelessWidget {
  final double height;

  const BackgroundCard({
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height == null ? 300 : height,
      color: Theme.of(context).primaryColor,
    );
  }
}