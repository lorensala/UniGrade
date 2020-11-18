import 'package:flutter/material.dart';
import 'package:mis_notas/animation/FadeAnimation.dart';
import 'package:mis_notas/themes/buttonStyle.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.biggest.height,
          width: constraints.biggest.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(110, 226, 245, 1),
              Color.fromRGBO(100, 84, 240, 1),
            ], begin: Alignment.bottomCenter),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                      child: FadeAnimation(
                    .1,
                    CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.blue,
                        backgroundImage:
                            AssetImage('assets/images/011-director.png')),
                  )),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
                    child: FadeAnimation(
                        .1,
                        Text(
                          'Manuel Cesar',
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "UTN-FRC",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 330,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(90))),
                  child: Column(
                    children: <Widget>[
                      Lottie.asset('assets/lottie/34490-book-animation.json',
                          height: 140, repeat: false),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FadeAnimation(
                              .1,
                              ButtonProfile(
                                name: 'Mis estadisticas',
                              ),
                            ),
                            SizedBox(width: 10),
                            FadeAnimation(
                                .1,
                                ButtonProfile(
                                  name: 'Mi progreso',
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
