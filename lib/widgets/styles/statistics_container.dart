import 'package:flutter/material.dart';

class StatisticsContainer extends StatelessWidget {
  final dynamic _data;
  final String _info;
  final int _type;
  final int _year;

  StatisticsContainer(this._data, this._info, this._type, this._year);

  Color getColor(dynamic _year) {
    switch (_year) {
      case 1:
        return Color(0xFF4F5973);
      case 2:
        return Color(0xFFB3A5EF);
      case 3:
        return Color(0xFF62DDBD);
      case 4:
        return Color(0xFFFFC305);
      case 5:
        return Color(0xFF96CBFF);
      case 10:
        return _data.getColor();
      default:
        return Colors.black;
    }
  }

  //TODO: Tiene que devolver el color correspondiente de la materia

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: Container(
        width: 151.0,
        height: 151.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: (_year == 0) ? const Color(0xfff7f7f7) : getColor(_year),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _type == 0
                ? Text(
                    _data,
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 50,
                      color: _year != 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  )
                : SizedBox(
                    height: 50,
                    width: 120,
                    child: Center(
                      child: Text(
                        _data.getName(),
                        style: TextStyle(
                          fontFamily: 'Avenir LT Std',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            (_type == 1)
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 0,
                  ),
            (_type == 1)
                ? SizedBox(
                    width: 106.0,
                    child: Text(
                      _info,
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SizedBox(
                    width: 106.0,
                    child: Text(
                      _info,
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 18,
                        color: _year != 0 ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
