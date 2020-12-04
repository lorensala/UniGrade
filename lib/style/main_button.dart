import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: InkWell(
              borderRadius: BorderRadius.circular(26),
              onTap: () {
                Navigator.pushNamed(context, '/mismaterias');
              },
              child: Container(
                width: 129.0,
                height: 92.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  color: const Color(0xfff0f0f0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(17, 40, 0, 0),
                  child: Text(
                    'Mis\nMaterias',
                    style: TextStyle(
                      fontFamily: 'Avenir LT Std',
                      fontSize: 18,
                      color: const Color(0xff484848),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 63,
          child: Image.asset(
            'assets/images/005-books.png',
            width: 54.0,
            height: 54.0,
          ),
        )
      ],
    );
  }
}
