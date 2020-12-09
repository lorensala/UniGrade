import 'package:flutter/material.dart';
import 'package:mis_notas/business/subject.dart';
import 'package:mis_notas/data/datamanager.dart';
import 'package:mis_notas/widgets/notas_style.dart';
import 'package:mis_notas/widgets/options_button.dart';
import 'package:mis_notas/widgets/search_bar.dart';

//TODO: Agregar la barra de busqueda.

class MisNotas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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

                  // Mis Notas y boton ayuda
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
                    child: Text(
                      'Mis Notas',
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: SearchBar(null),
                  ),
                  // Filtros
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          //alignment: WrapAlignment.spaceAround,
                          children: <Widget>[
                            OptionButton('Cursando', null),
                            OptionButton('Aprobadas', null),
                            OptionButton('Libre', null),
                            OptionButton('Promoción', null),
                            OptionButton('Ap. Directa', null),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return NotaCard();
                      },
                    ),
                  )
                ],
              )),
        ));
  }
}
