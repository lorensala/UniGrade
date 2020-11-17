import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mis_notas/animation/FadeAnimation.dart';
import 'package:mis_notas/themes/buttonStyle.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var _bottomNavIndex = 0;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroundgreen.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Center(
                child: FadeAnimation(.6,CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.blue,
                    backgroundImage:
                        AssetImage('assets/images/011-director.png')),
              )),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
                child: FadeAnimation(.6,Text(
                  'Manuel Cesar',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ))),
            SizedBox(height: 20,),
            FadeAnimation(.6,Lottie.asset('assets/lottie/34490-book-animation.json',
                height: 140, repeat: false)),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(.6,
                                      ButtonProfile(
                      name: 'Mis estadisticas',
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeAnimation(.6,ButtonProfile(
                    name: 'Mi progreso',
                  )),
                  SizedBox(height: 10),
                  FadeAnimation(.6,ButtonProfile(
                    name: 'Ajustes del perfil',
                  )),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: Colors.grey,
          backgroundColor: Colors.grey[100],
          icons: <IconData>[
            Icons.home,
            Icons.book,
            Icons.person,
          ],
          activeIndex: _bottomNavIndex,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          notchSmoothness: NotchSmoothness.defaultEdge,
          //other params
        ),
      ),
    );
  }
}
