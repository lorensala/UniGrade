import 'package:flutter/material.dart';
import 'package:mis_notas/animation/FadeAnimation.dart';
import 'package:mis_notas/interface/newMateriapage.dart';
import 'package:mis_notas/themes/listStyle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var listaMateras = [
      'Química',
      'Álgebra',
      'Matematica',
    ];

    var colors1 = [Color(0xffF0DA4B), Color(0xfff6072f), Color(0xff184e68)];
    var colors2 = [Color(0xffff005e), Color(0xfff200a1), Color(0xff57ca85)];

    var listaAssets = [
      'assets/images/006-chemistry.png',
      'assets/images/008-paper.png',
      'assets/images/014-math.png'
    ];

    var listView = new ListView.builder(
        itemCount: listaMateras.length,
        itemBuilder: (BuildContext context, int index) {
          return FadeAnimation(
              .3,
              ListTile(
                title: new Lista(
                  name: listaMateras[index],
                  asset: listaAssets[index],
                  color1: colors1[index],
                  color2: colors2[index],
                ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: FlatButton(
              color: Colors.white,
              padding: const EdgeInsets.all(0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(19)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewMateria()));
              },
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200],
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                          spreadRadius: 2.0),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                child: Center(
                    child: Text(
                  'Añadir Nueva Materia',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          Expanded(
            child: listView,
          ),
        ],
      ),
    );
  }
}
