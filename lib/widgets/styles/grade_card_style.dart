import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/pages/pages/misnotas/notas_info_page.dart';
import 'package:provider/provider.dart';

class GradeCard extends StatelessWidget {
  final Subject _subject;
  final bool action;

  GradeCard(this._subject, this.action);

  @override
  Widget build(BuildContext context) {
    List<int> gradesP = _subject.getGradesP();
    List<int> gradesT = _subject.getGradesT();
    List<int> gradesTP = _subject.getGradesTP();
    List<int> gradesAp = _subject.getAplazos();
    int nf = _subject.getNf();

    String notasPractico = '';
    String notasTeorico = '';
    String notasTp = '';
    String notasAp = '';

    Color _getColors(String condition) {
      switch (condition) {
        case 'Regular':
          return Color(0xffFEFFD9);
        case 'Aprobación Directa':
          return Color(0xffE2FFE3);
        case 'Promoción Teórica':
          return Color(0xffE4F0FF);
        case 'Promoción Práctica':
          return Color(0xffEAD6FF);
        case 'Abandonada':
          return Color(0xffFFE4E4);
        case 'Libre':
          return Color(0xffFFE4E4);
        default:
          return Color(0xffF7F7F7);
      }
    }

    Map<String, String> _stateText = {
      'Regular': 'REG.',
      'Aprobación Directa': 'AP.DIR.',
      'Promoción Teórica': 'PROM.T',
      'Promoción Práctica': 'PROM.P',
      'Abandonada': 'ABAN.',
      'Libre': 'LIB.',
      '': '',
    };

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
        child: InkWell(
          onTap: action
              ? () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 250),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.easeInOut);
                            return SlideTransition(
                              position: Tween(
                                      begin: Offset(0.0, 1.0),
                                      end: Offset(0.0, 0.0))
                                  .animate(animation),
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, animationTime) {
                            return ChangeNotifierProvider(
                                create: (context) => Subject.empty(),
                                child: MisNotasInfo(_subject));
                          }));
                }
              : null,
          borderRadius: BorderRadius.circular(26),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
                color: !(nf >= 6)
                    ? _getColors(_subject.getState().getState().getName())
                    : Color(0xffE2FFE3)),
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
                            Row(
                              children: [
                                Text(
                                  '  TEÓ:   ',
                                  style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      height: 1.8571428571428572,
                                      fontWeight: FontWeight.w800),
                                ),
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
                              ],
                            ),
                            SvgPicture.string(
                              '<svg viewBox="41.0 373.5 181.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 181.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1.5" stroke-dasharray="8 3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                            Row(
                              children: [
                                Text(
                                  'PRÁC:   ',
                                  style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      height: 1.8571428571428572,
                                      fontWeight: FontWeight.w800),
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
                              ],
                            ),
                            SvgPicture.string(
                              '<svg viewBox="41.0 373.5 181.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 181.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1.5" stroke-dasharray="8 3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                            Row(
                              children: [
                                Text(
                                  '     TP:    ',
                                  style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      height: 1.8571428571428572,
                                      fontWeight: FontWeight.w800),
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
                              ],
                            ),
                            SvgPicture.string(
                              '<svg viewBox="41.0 373.5 181.5 1.0" ><path transform="translate(41.0, 373.5)" d="M 181.5 0 L 0 0" fill="none" stroke="#afafaf" stroke-width="1.5" stroke-dasharray="8 3" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                              allowDrawingOutsideViewBox: true,
                            ),
                            Row(
                              children: [
                                Text(
                                  '   APL:    ',
                                  style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      height: 1.8571428571428572,
                                      fontWeight: FontWeight.w800),
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
                                ),
                              ],
                            ),
                          ],
                        ),
                        (nf != -1)
                            ? Column(
                                children: <Widget>[
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
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      _stateText[_subject
                                          .getState()
                                          .getState()
                                          .getName()],
                                      style: TextStyle(
                                        fontFamily: 'Avenir LT Std',
                                        fontSize: 18,
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        height: 2.3636363636363638,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
