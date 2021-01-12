import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mis_notas/animation/FadeAnimation.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';

import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/pages/main/home.dart';

import 'package:mis_notas/widgets/styles/grade_card_style.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MisNotas extends StatefulWidget {
  @override
  _MisNotasState createState() => _MisNotasState();
}

class _MisNotasState extends State<MisNotas> {
  String _condition = 'Todas';
  RefreshController _refreshController = new RefreshController();

  Future<List<Subject>> getData(Student _student, String condition) async {
    var _subjectDao = new SubjectsDao();

    if (condition == 'Todas')
      return await _subjectDao.getAllSubjectsByUserOrderByYear(_student);
    else if (condition == 'Electiva')
      return await _subjectDao
          .getAllElectiveSubjectsByUserOrderByYear(_student);
    else if (condition == 'Aprobada')
      return await _subjectDao.getAllSubjectsByPassed(_student);
    else if (int.tryParse(condition) != null)
      return await _subjectDao.getAllSubjectsYear(
          _student, int.parse(condition));
    else
      return await _subjectDao.getAllSubjectsByUserCondition(
          _student, condition);
  }

  void initState() {
    // only create the future once.
    super.initState();
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
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 250),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      animation = CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeInOut);
                                      return SlideTransition(
                                        position: Tween(
                                                begin: Offset(1.0, 0.0),
                                                end: Offset(0.0, 0.0))
                                            .animate(animation),
                                        child: child,
                                      );
                                    },
                                    pageBuilder:
                                        (context, animation, animationTime) {
                                      return HomePage();
                                    }));
                          },
                          icon: Image.asset(
                            'assets/images/3.0x/backarrow.png',
                            scale: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    padding: const EdgeInsets.fromLTRB(24, 10, 0, 0),
                    child: SvgPicture.string(
                      '<svg viewBox="24.0 151.5 255.5 1.0" ><path transform="translate(24.0, 151.5)" d="M 0 0 L 255.5 0" fill="none" stroke="#66aaff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                    child: Container(
                      //width: 200,
                      height: 37.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: const Color(0xfff7f7f7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              isExpanded: true,
                              value: _condition,
                              onChanged: (newValue) {
                                setState(() {
                                  _condition = newValue;
                                });
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Todas',
                                  child: Text(
                                    'Todas',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Cursando',
                                  child: Text(
                                    'Cursando',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Aprobada',
                                  child: Text(
                                    'Aprobadas',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Regular',
                                  child: Text(
                                    'Regulares',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Promoción Teórica',
                                  child: Text(
                                    'Promoción Teórica',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Promoción Práctica',
                                  child: Text(
                                    'Promoción Práctica',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Aprobación Directa',
                                  child: Text(
                                    'Aprobación Directa',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Libre',
                                  child: Text(
                                    'Libre',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Abandonada',
                                  child: Text(
                                    'Abandonada',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Electiva',
                                  child: Text(
                                    'Electiva',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '1',
                                  child: Text(
                                    '1er Año',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '2',
                                  child: Text(
                                    '2do Año',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '3',
                                  child: Text(
                                    '3er Año',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '4',
                                  child: Text(
                                    '4to Año',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '5',
                                  child: Text(
                                    '5to Año',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      height: 0.9666666666666667,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future:
                          getData(Provider.of<Student>(context), _condition),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());

                          default:
                            if (snapshot.hasError) return Text('error');
                            if (!snapshot.data.isEmpty) {
                              return Expanded(
                                child: FadeAnimation(
                                  delay: 0.1,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      Subject sub = snapshot.data[index];
                                      return GradeCard(sub, true);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Image.asset(
                                      'assets/images/not_found.png',
                                      scale: 4,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(24),
                                    child: Center(
                                      child: Text(
                                        'No se encontraron materias en esta categoría.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Avenir LT Std',
                                          fontSize: 18,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        }
                      }),
                ],
              )),
        ));
  }
}
