import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mis_notas/entities/statistics.dart';
import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/widgets/components/profile_stats.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context);
    Statistics _statistics = Provider.of<Statistics>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 170.0,
                height: 168.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  image: DecorationImage(
                    image: NetworkImage(_student.getProfilePic()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _student.getFullname(),
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 32,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w800,
                  height: 0.9666666666666667,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.string(
                '<svg viewBox="105.5 313.5 163.5 1.0" ><path transform="translate(105.5, 313.5)" d="M 0 0 L 163.5 0" fill="none" stroke="#66aaff" stroke-width="4" stroke-miterlimit="4" stroke-linecap="round" /></svg>',
                allowDrawingOutsideViewBox: true,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _student.getCarrerName(),
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 20,
                  color: const Color(0xff484848),
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _student.getUniversityShortName(),
                style: TextStyle(
                  fontFamily: 'Avenir LT Std',
                  fontSize: 16,
                  color: const Color(0xff9a9a9a),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 24, 0),
                child: ProfileStat('Programador', 'assets/images/software.png',
                    (_statistics.getProf()[0] * 10).toDouble()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 24, 0),
                child: ProfileStat(
                    'Calculador y Lógico',
                    'assets/images/matematica.png',
                    (_statistics.getProf()[1] * 10).toDouble()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 24, 0),
                child: ProfileStat('Analista', 'assets/images/analista.png',
                    (_statistics.getProf()[2] * 10).toDouble()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
