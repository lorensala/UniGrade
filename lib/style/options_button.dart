import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String name;

  OptionButton(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'Avenir LT Std',
            fontSize: 14,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      width: 101.0,
      height: 35.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.0),
        color: const Color(0xff66aaff),
      ),
    );
  }
}
