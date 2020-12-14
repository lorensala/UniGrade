import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradeCard extends StatelessWidget {
  final String name;
  final List<int> notasP;
  final List<int> notasT;
  final List<int> notasTP;
  final int notaF;

  GradeCard(this.name, this.notasP, this.notasT, this.notasTP, this.notaF);

  //TODO: No deberia mostrar nota final si no tiene.....

  @override
  Widget build(BuildContext context) {
    String notasPractico = 'PRÁC:   ';
    String notasTeorico = 'TEO:   ';
    String notasTp = 'TP:   ';

    notasP.forEach((element) {
      notasPractico += element.toString() + ' ';
    });

    notasT.forEach((element) {
      notasTeorico += element.toString() + ' ';
    });

    notasTP.forEach((element) {
      notasTp += element.toString() + ' ';
    });

    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
        child: Container(
          width: 327.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: const Color(0xfff7f7f7),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 14,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w900,
                        height: 1.8571428571428572,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      notasTeorico,
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 14,
                        color: const Color(0xff000000),
                        height: 1.8571428571428572,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SvgPicture.string(
                      '<svg viewBox="41.0 373.5 141.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 141.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1" stroke-dasharray="2 2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                    Text(
                      notasPractico,
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 14,
                        color: const Color(0xff000000),
                        height: 1.8571428571428572,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SvgPicture.string(
                      '<svg viewBox="41.0 373.5 141.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 141.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1" stroke-dasharray="2 2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                    Text(
                      notasTp,
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 14,
                        color: const Color(0xff000000),
                        height: 1.8571428571428572,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SvgPicture.string(
                      '<svg viewBox="229.0 337.5 98.5 1.0" ><path transform="translate(229.0, 337.5)" d="M 0 0 L 98.5 0" fill="none" stroke="#6df97f" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                    Text(
                      'NOTA FINAL:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 11,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w900,
                        height: 2.3636363636363638,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Text(
                        '10',
                        style: TextStyle(
                          fontFamily: 'Avenir LT Std',
                          fontSize: 50,
                          color: const Color(0xff000000),
                          height: 0.52,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SvgPicture.string(
                      '<svg viewBox="229.0 337.5 98.5 1.0" ><path transform="translate(229.0, 337.5)" d="M 0 0 L 98.5 0" fill="none" stroke="#6df97f" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
