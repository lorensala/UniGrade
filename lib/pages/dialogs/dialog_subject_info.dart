import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialogSubjectInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Container(
          height: 500,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(26)),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 250,
                child: Text(
                  'Programacion de Apliaciones Visuales II',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 25,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.string(
                '<svg viewBox="60.0 255.5 255.5 1.0" ><path transform="translate(60.0, 255.5)" d="M 0 0 L 255.5 0" fill="none" stroke="#66aaff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Estado: Cursando',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.string(
                '<svg viewBox="60.0 296.5 255.5 1.0" ><path transform="translate(60.0, 296.5)" d="M 0 0 L 255.5 0" fill="none" stroke="#66aaff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'CORRELATIVAS',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Para cursar',
                        style: TextStyle(
                          fontFamily: 'Avenir LT Std',
                          fontSize: 18,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Cursada',
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Aprobada',
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Para rendir',
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 18,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
