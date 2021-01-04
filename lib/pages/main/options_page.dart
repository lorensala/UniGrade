import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
      child: Container(
        width: 170.0,
        height: 200,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Column(
            children: <Widget>[
              Text(
                'Opciones',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 40,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                  height: 0.9666666666666667,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.string(
                '<svg viewBox="12.0 59.5 145.5 1.0" ><path transform="translate(12.0, 59.5)" d="M 0 0 L 145.5 0" fill="none" stroke="#e0e0e0" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 20,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                        height: 1.45,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SvgPicture.string(
                      '<svg viewBox="12.0 59.5 145.5 1.0" ><path transform="translate(12.0, 59.5)" d="M 0 0 L 145.5 0" fill="none" stroke="#e0e0e0" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                      allowDrawingOutsideViewBox: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
