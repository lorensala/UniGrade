import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mis_notas/entities/subject.dart';

class GradeCard extends StatelessWidget {
  final Subject _subject;

  GradeCard(this._subject);

  @override
  Widget build(BuildContext context) {
    List<int> gradesP = _subject.getGradesP();
    List<int> gradesT = _subject.getGradesT();
    List<int> gradesTP = _subject.getGradesTP();
    int nf = _subject.getNf();

    //TODO: Cambiar esto, para que esten alineados.

    String notasPractico = 'PRÁC:   ';
    String notasTeorico = '  TEO:   ';
    String notasTp = '     TP:    ';

    gradesP.forEach((element) {
      if (element < 10)
        notasPractico += element.toString() + '  ';
      else
        notasPractico += element.toString() + ' ';
    });

    gradesT.forEach((element) {
      if (element < 10)
        notasTeorico += element.toString() + '  ';
      else
        notasTeorico += element.toString() + ' ';
    });

    gradesTP.forEach((element) {
      if (element < 10)
        notasTp += element.toString() + '  ';
      else
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
            child: Column(
              children: <Widget>[
                Text(
                  _subject.getName(),
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 17,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w800,
                    height: 1.8571428571428572,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            notasTeorico,
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 18,
                              color: const Color(0xff000000),
                              height: 1.8571428571428572,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SvgPicture.string(
                            '<svg viewBox="41.0 373.5 181.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 181.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1.5" stroke-dasharray="8 3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            allowDrawingOutsideViewBox: true,
                          ),
                          Text(
                            notasPractico,
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 18,
                              color: const Color(0xff000000),
                              height: 1.8571428571428572,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SvgPicture.string(
                            '<svg viewBox="41.0 373.5 181.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 181.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1.5" stroke-dasharray="8 3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            allowDrawingOutsideViewBox: true,
                          ),
                          Text(
                            notasTp,
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 18,
                              color: const Color(0xff000000),
                              height: 1.8571428571428572,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      nf != -1
                          ? Column(
                              children: <Widget>[
                                SvgPicture.string(
                                  '<svg viewBox="229.0 337.5 98.5 1.0" ><path transform="translate(229.0, 337.5)" d="M 0 0 L 98.5 0" fill="none" stroke="#6df97f" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                                  allowDrawingOutsideViewBox: true,
                                ),
                                Text(
                                  'NOTA FINAL:',
                                  style: TextStyle(
                                    fontFamily: 'Avenir LT Std',
                                    fontSize: 13,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w800,
                                    height: 2.3636363636363638,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Text(
                                    nf.toString(),
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
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
