import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mis_notas/style/colors.dart';
import 'package:mis_notas/style/main_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Hamburger icon and setting icon.
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Lorenzo\nSala',
                        style: TextStyle(
                          fontFamily: 'Avenir LT Std',
                          fontSize: 30,
                          color: textColor,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        width: 120.0,
                        height: 118.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.elliptical(9999.0, 9999.0)),
                          image: DecorationImage(
                            image: const AssetImage('assets/images/person.png'),
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
                        'Ingeniería en Sistemas',
                        style: TextStyle(
                          fontFamily: 'Avenir LT Std',
                          fontSize: 18,
                          color: textColor2,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'UTN-FRC',
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: const Color(0xff66aaff),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    '8',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    width: 58.0,
                                    child: Text(
                                      'Promedio\nGeneral',
                                      style: TextStyle(
                                        fontFamily: 'Avenir LT Std',
                                        fontSize: 11,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                              Image.asset('assets/images/div.png'),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 30,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    width: 65.0,
                                    child: Text(
                                      'Materias\nAprobadas',
                                      style: TextStyle(
                                        fontFamily: 'Avenir LT Std',
                                        fontSize: 11,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                              Image.asset('assets/images/div.png'),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '24',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 30,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    width: 58.0,
                                    child: Text(
                                      'Materias\nRestantes',
                                      style: TextStyle(
                                        fontFamily: 'Avenir LT Std',
                                        fontSize: 11,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
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
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                // Listview
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                  child: Container(
                    height: 130,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        MainButton(),
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(26),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/misnotas');
                                  },
                                  child: Container(
                                    width: 129.0,
                                    height: 92.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26.0),
                                      color: const Color(0xffFFDCDC),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          17, 40, 0, 0),
                                      child: Text(
                                        'Mis\nNotas',
                                        style: TextStyle(
                                          fontFamily: 'Avenir LT Std',
                                          fontSize: 18,
                                          color: const Color(0xff484848),
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 63,
                              child: Image.asset(
                                'assets/images/001-test.png',
                                width: 54.0,
                                height: 54.0,
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(26),
                                  onTap: () {},
                                  child: Container(
                                    width: 129.0,
                                    height: 92.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26.0),
                                      color: const Color(0xffF5DCFF),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          17, 40, 0, 0),
                                      child: Text(
                                        'Mis\nEstadísticas',
                                        style: TextStyle(
                                          fontFamily: 'Avenir LT Std',
                                          fontSize: 18,
                                          color: const Color(0xff484848),
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 63,
                              child: Image.asset(
                                'assets/images/030-cup.png',
                                width: 54.0,
                                height: 54.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Text(
                    'Funciones Rápidas',
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 22,
                      color: const Color(0xff484848),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                // Funciones rapidas
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                  child: Row(children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {
                        Navigator.pushNamed(context, '/nuevanota');
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'Nueva Nota',
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 14,
                              color: const Color(0xff7c7979),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        width: 129.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          color: const Color(0xfff0f0f0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {},
                      child: Container(
                        child: Center(
                          child: Text(
                            'Nueva Materia',
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 14,
                              color: const Color(0xff7c7979),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        width: 129.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          color: const Color(0xffffdcdc),
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.grey,
          child: Row(
            children: <Widget>[],
          ),
        ));
  }
}
