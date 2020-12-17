import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/services/sing_in.dart';
import 'package:mis_notas/widgets/main_login.dart';
import 'package:mis_notas/widgets/new_user_login.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _isNew = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: Lottie.asset('assets/lottie/top.json')),
            !_isNew.value ? MainLogin() : NewUserLogin(),
            Align(
                alignment: Alignment.bottomLeft,
                child: Lottie.asset('assets/lottie/buttom.json'))
          ],
        ));
  }
}
