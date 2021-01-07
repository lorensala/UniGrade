import 'dart:async';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewUserDialog extends StatefulWidget {
  @override
  _NewUserDialogState createState() => _NewUserDialogState();
}

class _NewUserDialogState extends State<NewUserDialog> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _isNew = Provider.of<ValueNotifier<bool>>(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, 10),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  '¡Bienvenido a UniGrade!',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 22,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'UniGrade te permite a ti, el estudiante, organizar tu carrera de forma mas didáctica y fácil, además de obtener estadíscticas con solo un toque.',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 16,
                    color: const Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '¿Como funciona UniGrade?',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 16,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 16,
                      color: const Color(0xff000000),
                    ),
                    children: [
                      TextSpan(
                        text:
                            ' - Primero, deben añadirse todas las materias que hayas al menos cursado o estes cursando en el momento.\nPara realizar esto, se selecciona el botón ',
                      ),
                      TextSpan(
                        text: '"Nueva Materia"',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            '.\n- El siguiente paso es añadir las notas (si es que se ha rendido) de cada una de las materias. ',
                      ),
                      TextSpan(
                        text:
                            'Se deben colocar las notas de los parciales antes que la\nnota final de la materia, ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            'salvo en el caso de materias que no tengan parciales por ',
                      ),
                      TextSpan(
                        text: 'exámen de suficiencia',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' u otros.\n- Finalmente, se debe actualizar la condición de cada una de las materias, seleccionando el botón de ',
                      ),
                      TextSpan(
                        text: '"Actualizar Materia"',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            '.\n\nRecuerda que ante cualquier error, se puede modificar cada una de las notas ingresadas y las condiciones de cada materia.',
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: ArgonTimerButton(
                      onTap: (startTimer, btnState) async {
                        int seconds = 0;

                        if (_isNew.value) seconds = 3;

                        if (btnState == ButtonState.Idle && seconds != 0) {
                          startTimer(seconds);
                        }

                        await new Future.delayed(Duration(seconds: seconds))
                            .then((value) {
                          _isNew.value = false;
                          Navigator.pop(context);
                        });
                      },
                      loader: (time) {
                        return Text(time.toString());
                      },
                      elevation: 0,
                      borderRadius: 26,
                      color: Color(0xffA7FFAD),
                      height: 37,
                      width: 129,
                      child: Center(
                        child: Text(
                          '¡Empezar!',
                          style: TextStyle(
                            fontFamily: 'Avenir LT Std',
                            fontSize: 16,
                            color: const Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Copyright © 2021 Lorenzo Sala. Todos los derechos reservados. ',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 11,
                    color: const Color(0xff8D8D8D),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
