import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';

import 'package:mis_notas/widgets/styles/grade_card_style.dart';
import 'package:mis_notas/widgets/buttons/options_button.dart';
import 'package:mis_notas/widgets/components/search_bar.dart';
import 'package:provider/provider.dart';

class MisNotas extends StatefulWidget {
  @override
  _MisNotasState createState() => _MisNotasState();
}

class _MisNotasState extends State<MisNotas> {
  String condition = 'All';
  bool isPressedAll = true;
  bool isPressedCursando = false;
  bool isPressedAprobadas = false;
  bool isPressedLibre = false;
  bool isPressedPP = false;
  bool isPressedPT = false;
  bool isPressedAD = false;
  bool isPressedAb = false;

  Future<List<Subject>> getData(Student _student, String condition) async {
    var _subjectDao = new SubjectDao();

    if (condition == 'All')
      return await _subjectDao.getAllSubjectsByUserOrderByYear(_student);
    else if (condition == 'Electiva')
      return await _subjectDao.getAllSubjectsByUserCondition(
          _student, condition);
    else
      return await _subjectDao.getAllSubjectsByUserCondition(
          _student, condition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            'assets/images/3.0x/backarrow.png',
                            scale: 3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mis Notas y boton ayuda
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Mis Notas',
                          style: TextStyle(
                            fontFamily: 'Avenir LT Std',
                            fontSize: 30,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w800,
                            height: 0.9666666666666667,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SvgPicture.string(
                          '<svg viewBox="323.0 109.0 28.0 28.0" ><path transform="translate(322.44, 108.44)" d="M 28.56250381469727 14.56250095367432 C 28.56250381469727 22.29620552062988 22.2939453125 28.56250381469727 14.56250095367432 28.56250381469727 C 6.831056594848633 28.56250381469727 0.5625000596046448 22.29620170593262 0.5625000596046448 14.56250095367432 C 0.5625000596046448 6.833314418792725 6.831056594848633 0.5625000596046448 14.56250095367432 0.5625000596046448 C 22.2939453125 0.5625000596046448 28.56250381469727 6.833314895629883 28.56250381469727 14.56250095367432 Z M 14.93818664550781 5.191532611846924 C 11.86174297332764 5.191532611846924 9.899598121643066 6.487492561340332 8.358806610107422 8.790775299072266 C 8.159193992614746 9.089178085327148 8.22597599029541 9.491621971130371 8.512073516845703 9.708564758300781 L 10.47088718414307 11.19380760192871 C 10.76471900939941 11.41662120819092 11.18336391448975 11.36361408233643 11.41165351867676 11.07401657104492 C 12.42010498046875 9.794936180114746 13.11158180236816 9.053218841552734 14.64650058746338 9.053218841552734 C 15.7997522354126 9.053218841552734 17.22622680664063 9.795444488525391 17.22622680664063 10.91375064849854 C 17.22622680664063 11.75917053222656 16.5283145904541 12.19334030151367 15.38963031768799 12.83175086975098 C 14.06166172027588 13.5761775970459 12.30443572998047 14.50271892547607 12.30443572998047 16.82056617736816 L 12.30443572998047 17.04637145996094 C 12.30443572998047 17.42047691345215 12.60775089263916 17.72379112243652 12.98185539245605 17.72379112243652 L 16.14314651489258 17.72379112243652 C 16.51725006103516 17.72379112243652 16.82056617736816 17.42047691345215 16.82056617736816 17.04637145996094 L 16.82056617736816 16.97112274169922 C 16.82056617736816 15.36439514160156 21.51655006408691 15.29750061035156 21.51655006408691 10.94959735870361 C 21.51655006408691 7.675290107727051 18.12013626098633 5.191532611846924 14.93818664550781 5.191532611846924 Z M 14.56250095367432 19.19153213500977 C 13.13060569763184 19.19153213500977 11.96572685241699 20.35641479492188 11.96572685241699 21.78830909729004 C 11.96572685241699 23.22014617919922 13.13060569763184 24.38508224487305 14.56250095367432 24.38508224487305 C 15.9943962097168 24.38508224487305 17.15927505493164 23.22014617919922 17.15927505493164 21.78830909729004 C 17.15927505493164 20.35641479492188 15.9943962097168 19.19153213500977 14.56250095367432 19.19153213500977 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                          allowDrawingOutsideViewBox: true,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    //TODO: Implementar la busqueda si es posible.
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: SearchBar(null),
                  ),
                  // Filtros
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          //alignment: WrapAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              borderRadius: BorderRadius.circular(26),
                              child: OptionButton('Todas', isPressedAll),
                              onTap: () {
                                setState(() {
                                  isPressedAll = true;
                                  isPressedCursando = false;
                                  isPressedAprobadas = false;
                                  isPressedLibre = false;
                                  isPressedPP = false;
                                  isPressedPT = false;
                                  isPressedAD = false;
                                  isPressedAb = false;
                                  condition = 'All';
                                });
                              },
                            ),
                            InkWell(
                                borderRadius: BorderRadius.circular(26),
                                child:
                                    OptionButton('Cursando', isPressedCursando),
                                onTap: () {
                                  setState(() {
                                    isPressedAll = false;
                                    isPressedCursando = true;
                                    isPressedAprobadas = false;
                                    isPressedLibre = false;
                                    isPressedPP = false;
                                    isPressedPT = false;
                                    isPressedAD = false;
                                    isPressedAb = false;
                                    condition = 'Cursando';
                                  });
                                }),
                            InkWell(
                                borderRadius: BorderRadius.circular(26),
                                child: OptionButton(
                                    'Regulares', isPressedAprobadas),
                                onTap: () {
                                  setState(() {
                                    isPressedAll = false;
                                    isPressedCursando = false;
                                    isPressedAprobadas = true;
                                    isPressedLibre = false;
                                    isPressedPP = false;
                                    isPressedPT = false;
                                    isPressedAD = false;
                                    isPressedAb = false;
                                    condition = 'Regular';
                                  });
                                }),
                            InkWell(
                                borderRadius: BorderRadius.circular(26),
                                child: OptionButton('Prom. Prác.', isPressedPP),
                                onTap: () {
                                  setState(() {
                                    isPressedAll = false;
                                    isPressedCursando = false;
                                    isPressedAprobadas = false;
                                    isPressedLibre = false;
                                    isPressedPP = true;
                                    isPressedPT = false;
                                    isPressedAD = false;
                                    isPressedAb = false;
                                    condition = 'Promoción Práctica';
                                  });
                                }),
                            InkWell(
                                borderRadius: BorderRadius.circular(26),
                                child: OptionButton('Prom. Teó.', isPressedPT),
                                onTap: () {
                                  setState(() {
                                    isPressedAll = false;
                                    isPressedCursando = false;
                                    isPressedAprobadas = false;
                                    isPressedLibre = false;
                                    isPressedPP = false;
                                    isPressedPT = true;
                                    isPressedAD = false;
                                    isPressedAb = false;
                                    condition = 'Promoción Teórica';
                                  });
                                }),
                            InkWell(
                                borderRadius: BorderRadius.circular(26),
                                child: OptionButton('Ap. Directa', isPressedAD),
                                onTap: () {
                                  setState(() {
                                    isPressedAll = false;
                                    isPressedCursando = false;
                                    isPressedAprobadas = false;
                                    isPressedLibre = false;
                                    isPressedPP = false;
                                    isPressedPT = false;
                                    isPressedAD = true;
                                    isPressedAb = false;
                                    condition = 'Aprobación Directa';
                                  });
                                }),
                            InkWell(
                                borderRadius: BorderRadius.circular(26),
                                child: OptionButton('Libre', isPressedLibre),
                                onTap: () {
                                  setState(() {
                                    isPressedAll = false;
                                    isPressedCursando = false;
                                    isPressedAprobadas = false;
                                    isPressedLibre = true;
                                    isPressedPP = false;
                                    isPressedPT = false;
                                    isPressedAD = false;
                                    isPressedAb = false;
                                    condition = 'Libre';
                                  });
                                }),
                            InkWell(
                                borderRadius: BorderRadius.circular(26),
                                child: OptionButton('Aban.', isPressedAb),
                                onTap: () {
                                  setState(() {
                                    isPressedAll = false;
                                    isPressedCursando = false;
                                    isPressedAprobadas = false;
                                    isPressedLibre = false;
                                    isPressedPP = false;
                                    isPressedPT = false;
                                    isPressedAD = false;
                                    isPressedAb = true;
                                    condition = 'Abandonada';
                                  });
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: getData(Provider.of<Student>(context), condition),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());

                          default:
                            if (snapshot.hasError) return Text('error');
                            if (!snapshot.data.isEmpty) {
                              return Expanded(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Subject sub = snapshot.data[index];
                                    return GradeCard(sub);
                                  },
                                ),
                              );
                            } else {
                              //TODO: Return something nice.
                              return Padding(
                                padding: EdgeInsets.all(20),
                                child: Center(
                                  child: Text(
                                    'No existen materias en esta categoría :(',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              );
                            }
                        }
                      })
                ],
              )),
        ));
  }
}
