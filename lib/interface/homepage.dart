import 'package:flutter/material.dart';
import 'package:mis_notas/animation/FadeAnimation.dart';
import 'package:mis_notas/themes/listStyle.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _bottomNavIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    var listaMateras = [
      'Química',
      'Álgebra',
      'Química',
      'Análisis',
      'Análisis 2',
      'Matematica',
      //'',
      //'',
      //''
    ];

    var listView = new ListView.builder(
        itemCount: listaMateras.length,
        itemBuilder: (BuildContext context, int index) {
          return FadeAnimation(
              1.5,
              ListTile(
                title: new Lista(name: listaMateras[index]),
                onTap: () {},
              ));
        });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              'Mis Materias',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
            child: Text(
              'Las materias son de leche.',
              style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: listView,
          )
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: Colors.grey,
        backgroundColor: Colors.grey[100],
        icons: <IconData>[
          Icons.brightness_4,
          Icons.brightness_6,
          Icons.brightness_7,
        ],
        activeIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        notchSmoothness: NotchSmoothness.defaultEdge,
        //other params
      ),
      
    );
  }
}
