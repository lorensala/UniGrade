import 'package:flutter/material.dart';

class Lista extends StatelessWidget {
  final String name;
  const Lista({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var colors = [Colors.red, Colors.blue, Colors.white, Colors.green];
    //final random = new Random();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 100,
        padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 10),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'La quimica no sirve para \nni mierda la verdad.',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              child: Image(
                image: AssetImage('assets/images/006-chemistry.png'),
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 135, 135, 1),
              Color.fromRGBO(73, 122, 246, 1),
            ]),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 20.0,
                  offset: Offset(0, 10))
            ]),
      ),
    );
  }
}
