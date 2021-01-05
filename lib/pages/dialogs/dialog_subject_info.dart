import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialogSubjectInfo extends StatelessWidget {
  final Map<String, dynamic> _map;

  DialogSubjectInfo(this._map);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Container(
          //width: 700,
          height: 530,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(26)),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 250,
                child: Text(
                  _map.isNotEmpty ? _map['name'] : 'No data',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 25,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'CORRELATIVAS',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 20,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.string(
                '<svg viewBox="60.0 296.5 255.5 1.0" ><path transform="translate(60.0, 296.5)" d="M 0 0 L 255.5 0" fill="none" stroke="#66aaff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Para cursar',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 18,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Cursada:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 18,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 305.0,
                height: 100,
                child: Text(
                  _map.isNotEmpty
                      ? textFormatter(_map['cursada'].toString())
                      : 'No data',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 15,
                    color: const Color(0xff8d8d8d),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Aprobada:',
                      style: TextStyle(
                        fontFamily: 'Avenir LT Std',
                        fontSize: 18,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 310.0,
                height: 100,
                child: Text(
                  _map.isNotEmpty
                      ? textFormatter(_map['aprobada'].toString())
                      : 'No data',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 15,
                    color: const Color(0xff8d8d8d),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Para rendir',
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 18,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 305.0,
                height: 70,
                child: Text(
                  _map.isNotEmpty
                      ? textFormatter(_map['rendir'].toString())
                      : 'No data',
                  style: TextStyle(
                    fontFamily: 'Avenir LT Std',
                    fontSize: 15,
                    color: const Color(0xff8d8d8d),
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 131.0,
                      height: 37.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26.0),
                        color: const Color(0xffFF9A9A),
                      ),
                      child: Center(
                        child: Text(
                          'Salir',
                          style: TextStyle(
                            fontFamily: 'Avenir LT Std',
                            fontSize: 16,
                            color: const Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String textFormatter(String text) {
    List<String> _list = text.split(',');

    String res = '';

    if (_list[0] == '[]') return 'No posee';
    if (_list[0] == '[TODAS]') return 'TODAS';
    if (_list.length == 1) return _list[0].substring(1, _list[0].length - 1);

    _list.forEach((element) {
      if (element.startsWith('['))
        res += element.substring(1) + ' - ';
      else if (element.endsWith(']'))
        res += element.replaceAll(']', '');
      else
        res += element + ' - ';
    });

    return res;
  }
}
