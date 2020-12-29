import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:mis_notas/pages/login/main_login.dart';
import 'package:mis_notas/pages/login/new_user_login.dart';

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
            //TODO: Por alguna razon, al hacer para atras muestra
            // lo que no tiene que mostrar
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
