import 'package:flutter/material.dart';
import 'package:mis_notas/style/materia_style.dart';
import 'package:mis_notas/style/options_button.dart';

class MisMaterias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> names = [
      'Sisitemas\nOperativos',
      'Análisis\nMatemático',
      'Sistemas de\nRepresentación'
    ];

    List<String> assets = [
      'assets/images/037-laptop.png',
      'assets/images/014-math.png',
      'assets/images/002-ruler.png'
    ];

    List<Color> colors = [
      Color(0xffFC8370),
      Color(0xffB3A5EF),
      Color(0xff62DDBD)
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // back arrow
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // back arrow
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        'assets/images/3.0x/backarrow.png',
                        scale: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
                child: Text(
                  'Mis Materias',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 30,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w900,
                    height: 0.9666666666666667,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              // Filtreos
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OptionButton('Cursando'),
                    OptionButton('Aprobadas'),
                    OptionButton('Restantes')
                  ],
                ),
              ),

              // ListView builder
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return MateriaCard(
                        names[index], assets[index], colors[index]);
                  },
                  physics: BouncingScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
