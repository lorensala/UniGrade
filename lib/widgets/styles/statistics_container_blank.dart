import 'package:flutter/material.dart';

class StatisticsContainerBlank extends StatelessWidget {
  final String info;

  StatisticsContainerBlank(this.info);

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
              'No hay datos',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 106.0,
              child: Text(
                info,
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 18,
                  color: Colors.black,
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
