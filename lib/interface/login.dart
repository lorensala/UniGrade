import 'package:flutter/material.dart';
import 'package:mis_notas/animation/FadeAnimation.dart';
import 'package:mis_notas/themes/textInput.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill),
          ),
          child: Column(
            children: <Widget>[
              FadeAnimation(
                  1,
                  Container(
                    height: 400,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(73, 122, 246, .1),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              TextInputStyle(
                                name: 'Usuario',
                              ),
                              TextInputStyle(name: 'Contraseña',)
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1,
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/nav');
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(255, 135, 135, 1),
                                    Color.fromRGBO(73, 122, 246, .6),
                                  ])),
                              child: Center(
                                child: Text(
                                  'Iniciar Sesion',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              )),
                        )),
                    FadeAnimation(
                        1,
                        SizedBox(
                          height: 58,
                          child: Center(
                            child: Text(
                              "¿Olvidaste al contraseña?",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
