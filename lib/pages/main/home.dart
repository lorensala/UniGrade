import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:mis_notas/pages/main/options_page.dart';
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
  var isPressedSettings = false;
  final Map<String, List<String>> buttons = {
    'settings': [
      'assets/images/settings.png',
      'assets/images/settings_white.png'
    ],
    'home': ['assets/images/home.png', 'assets/images/home_white.png'],
    'user': ['assets/images/user.png', 'assets/images/user_white.png'],
    'info': ['assets/images/info.png']
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
            confirmBtnColor: Color(0xFF66AAFF),
            backgroundColor: Colors.white,
            context: context,
            type: CoolAlertType.confirm,
            title: "¿Estas seguro que quieres salir?",
            confirmBtnText: "Si",
            cancelBtnText: "No",
          );
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
                            //Image.asset('assets/images/hamburger.png'),
                            InkWell(
                                onTap: () {
                                  showNewUserDialog(context);
                                },
                                child: Image.asset('assets/images/info.png')),
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

                                if (page == 0) return MainPage();
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
                        child: CircleAvatar(
                          backgroundColor:
                              isPressedSettings ? Colors.blue : Colors.white,
                        ),
                      ),
                      IconButton(
                          icon: !isPressedSettings
                              ? Image.asset(buttons['settings'][0])
                              : Image.asset(buttons['settings'][1]),
                          onPressed: () {
                            showSettings(context);
                          }
                          //{showNewUserDialog(context)},
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
                              isPressedSettings = false;
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
                              isPressedSettings = false;
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

  showSettings(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return OptionsDialog();
        });
  }
}
