import 'package:flutter/material.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/services/sing_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class MainLogin extends StatefulWidget {
  @override
  _MainLoginState createState() => _MainLoginState();
}

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
            Hero(
              tag: 'uniGrade_text',
              child: Text(
                'UniGrade',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 50,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
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
                      _isPressed = true;
                      UserCredential _userCredentials =
                          await signInWithGoogle();

                      if (!_userCredentials.additionalUserInfo.isNewUser) {
                        _isNew.value = true;
                      } else {
                        Navigator.popAndPushNamed(context, '/homepage');
                      }
                    },
                    child: Image.asset('assets/images/google.png'),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
