import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  final String _name;
  final bool _isDefault;

  OptionButton(this._name, this._isDefault);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  final List<Color> colors = [Colors.white, Color(0xff66aaff)];

  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    if (!this.widget._isDefault)
      return InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: () {
          setState(() {
            _pressed = !_pressed;
          });
        },
        child: Container(
          child: Center(
            child: Text(
              widget._name,
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 14,
                color: _pressed ? colors[0] : colors[1],
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          width: 101.0,
          height: 35.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: _pressed ? colors[1] : colors[0],
            border: Border.all(width: 1.0, color: const Color(0xff66aaff)),
          ),
        ),
      );
    else
      return InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: () {
          setState(() {
            _pressed = !_pressed;
          });
        },
        child: Container(
          child: Center(
            child: Text(
              widget._name,
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 14,
                color: _pressed ? colors[1] : colors[0],
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          width: 101.0,
          height: 35.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: _pressed ? colors[0] : colors[1],
            border: Border.all(width: 1.0, color: const Color(0xff66aaff)),
          ),
        ),
      );
  }
}
