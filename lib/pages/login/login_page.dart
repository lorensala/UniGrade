import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/services/sing_in.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _isNew =
        Provider.of<ValueNotifier<bool>>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          //alignment: Alignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: Lottie.asset('assets/lottie/top.json')),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 200),
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
                      height: 10,
                    ),
                    Consumer<ValueNotifier<bool>>(
                      builder: (context, isNew, child) => Visibility(
                        visible: _isNew.value,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Selecciona tu Universidad:',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 16,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 288.0,
                              height: 37.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26.0),
                                color: const Color(0xfff7f7f7),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      value: null,
                                      onChanged: null,
                                      //hint: new Text('Materia'),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                              'Universidad Tecnologica Nacional'),
                                          value:
                                              'Universidad Tecnologica Nacional',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Selecciona tu carrera:',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 16,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 288.0,
                              height: 37.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26.0),
                                color: const Color(0xfff7f7f7),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      value: null,
                                      onChanged: null,
                                      //hint: new Text('Materia'),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                              'Universidad Tecnologica Nacional'),
                                          value:
                                              'Universidad Tecnologica Nacional',
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(26),
                              onTap: null,
                              child: Container(
                                width: 129.0,
                                height: 37.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26.0),
                                  color: const Color(0xffA7FFAD),
                                ),
                                child: Center(
                                  child: Text(
                                    'Confirmar',
                                    style: TextStyle(
                                      fontFamily: 'Avenir LT Std',
                                      fontSize: 16,
                                      color: const Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    Consumer<ValueNotifier<bool>>(
                      builder: (context, isNew, child) => Visibility(
                        visible: !isNew.value,
                        child: Consumer<Student>(
                            builder: (context, _student, child) {
                          return InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              UserCredential _userCredentials =
                                  await signInWithGoogle();
                              User _user = _userCredentials.user;

                              if (_userCredentials
                                  .additionalUserInfo.isNewUser) {
                                _isNew.value = true;
                              } else {
                                Navigator.popAndPushNamed(context, '/homepage');
                              }
/*             _student.fullname = _user.displayName;
                _student.uid =  _user.uid;
                _student.profilePic = _user.photoURL; */
                            },
                            child: Image.asset('assets/images/google.png'),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Lottie.asset('assets/lottie/buttom.json'))
          ],
        ));
  }
}
