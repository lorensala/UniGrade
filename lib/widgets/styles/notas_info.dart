import 'package:flutter/material.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/widgets/styles/grade_card_style.dart';

class NotasInfo extends StatefulWidget {
  final Subject _subject;

  NotasInfo(this._subject);

  @override
  _NotasInfoState createState() => _NotasInfoState();
}

class _NotasInfoState extends State<NotasInfo> {
  var _selectedType;
  var _nota;
  bool _hasSelectedData;

  var _types = ['Práctico', 'Teórico', 'TP', 'Final'];
  var _notas = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
                  value: _selectedType,
                  hint: new Text('Tipo de Nota'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue;
                      _hasSelectedData = true;
                    });
                  },
                  items: _types
                      .map((type) =>
                          DropdownMenuItem(child: Text(type), value: type))
                      .toList()),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //width: 288.0,
                height: 37.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: const Color(0xfff7f7f7),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _nota,
                        hint: new Text('Nota'),
                        onChanged: (newValue) {
                          setState(() {
                            _nota = newValue;
                            _hasSelectedData = true;
                          });
                        },
                        items: _notas
                            .map((type) => DropdownMenuItem(
                                child: Text(type), value: type))
                            .toList()),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 38.0,
                height: 37.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: const Color(0xffa7ffad),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GradeCard(widget._subject),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
