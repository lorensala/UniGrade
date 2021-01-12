import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String _text;
  final String _icon;
  final Color _color;
  final String _route;

  MainButton(this._text, this._icon, this._color, this._route);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Container(
            width: 159.0,
            height: 142.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
              color: _color,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(17, 70, 0, 0),
              child: Text(
                _text,
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 22,
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
          left: 63,
          child: Image.asset(
            _icon,
            width: 84.0,
            height: 84.0,
          ),
        )
      ],
    );
  }
}
