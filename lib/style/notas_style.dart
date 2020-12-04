import 'package:flutter/material.dart';

class NotaCard extends StatelessWidget {
  //final String name;
  //final int notasP;
  //final int notasT;
  //final int notasTP;
  //final int notasF;

  //NotaCard(this.name, this.notasP, this.notasT, this.notasTP, this.notasF);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        //width: 327.0,
        height: 57.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: const Color(0xfff7f7f7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Análisis\nMatemático I',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 13,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.3076923076923077,
              ),
              textAlign: TextAlign.left,
            ),
            Image.asset(
              'assets/images/3.0x/divgrey.png',
              scale: 3,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Image.asset(
              'assets/images/3.0x/divgrey.png',
              scale: 3,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Image.asset(
              'assets/images/3.0x/divgrey.png',
              scale: 3,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
            Image.asset(
              'assets/images/3.0x/divgrey.png',
              scale: 3,
            ),
            Text(
              '8',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 15,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w300,
                height: 1.7333333333333334,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
