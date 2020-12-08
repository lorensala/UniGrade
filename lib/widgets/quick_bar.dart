import 'package:flutter/material.dart';

class QuickBar extends StatelessWidget {
  final double prom;
  final int aprobadas;
  final int restantes;

  QuickBar({this.prom, this.aprobadas, this.restantes});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      '${this.prom}',
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
                      '${this.aprobadas}',
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
                      '${this.restantes}',
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
    );
  }
}
