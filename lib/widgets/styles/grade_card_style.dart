import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/pages/dialogs/dialog_subject_info.dart';

class GradeCard extends StatelessWidget {
  final Subject _subject;

  GradeCard(this._subject);

  @override
  Widget build(BuildContext context) {
    List<int> gradesP = _subject.getGradesP();
    List<int> gradesT = _subject.getGradesT();
    List<int> gradesTP = _subject.getGradesTP();
    List<int> gradesAp = _subject.getAplazos();
    int nf = _subject.getNf();

    String notasPractico = 'PRÁC:   ';
    String notasTeorico = '  TEÓ:   ';
    String notasTp = '     TP:    ';
    String notasAp = '   APL:    ';

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

    gradesAp.forEach((element) {
      if (element < 10)
        notasAp += element.toString() + '  ';
      else
        notasAp += element.toString() + ' ';
    });

    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
        child: Container(
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
                          ),
                          SvgPicture.string(
                            '<svg viewBox="41.0 373.5 181.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 181.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1.5" stroke-dasharray="8 3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            allowDrawingOutsideViewBox: true,
                          ),
                          Text(
                            notasAp,
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
                      if (_subject.getState().getState().getName() ==
                              'Regular' &&
                          nf != -1)
                        Column(
                          children: <Widget>[
                            SvgPicture.string(
                              '<svg viewBox="229.0 399.5 98.5 1.0" ><path transform="translate(229.0, 399.5)" d="M 0 0 L 98.5 0" fill="none" stroke="#faff72" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
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
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                              '<svg viewBox="229.0 399.5 98.5 1.0" ><path transform="translate(229.0, 399.5)" d="M 0 0 L 98.5 0" fill="none" stroke="#faff72" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      if ((_subject.getState().getState().getName() ==
                                  'Promoción Práctica' ||
                              _subject.getState().getState().getName() ==
                                  'Promoción Teórica') &&
                          nf != -1)
                        Column(
                          children: <Widget>[
                            SvgPicture.string(
                              '<svg viewBox="229.0 714.5 98.0 1.0" ><path transform="translate(229.0, 714.5)" d="M 0 0 L 98 0" fill="none" stroke="#96cbff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
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
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                              '<svg viewBox="229.0 714.5 98.0 1.0" ><path transform="translate(229.0, 714.5)" d="M 0 0 L 98 0" fill="none" stroke="#96cbff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      if (_subject.getState().getState().getName() ==
                              'Aprobación Directa' &&
                          nf != -1)
                        Column(
                          children: <Widget>[
                            SvgPicture.string(
                              '<svg viewBox="229.0 357.5 98.0 1.0" ><path transform="translate(229.0, 357.5)" d="M 0 0 L 98 0" fill="none" stroke="#6df97f" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
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
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                              '<svg viewBox="229.0 357.5 98.0 1.0" ><path transform="translate(229.0, 357.5)" d="M 0 0 L 98 0" fill="none" stroke="#6df97f" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      if ((_subject.getState().getState().getName() ==
                                  'Libre' ||
                              _subject.getState().getState().getName() ==
                                  'Abandonada') &&
                          nf != -1)
                        Column(
                          children: <Widget>[
                            SvgPicture.string(
                              '<svg viewBox="205.5 665.5 122.0 1.0" ><path transform="translate(205.5, 665.5)" d="M 0 0 L 122 0" fill="none" stroke="#4f5973" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
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
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                              '<svg viewBox="205.5 665.5 122.0 1.0" ><path transform="translate(205.5, 665.5)" d="M 0 0 L 122 0" fill="none" stroke="#4f5973" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        ),
                      if (nf == -1 &&
                          _subject.getState().getState().getName() != '')
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.string(
                              '<svg viewBox="222.5 665.5 105.0 1.0" ><path transform="translate(222.5, 665.5)" d="M 0 0 L 105 0" fill="none" stroke="#4f5973" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                            _subject.getState().getState().getName() ==
                                    'Abandonada'
                                ? Text(
                                    'ABAN.',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      height: 2.3636363636363638,
                                    ),
                                  )
                                : Text(
                                    _subject
                                        .getState()
                                        .getState()
                                        .getName()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w600,
                                      height: 2.3636363636363638,
                                    ),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            SvgPicture.string(
                              '<svg viewBox="222.5 665.5 105.0 1.0" ><path transform="translate(222.5, 665.5)" d="M 0 0 L 105 0" fill="none" stroke="#4f5973" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
