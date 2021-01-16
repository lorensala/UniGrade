import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String _text;
  final String _icon;
  final Color _color;

  MainButton(this._text, this._icon, this._color);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Container(
            width: 149.0,
            height: 122.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
              color: _color,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(17, 55, 0, 0),
              child: Text(
                _text,
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 19,
                  color: const Color(0xff484848),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 40,
          child: Image.asset(
            _icon,
            width: 74.0,
            height: 74.0,
          ),
        )
      ],
    );
  }
}
