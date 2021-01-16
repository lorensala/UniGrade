import 'package:flutter/material.dart';
import 'package:mis_notas/entities/state.dart';
import 'package:mis_notas/entities/state_record.dart';

import 'package:mis_notas/entities/subject.dart';

class DialogActualizarMateria extends StatefulWidget {
  final Subject _subject;

  DialogActualizarMateria(this._subject);
  @override
  _DialogActualizarMateriaState createState() =>
      _DialogActualizarMateriaState();
}

class _DialogActualizarMateriaState extends State<DialogActualizarMateria> {
  bool _hasSelectedData = true;
  bool _isEmpty = false;

  List<String> _conditions = [
    'Regular',
    'Promoción Teórica',
    'Promoción Práctica',
    'Aprobación Directa',
  ];
  List<String> _conditionsEmpty = ['Libre', 'Abandonada', 'Aprobación Directa'];
  String _selectedCondition;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
        child: Container(
          width: 338.0,
          height: 150.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 288.0,
                  height: 37.0,
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(26.0),
                    color: const Color(0xfff7f7f7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _selectedCondition,
                        hint: new Text('Condicion'),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCondition = newValue;
                            _hasSelectedData = true;
                          });
                        },
                        items: _isEmpty
                            ? _conditionsEmpty
                                .map((String action) => DropdownMenuItem(
                                    value: action, child: Text(action)))
                                .toList()
                            : _conditions
                                .map((String action) => DropdownMenuItem(
                                    value: action, child: Text(action)))
                                .toList(),
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
                      onTap: () async {
                        widget._subject.state = StateRecord(
                            StateSubject(_selectedCondition), DateTime.now());
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
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !_hasSelectedData,
                  child: Center(
                    child: Text(
                      '¡No se seleccionaron datos!',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  //});
}
