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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: InkWell(
              borderRadius: BorderRadius.circular(26),
              onTap: () {
                Navigator.pushNamed(context, _route);
              },
              child: Container(
                width: 129.0,
                height: 92.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: _color,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(17, 40, 0, 0),
                  child: Text(
                    _text,
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 18,
                      color: const Color(0xff484848),
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 63,
          child: Image.asset(
            _icon,
            width: 54.0,
            height: 54.0,
          ),
        )
      ],
    );
  }
}
