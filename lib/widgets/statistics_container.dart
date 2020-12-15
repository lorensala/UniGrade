import 'package:flutter/material.dart';

class StatisticsContainer extends StatelessWidget {
  final String _data;
  final String _info;

  StatisticsContainer(this._data, this._info);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: Container(
        width: 151.0,
        height: 151.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: const Color(0xfff7f7f7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _data,
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 50,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              width: 106.0,
              child: Text(
                _info,
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 18,
                  color: const Color(0xff000000),
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
