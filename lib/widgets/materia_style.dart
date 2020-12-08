import 'package:flutter/material.dart';

class MateriaCard extends StatelessWidget {
  final String name;
  final String asset;
  final Color color;

  MateriaCard(this.name, this.asset, this.color);

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
                color: color,
              ),
              child: Text(
                name,
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
                child: Image.asset(asset),
                radius: 43.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
