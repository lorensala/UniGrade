import 'package:flutter/material.dart';

class ButtonProfile extends StatelessWidget {
  final String name;

  const ButtonProfile({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                  spreadRadius: 2.0)
            ]),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Center(
                  child: Text(name,
                      style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                )),
              ],
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
