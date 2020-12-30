import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mis_notas/data/student_dao.dart';
import 'package:mis_notas/entities/career.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';
import 'package:mis_notas/pages/dialogs/new_user_dialog.dart';
import 'package:mis_notas/pages/main/profile_page.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'main_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool isLoading = true;
  var _studentDao = new StudentDao();
  int page = 0;
  List<Subject> _listSubj = [];
  var isPressedHome = true;
  var isPressedProfile = false;
  final Map<String, List<String>> buttons = {
    'info': ['assets/images/info.png', 'assets/images/info_white.png'],
    'home': ['assets/images/home.png', 'assets/images/home_white.png'],
    'user': ['assets/images/user.png', 'assets/images/user_white.png']
  };

  Future<List> getDataStudent() async {
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

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context, listen: false);
    ValueNotifier<bool> _isNew = Provider.of<ValueNotifier<bool>>(context);
    if (_isNew.value) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showNewUserDialog(context));
    }

    return WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          CoolAlert.show(
              onConfirmBtnTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              backgroundColor: Colors.white,
              context: context,
              type: CoolAlertType.confirm,
              title: "¿Estas seguro que quieres salir?",
              confirmBtnText: "Si",
              cancelBtnText: "No",
              confirmBtnColor: Colors.green);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SmartRefresher(
            header: WaterDropHeader(
              complete: Text(''),
              waterDropColor: Color(0xFF66AAFF),
            ),
            controller: _refreshController,
            onRefresh: () {
              setState(() {});
              _refreshController.refreshCompleted();
            },
            onLoading: () {
              setState(() {});
              _refreshController.loadComplete();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset('assets/images/hamburger.png'),
                            InkWell(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.popAndPushNamed(context, '/login');
                              },
                              child: SvgPicture.string(
                                '<svg viewBox="324.0 38.0 27.0 27.0" ><path transform="translate(319.5, 33.49)" d="M 29.27109336853027 18 C 29.27109336853027 16.5234375 30.19218635559082 15.26484394073486 31.5 14.75859355926514 C 31.15546798706055 13.31718730926514 30.5859375 11.96718788146973 29.83359336853027 10.74374961853027 C 29.38359260559082 10.94062423706055 28.90546798706055 11.04609298706055 28.42031288146973 11.04609298706055 C 27.53437614440918 11.04609298706055 26.6484375 10.70859336853027 25.96640586853027 10.03359317779541 C 24.91874885559082 8.985937118530273 24.68671798706055 7.446093082427979 25.24921798706055 6.16640567779541 C 24.03281211853027 5.4140625 22.67578125 4.844531059265137 21.24140548706055 4.5 C 20.7421875 5.80078125 19.4765625 6.728906154632568 18 6.728906154632568 C 16.5234375 6.728906154632568 15.2578125 5.80078125 14.75859355926514 4.5 C 13.31718730926514 4.844531059265137 11.96718788146973 5.4140625 10.74374961853027 6.166406154632568 C 11.31328105926514 7.439062118530273 11.07421875 8.985937118530273 10.02656173706055 10.03359413146973 C 9.351561546325684 10.70859432220459 8.458593368530273 11.04609394073486 7.57265567779541 11.04609394073486 C 7.087499618530273 11.04609394073486 6.609374523162842 10.94765663146973 6.159374237060547 10.74375057220459 C 5.4140625 11.97421836853027 4.844531059265137 13.32421875 4.5 14.765625 C 5.80078125 15.26484394073486 6.728906154632568 16.5234375 6.728906154632568 18.00703048706055 C 6.728906154632568 19.48359298706055 5.807812213897705 20.7421875 4.507031440734863 21.24843597412109 C 4.8515625 22.68984222412109 5.421093940734863 24.03984260559082 6.173437595367432 25.26327896118164 C 6.623437404632568 25.06640434265137 7.1015625 24.96796607971191 7.579687595367432 24.96796607971191 C 8.465624809265137 24.96796607971191 9.3515625 25.30546569824219 10.03359413146973 25.98046684265137 C 11.07421875 27.02109146118164 11.31328201293945 28.56796646118164 10.75078201293945 29.84062385559082 C 11.97421932220459 30.59296798706055 13.33125114440918 31.16249847412109 14.76562595367432 31.50703048706055 C 15.26484489440918 30.20624923706055 16.5234375 29.28515625 18 29.28515625 C 19.4765625 29.28515625 20.73515701293945 30.20624923706055 21.234375 31.50703048706055 C 22.67578125 31.16249847412109 24.02578163146973 30.59296798706055 25.24921798706055 29.84062385559082 C 24.68671798706055 28.56796836853027 24.92578125 27.02812385559082 25.96640586853027 25.98046684265137 C 26.64140510559082 25.30546760559082 27.52734375 24.96796607971191 28.42031288146973 24.96796607971191 C 28.8984375 24.96796607971191 29.38359451293945 25.06640434265137 29.82656288146973 25.26327896118164 C 30.57890701293945 24.03984069824219 31.1484375 22.68280982971191 31.49296951293945 21.24843597412109 C 30.19921875 20.7421875 29.27109336853027 19.48359298706055 29.27109336853027 18 Z M 18.06328201293945 23.61796951293945 C 14.94843864440918 23.61796951293945 12.43828201293945 21.09375 12.43828201293945 17.99296951293945 C 12.43828201293945 14.89218807220459 14.94843864440918 12.36796951293945 18.06328201293945 12.36796951293945 C 21.17812538146973 12.36796951293945 23.68828201293945 14.89218807220459 23.68828201293945 17.99296951293945 C 23.68828201293945 21.09375 21.17812538146973 23.61796951293945 18.06328201293945 23.61796951293945 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                allowDrawingOutsideViewBox: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: getDataStudent(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case (ConnectionState.waiting):
                                return Center(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Center(
                                          child: CircularProgressIndicator())),
                                );
                              default:
                                if (snapshot.hasError) return Text('error');

                                _student.fullname = snapshot.data[0];
                                _student.profilePic = snapshot.data[1];
                                _student.subjects = _listSubj;
                                _student.uid = snapshot.data[3];
                                _student.university = snapshot.data[4];
                                _student.carrerDocRefs = snapshot.data[5];
                                _student.studentDocRef = snapshot.data[6];

                                _studentDao.updateStudent(_student);

                                if (page == 0)
                                  return MainPage();
                                else
                                  return ProfilePage();
                            }
                          }),
                    ],
                  ),
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
                        child: CircleAvatar(backgroundColor: Colors.white),
                      ),
                      IconButton(
                        icon: Image.asset(buttons['info'][0]),
                        onPressed: () => {showNewUserDialog(context)},
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        right: 4,
                        top: 4,
                        child: CircleAvatar(
                          backgroundColor:
                              isPressedHome ? Colors.blue : Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: !isPressedHome
                            ? Image.asset(buttons['home'][0])
                            : Image.asset(buttons['home'][1]),
                        onPressed: () {
                          if (page != 0)
                            setState(() {
                              page = 0;
                              isPressedHome = true;
                              isPressedProfile = false;
                            });
                        },
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned(
                        right: 4,
                        top: 4,
                        child: CircleAvatar(
                          backgroundColor:
                              isPressedProfile ? Colors.blue : Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: !isPressedProfile
                            ? Image.asset(buttons['user'][0])
                            : Image.asset(buttons['user'][1]),
                        onPressed: () {
                          if (page != 1)
                            setState(() {
                              page = 1;
                              isPressedHome = false;
                              isPressedProfile = true;
                            });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  showNewUserDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return NewUserDialog();
        });
  }
}
