import 'package:flutter/material.dart';
import 'package:mis_notas/api/api.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/services/sing_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class MainLogin extends StatefulWidget {
  @override
  _MainLoginState createState() => _MainLoginState();
}

//TODO: No funca con pantalla chica!! Usar mediaquery para el tamanio de los lottie.
class _MainLoginState extends State<MainLogin> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _isNew =
        Provider.of<ValueNotifier<bool>>(context, listen: false);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        child: Column(
          children: <Widget>[
            Text(
              'UniGrade',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 50,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '¡Organiza tu carrera!',
              style: TextStyle(
                fontFamily: 'Avenir LT Std',
                fontSize: 25,
                color: const Color(0xff7c7979),
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 90,
            ),
            Consumer<ValueNotifier<bool>>(
              builder: (context, isNew, child) => Visibility(
                visible: !isNew.value && !_isPressed,
                child: Consumer<Student>(builder: (context, _student, child) {
                  return InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        /* Sesion sesion =
                            new Sesion('80215', 'sistemas', 'Lorenzo90'); */
                        _isPressed = true;
                        UserCredential _userCredentials =
                            await signInWithGoogle();
                        _isNew.value = false;

                        if (_userCredentials.additionalUserInfo.isNewUser) {
                          _isNew.value = true;
                        } else {
                          Navigator.pushNamed(context, '/homepage');
                        }
                      },
                      child: Container(
                        width: 300.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              width: 1.0, color: const Color(0xffed5a4f)),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                'Inicia Sesión / Registrate',
                                style: TextStyle(
                                  fontFamily: 'Avenir LT Std',
                                  fontSize: 20,
                                  color: const Color(0xffda554b),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Image.asset('assets/images/google.png'),
                            ],
                          ),
                        ),
                      ));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
