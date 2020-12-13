import 'package:flutter/material.dart';

class MisEstadisticas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
                  child: Text(
                    'Mis Estadísticas',
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 30,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w900,
                      height: 0.9666666666666667,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
                  child: Text(
                    'Progreso:',
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 22,
                      color: const Color(0xff484848),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                  child: Container(
                    height: 238.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26.0),
                      color: const Color(0xfff7f7f7),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
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
                              '8,37',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 50,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 106.0,
                              child: Text(
                                'Promedio\nsin aplazos',
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
                      Container(
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
                              '7,66',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 50,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 106.0,
                              child: Text(
                                'Promedio\ncon aplazos',
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
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
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
                              '13',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 50,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 106.0,
                              child: Text(
                                'Materias\naprobadas',
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
                      Container(
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
                              '24',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 50,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 106.0,
                              child: Text(
                                'Materias\nrestantes',
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
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
