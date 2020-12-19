import 'dart:ui';

import 'package:flutter/material.dart';

class QuickButton extends StatelessWidget {
  final String text;
  final Color color;

  QuickButton(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Avenir LT Std',
            fontSize: 14,
            color: const Color(0xff7c7979),
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      width: 140.0,
      height: 35.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.0),
        color: color,
      ),
    );
  }
}
