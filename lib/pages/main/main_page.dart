import 'package:flutter/material.dart';
import 'package:mis_notas/entities/student.dart';

import 'package:mis_notas/pages/dialogs/new_user_dialog.dart';
import 'package:mis_notas/pages/pages/mis_estadistica.dart';
import 'package:mis_notas/pages/pages/mis_materias.dart';
import 'package:mis_notas/pages/pages/misnotas/mis_notas.dart';

import 'package:mis_notas/widgets/buttons/main_button.dart';
import 'package:mis_notas/widgets/components/quick_bar.dart';

import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Image.asset('assets/images/hamburger.png'),
                  InkWell(
                      onTap: () {
                        showNewUserDialog(context);
                      },
                      child: Image.asset('assets/images/info.png')),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    formatText(_student.getFullname()),
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 30,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    width: 120.0,
                    height: 118.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      image: DecorationImage(
                        image: NetworkImage(_student.getProfilePic()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/line.png',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Name, avatar, university text and carreer.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _student.getUniversity().getCareers()[0].getName(),
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 18,
                      color: Color(0xff484848),
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    _student.getUniversity().getShortName(),
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 14,
                      color: const Color(0xff9a9a9a),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Consumer<Student>(
              builder: (_, student, ___) => QuickBar(
                prom: student.getStatistics().getAvg(),
                aprobadas: student.getStatistics().getPassed(),
                restantes: student.getStatistics().getLeft(),
              ),
            )),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Text(
                'Información',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 22,
                  color: const Color(0xff484848),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            // Listview
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 18),
              child: Container(
                child: Wrap(
                  spacing: 20,
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 250),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut);
                                  return SlideTransition(
                                    position: Tween(
                                            begin: Offset(0.0, 1.0),
                                            end: Offset(0.0, 0.0))
                                        .animate(animation),
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return MisMaterias();
                                }));
                      },
                      child: MainButton(
                        'Mis\nMaterias',
                        'assets/images/materias.png',
                        Color(0xFFF7F7F7),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 250),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut);
                                  return SlideTransition(
                                    position: Tween(
                                            begin: Offset(0.0, 1.0),
                                            end: Offset(0.0, 0.0))
                                        .animate(animation),
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return MisNotas(0);
                                }));
                      },
                      child: MainButton(
                        'Mis\nNotas',
                        'assets/images/notas.png',
                        Color(0xFFFFDCDC),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 250),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut);
                                  return SlideTransition(
                                    position: Tween(
                                            begin: Offset(0.0, 1.0),
                                            end: Offset(0.0, 0.0))
                                        .animate(animation),
                                    child: child,
                                  );
                                },
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return MisEstadisticas();
                                }));
                      },
                      child: MainButton(
                        'Mis\nEstadísticas',
                        'assets/images/estadisticas.png',
                        Color(0xFFF5DCFF),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showNewUserDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return NewUserDialog();
        });
  }

  String formatText(String fullname) {
    List<String> _aux = fullname.split(' ');

    return _aux[0] + '\n' + _aux[1];
  }
}
