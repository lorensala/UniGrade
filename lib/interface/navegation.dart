import 'package:flutter/material.dart';
import 'package:mis_notas/interface/homepage.dart';
import 'package:mis_notas/interface/profile.dart';
import 'package:mis_notas/interface/statspage.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class Navegation extends StatefulWidget {
  @override
  _NavegationState createState() => _NavegationState();
}

class _NavegationState extends State<Navegation> {
  int _bottomNavIndex=1;
  final List<Widget> _children = [ChartApp(),HomePage() , ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_bottomNavIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 30,
        activeColor: Colors.red[300],
        splashColor: Colors.white,
        backgroundColor: Colors.grey[100],
        icons: <IconData>[
          Icons.favorite,
          Icons.book,
          Icons.person,
        ],
        activeIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        notchSmoothness: NotchSmoothness.defaultEdge,
        //other params
      ),
    );
  }




}
