import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mis_notas/data/student_dao.dart';
import 'package:mis_notas/entities/career.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';
import 'package:mis_notas/services/statistics.dart';

import 'package:mis_notas/support/text_formatter.dart';

import 'package:mis_notas/widgets/colors.dart';
import 'package:mis_notas/widgets/dialog_nuevamateria.dart';
import 'package:mis_notas/widgets/dialog_nuevanota.dart';
import 'package:mis_notas/widgets/main_button.dart';
import 'package:mis_notas/widgets/quick_bar.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  var _studentDao = new StudentDao();

  List<Subject> _listSubj = [];

  Future<List> getData() async {
    User _user = FirebaseAuth.instance.currentUser;
    String _userId = _user.uid;

    var _studentDocRef = await _studentDao.getStudentsDocRef(_userId);
    var _careerDocRef = await _studentDao.getCarrerDocRefs(_studentDocRef);

    List _list = [
      _user.displayName,
      _user.photoURL,
      [],
      _userId,
      University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'),
      [_careerDocRef],
      _studentDocRef
    ];

    return _list;
  }

  final Map<String, List<String>> buttons = {
    'info': ['assets/images/info.png', 'assets/images/info_white.png'],
    'home': ['assets/images/home.png', 'assets/images/home_white.png'],
    'user': ['assets/images/user.png', 'assets/images/user_white.png']
  };

  @override
  Widget build(BuildContext context) {
    var _student = Provider.of<Student>(context, listen: false);

    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case (ConnectionState.waiting):
            return Center(
              child: Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator())),
            );
          default:
            if (snapshot.hasError)
              return Text('error');
            else
              _student.fullname = snapshot.data[0];
            _student.profilePic = snapshot.data[1];
            _student.subjects = _listSubj;
            _student.uid = snapshot.data[3];
            _student.university = snapshot.data[4];
            _student.carrerDocRefs = snapshot.data[5];
            _student.studentDocRef = snapshot.data[6];

            print(_student.getCareerDocRefs()[0]);

            _studentDao.updateStudent(_student);

            return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Hamburger icon and setting icon.
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset('assets/images/hamburger.png'),
                                InkWell(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.popAndPushNamed(
                                        context, '/login');
                                  },
                                  child: SvgPicture.string(
                                    '<svg viewBox="324.0 38.0 27.0 27.0" ><path transform="translate(319.5, 33.49)" d="M 29.27109336853027 18 C 29.27109336853027 16.5234375 30.19218635559082 15.26484394073486 31.5 14.75859355926514 C 31.15546798706055 13.31718730926514 30.5859375 11.96718788146973 29.83359336853027 10.74374961853027 C 29.38359260559082 10.94062423706055 28.90546798706055 11.04609298706055 28.42031288146973 11.04609298706055 C 27.53437614440918 11.04609298706055 26.6484375 10.70859336853027 25.96640586853027 10.03359317779541 C 24.91874885559082 8.985937118530273 24.68671798706055 7.446093082427979 25.24921798706055 6.16640567779541 C 24.03281211853027 5.4140625 22.67578125 4.844531059265137 21.24140548706055 4.5 C 20.7421875 5.80078125 19.4765625 6.728906154632568 18 6.728906154632568 C 16.5234375 6.728906154632568 15.2578125 5.80078125 14.75859355926514 4.5 C 13.31718730926514 4.844531059265137 11.96718788146973 5.4140625 10.74374961853027 6.166406154632568 C 11.31328105926514 7.439062118530273 11.07421875 8.985937118530273 10.02656173706055 10.03359413146973 C 9.351561546325684 10.70859432220459 8.458593368530273 11.04609394073486 7.57265567779541 11.04609394073486 C 7.087499618530273 11.04609394073486 6.609374523162842 10.94765663146973 6.159374237060547 10.74375057220459 C 5.4140625 11.97421836853027 4.844531059265137 13.32421875 4.5 14.765625 C 5.80078125 15.26484394073486 6.728906154632568 16.5234375 6.728906154632568 18.00703048706055 C 6.728906154632568 19.48359298706055 5.807812213897705 20.7421875 4.507031440734863 21.24843597412109 C 4.8515625 22.68984222412109 5.421093940734863 24.03984260559082 6.173437595367432 25.26327896118164 C 6.623437404632568 25.06640434265137 7.1015625 24.96796607971191 7.579687595367432 24.96796607971191 C 8.465624809265137 24.96796607971191 9.3515625 25.30546569824219 10.03359413146973 25.98046684265137 C 11.07421875 27.02109146118164 11.31328201293945 28.56796646118164 10.75078201293945 29.84062385559082 C 11.97421932220459 30.59296798706055 13.33125114440918 31.16249847412109 14.76562595367432 31.50703048706055 C 15.26484489440918 30.20624923706055 16.5234375 29.28515625 18 29.28515625 C 19.4765625 29.28515625 20.73515701293945 30.20624923706055 21.234375 31.50703048706055 C 22.67578125 31.16249847412109 24.02578163146973 30.59296798706055 25.24921798706055 29.84062385559082 C 24.68671798706055 28.56796836853027 24.92578125 27.02812385559082 25.96640586853027 25.98046684265137 C 26.64140510559082 25.30546760559082 27.52734375 24.96796607971191 28.42031288146973 24.96796607971191 C 28.8984375 24.96796607971191 29.38359451293945 25.06640434265137 29.82656288146973 25.26327896118164 C 30.57890701293945 24.03984069824219 31.1484375 22.68280982971191 31.49296951293945 21.24843597412109 C 30.19921875 20.7421875 29.27109336853027 19.48359298706055 29.27109336853027 18 Z M 18.06328201293945 23.61796951293945 C 14.94843864440918 23.61796951293945 12.43828201293945 21.09375 12.43828201293945 17.99296951293945 C 12.43828201293945 14.89218807220459 14.94843864440918 12.36796951293945 18.06328201293945 12.36796951293945 C 21.17812538146973 12.36796951293945 23.68828201293945 14.89218807220459 23.68828201293945 17.99296951293945 C 23.68828201293945 21.09375 21.17812538146973 23.61796951293945 18.06328201293945 23.61796951293945 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  formatText(_student.getFullname()),
                                  style: TextStyle(
                                    fontFamily: 'Avenir LT Std',
                                    fontSize: 30,
                                    color: textColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Hero(
                                  tag: 'profilePic',
                                  child: Container(
                                    width: 120.0,
                                    height: 118.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            _student.getProfilePic()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/line.png',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Name, avatar, university text and carreer.
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _student
                                      .getUniversity()
                                      .getCareers()[0]
                                      .getName(),
                                  style: TextStyle(
                                    fontFamily: 'Avenir LT Std',
                                    fontSize: 18,
                                    color: textColor2,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  _student.getUniversity().getShortName(),
                                  style: TextStyle(
                                    fontFamily: 'Avenir LT Std',
                                    fontSize: 14,
                                    color: const Color(0xff9a9a9a),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: QuickBar(
                            prom: 8.54,
                            aprobadas: 25,
                            restantes: 43,
                          )),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Text(
                              'Información',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 22,
                                color: const Color(0xff484848),
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          // Listview
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                            child: Container(
                              height: 130,
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  MainButton(
                                      'Mis\nMaterias',
                                      'assets/images/005-books.png',
                                      Color(0xFFF7F7F7),
                                      '/mismaterias'),
                                  MainButton(
                                      'Mis\nNotas',
                                      'assets/images/001-test.png',
                                      Color(0xFFFFDCDC),
                                      '/misnotas'),
                                  MainButton(
                                      'Mis\nEstadísticas',
                                      'assets/images/030-cup.png',
                                      Color(0xFFF5DCFF),
                                      '/estadisticas')
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Text(
                              'Funciones Rápidas',
                              style: TextStyle(
                                fontFamily: 'Avenir LT Std',
                                fontSize: 22,
                                color: const Color(0xff484848),
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          // Funciones rapidas
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                            child: Row(children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(26),
                                onTap: () {
                                  //student.addPromedio();
                                  showNuevaNota(context, _student);
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'Nueva Nota',
                                      style: TextStyle(
                                        fontFamily: 'Avenir LT Std',
                                        fontSize: 14,
                                        color: const Color(0xff7c7979),
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  width: 129.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26.0),
                                    color: const Color(0xfff0f0f0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(26),
                                onTap: () {
                                  showNuevaMateria(context, _student);
                                },
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'Nueva Materia',
                                      style: TextStyle(
                                        fontFamily: 'Avenir LT Std',
                                        fontSize: 14,
                                        color: const Color(0xff7c7979),
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  width: 129.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26.0),
                                    color: const Color(0xffffdcdc),
                                  ),
                                ),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  elevation: 0,
                  child: Container(
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Positioned(
                              right: 4,
                              top: 4,
                              child: CircleAvatar(backgroundColor: white),
                            ),
                            IconButton(
                              icon: Image.asset(buttons['info'][0]),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Positioned(
                              right: 4,
                              top: 4,
                              child: CircleAvatar(
                                backgroundColor: white,
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(buttons['home'][0]),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Positioned(
                              right: 4,
                              top: 4,
                              child: CircleAvatar(
                                backgroundColor: white,
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(buttons['user'][0]),
                              onPressed: () => {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
        }
      },
    );
  }

  void showNuevaNota(BuildContext context, Student _student) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return DialogNuevaNota(_student);
        });
  }

  void showNuevaMateria(BuildContext context, Student _student) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return DialogNuevaMateria(_student);
      },
    );
  }
}
