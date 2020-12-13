import 'package:flutter/material.dart';
import 'package:mis_notas/business/subject.dart';

class MateriaCard extends StatelessWidget {
  /* This widgets represents the subejct's bar styles, each one with it's
  color, name, and icon asset.
  
  [subject] uses a Subject objet to get it's properties and set the values
  to the widget.

   */

  final Subject _subject;

  MateriaCard(this._subject);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
      child: Stack(
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.fromLTRB(21, 15, 0, 15),
              height: 79.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
                color: Color(_subject.getColor()),
              ),
              child: Text(
                _subject.getName(),
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 25,
                  color: const Color(0xffffffff),
                  height: 1.04,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
          Align(
            alignment: Alignment(0.80, 0.00),
            child: Card(
              color: Colors.transparent,
              elevation: 16,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(_subject.getIcon()),
                radius: 43.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
