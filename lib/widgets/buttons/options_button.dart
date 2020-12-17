import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  final String _name;
  final bool _isPressed;

  OptionButton(this._name, this._isPressed);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  final List<Color> colors = [Colors.white, Color(0xff66aaff)];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        child: Center(
          child: Text(
            widget._name,
            style: TextStyle(
              fontFamily: 'Avenir LT Std',
              fontSize: 14,
              color: widget._isPressed ? colors[0] : colors[1],
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        width: 101.0,
        height: 35.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: widget._isPressed ? colors[1] : colors[0],
          border: Border.all(width: 1.0, color: const Color(0xff66aaff)),
        ),
      ),
    );
  }
}
