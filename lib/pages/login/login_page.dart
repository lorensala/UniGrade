import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/services/sing_in.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Lottie.asset('assets/lottie/top.json'),
        Column(
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
          ],
        ),
        SizedBox(
          height: 100,
        ),
        Consumer<Student>(builder: (context, _student, child) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              await signInWithGoogle().then((_googleUser) async {
                var user = _googleUser.user;
                _student.fullname = user.displayName;
                _student.uid = await user.getIdToken();
                _student.profilePic = user.photoURL;

                Navigator.popAndPushNamed(context, '/homepage');
              });
            },
            child: Image.asset('assets/images/google.png'),
          );
        }),
        Lottie.asset('assets/lottie/buttom.json')
      ],
    ));
  }
}
