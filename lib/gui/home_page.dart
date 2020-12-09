import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mis_notas/widgets/colors.dart';
import 'package:mis_notas/widgets/dialog_nuevamateria.dart';
import 'package:mis_notas/widgets/dialog_nuevanota.dart';
import 'package:mis_notas/widgets/main_button.dart';
import 'package:mis_notas/widgets/quick_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//TODO: Acomodar la logica para los btones de la nav bar, o sacarla a a la mierda

class _HomePageState extends State<HomePage> {
  bool _isPressedInfo = false;
  bool _isPressedHome = false;
  bool _isPressedUser = false;

  int indexInfo = 0;
  int indexHome = 0;
  int indexUser = 0;

  final db = FirebaseFirestore.instance;

  var buttons = {
    'info': ['assets/images/info.png', 'assets/images/info_white.png'],
    'home': ['assets/images/home.png', 'assets/images/home_white.png'],
    'user': ['assets/images/user.png', 'assets/images/user_white.png']
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
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
                              image:
                                  const AssetImage('assets/images/person.png'),
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
                      child: QuickBar(
                    prom: 8,
                    aprobadas: 10,
                    restantes: 38,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(26),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/misnotas');
                                    },
                                    child: Container(
                                      width: 129.0,
                                      height: 92.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(26.0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(26),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/estadisticas');
                                    },
                                    child: Container(
                                      width: 129.0,
                                      height: 92.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(26.0),
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
                          showNuevaNota(context);

                          //showNuevaNota(context);
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
                        onTap: () {
                          showNuevaMateria(context);
                        },
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
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Positioned(
                      right: 4,
                      top: 4,
                      child: CircleAvatar(
                        backgroundColor: _isPressedInfo ? blue : white,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(buttons['info'][indexInfo]),
                      onPressed: () => {
                        setState(() {
                          _isPressedInfo = !_isPressedInfo;
                          _isPressedHome = false;
                          _isPressedUser = false;
                          if (indexInfo == 0)
                            indexInfo++;
                          else
                            indexInfo--;
                          indexHome = 0;
                          indexUser = 0;
                        })
                      },
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      right: 4,
                      top: 4,
                      child: CircleAvatar(
                        backgroundColor: _isPressedHome ? blue : white,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(buttons['home'][indexHome]),
                      onPressed: () => {
                        setState(() {
                          _isPressedHome = !_isPressedHome;
                          _isPressedInfo = false;
                          _isPressedUser = false;
                          if (indexHome == 0) {
                            indexHome++;
                          } else
                            indexHome--;
                          indexInfo = 0;
                          indexUser = 0;
                        })
                      },
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      right: 4,
                      top: 4,
                      child: CircleAvatar(
                        backgroundColor: _isPressedUser ? blue : white,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(buttons['user'][indexUser]),
                      onPressed: () => {
                        setState(() {
                          _isPressedUser = !_isPressedUser;
                          _isPressedHome = false;
                          _isPressedInfo = false;
                          if (indexUser == 0)
                            indexUser++;
                          else
                            indexUser--;
                          indexInfo = 0;
                          indexHome = 0;
                        })
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void showNuevaNota(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogNuevaNota();
        });
  }

  void showNuevaMateria(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogNuevaMateria();
        });
  }
}
