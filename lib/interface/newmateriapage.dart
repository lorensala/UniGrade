import 'package:flutter/material.dart';
import 'package:mis_notas/animation/FadeAnimation.dart';
import 'package:mis_notas/themes/listStyle.dart';

class NewMateria extends StatefulWidget {
  @override
  _NewMateriaState createState() => _NewMateriaState();
}

var listaMateras = [
      'Química',
      'Álgebra',
      'Química',
      'Análisis',
      'Análisis 2',
      'Matematica',
      '',
      '',
      ''
    ];

    var listView = new ListView.builder(
        itemCount: listaMateras.length,
        itemBuilder: (BuildContext context, int index) {
          return FadeAnimation(
              .3,
              ListTile(
                title: new Lista(name: listaMateras[index]),
                onTap: () {},
              ));
        });




class _NewMateriaState extends State<NewMateria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
              'Nueva Materia',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
              ),
              
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Text(
              'Seleccione una materia:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[500]),
            ),
              ),
              
            ],
          ),
          Expanded(child: listView)
        ],
      ),
    );
  }
}
