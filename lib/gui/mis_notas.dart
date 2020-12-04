import 'package:flutter/material.dart';
import 'package:mis_notas/style/notas_style.dart';
import 'package:mis_notas/style/options_button.dart';

class MisNotas extends StatelessWidget {
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
                    padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
                    child: Text(
                      'Mis Notas',
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
                            OptionButton('Cursando'),
                            OptionButton('Aprobadas'),
                            OptionButton('Libre'),
                            OptionButton('Promoción'),
                            OptionButton('Ap. Directa'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Materia',
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
                              'PRÁCTICO',
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
                              'TEÓRICO',
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
                              'TP',
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
                              'NF',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 14,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w900,
                                height: 1.8571428571428572,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        Image.asset('assets/images/3.0x/bluebar.png'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return NotaCard();
                      },
                    ),
                  )
                ],
              )),
        ));
  }
}
