import 'package:flutter/material.dart';
import 'package:mis_notas/business/subject.dart';
import 'package:mis_notas/data/datamanager.dart';

class DialogNuevaMateria extends StatelessWidget {
  final db = DataManager();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
        child: Container(
          width: 338.0,
          height: 250.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nueva Materia',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 22,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 288.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.0),
                    color: const Color(0xfff7f7f7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: new Text('Materia'),
                        onChanged: (value) => context,
                        items: [
                          new DropdownMenuItem(child: new Text("Abc")),
                          new DropdownMenuItem(child: new Text("Xyz")),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 288.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.0),
                    color: const Color(0xfff7f7f7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: new Text('Materia'),
                        onChanged: (value) => context,
                        items: [
                          new DropdownMenuItem(child: new Text("Abc")),
                          new DropdownMenuItem(child: new Text("Xyz")),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {
                        db.addNota(7);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 129.0,
                        height: 37.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          color: const Color(0xffA7FFAD),
                        ),
                        child: Center(
                          child: Text(
                            'Confirmar',
                            style: TextStyle(
                              fontFamily: 'Avenir LT Std',
                              fontSize: 16,
                              color: const Color(0xff000000),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
