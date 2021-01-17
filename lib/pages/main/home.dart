import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'package:mis_notas/data/student_dao.dart';
import 'package:mis_notas/data/subject_dao.dart';
import 'package:mis_notas/entities/career.dart';
import 'package:mis_notas/entities/statistics.dart';

import 'package:mis_notas/entities/student.dart';
import 'package:mis_notas/entities/subject.dart';
import 'package:mis_notas/entities/university.dart';
import 'package:mis_notas/pages/dialogs/new_user_dialog.dart';
import 'package:mis_notas/pages/main/options_page.dart';
import 'package:mis_notas/pages/main/profile_page.dart';
import 'package:mis_notas/services/statistics_service.dart';

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
  final controller = PageController(initialPage: 0);
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

  Future<Student> getDataStudent() async {
    User _user = FirebaseAuth.instance.currentUser;
    String _userId = _user.uid;
    var _studentDocRef;
    var _careerDocRef;

    Student _student = new Student(
        _user.displayName,
        _user.photoURL,
        [],
        _userId,
        University([Career('Ingeniería en Sistemas')], 'UTN', 'UTN-FRC'),
        [''],
        '',
        null);

    await _studentDao.getStudentsDocRef(_userId).then((_docRef) {
      _student.studentDocRef = _docRef;
      _studentDocRef = _docRef;
    });

    await _studentDao.getCarrerDocRefs(_studentDocRef).then((_docRef) {
      _student.carrerDocRefs = [_docRef];
      _careerDocRef = _docRef;
    });

    return _student;
  }

  Future<List> getDataStatistics(Student _student) async {
    List _dataList = new List();

    StatisticsService _statisticsService = new StatisticsService();
    SubjectsDao _subjectDao = SubjectsDao();

    List<Subject> _list = await _subjectDao.getAllSubjectsByUser(_student);

    List<Subject> _listCon =
        await _subjectDao.getAllSubjectsWithCondition(_student);

    _dataList.add(await _statisticsService.getAvgNf(_student, _list, -1));
    _dataList
        .add(await _statisticsService.getSubjectsLeft(_student, _list, -1));
    _dataList
        .add(await _statisticsService.getSubjectsPassed(_student, _list, -1));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Promoción Práctica'));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Promoción Teórica'));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Aprobación Directa'));
    _dataList.add(await _statisticsService.getSubjectsCondition(
        _student, _list, -1, 'Regular'));
    _dataList.add(
        await _statisticsService.getAvgNfWithBadGrades(_student, _list, -1));
    _dataList.add(_statisticsService.getProfileStats(_student, _listCon));

    _dataList.add(_statisticsService.getPoints(_student, _list));

    _student.subjects = _list;

    return _dataList;
  }

  Future<List> getData() async {
    Student _student = await getDataStudent();

    List _secondList = await getDataStatistics(_student);

    return [_student, _secondList];
  }

  @override
  Widget build(BuildContext context) {
    Student _student = Provider.of<Student>(context, listen: false);
    ValueNotifier<int> _isPressed =
        Provider.of<ValueNotifier<int>>(context, listen: false);

    ValueNotifier<bool> _isNew = Provider.of<ValueNotifier<bool>>(context);
    if (_isNew.value) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showNewUserDialog(context));
    }

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SmartRefresher(
            header: WaterDropHeader(
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
            child: FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  switch (snapshot.connectionState) {
                    case (ConnectionState.waiting):
                      return Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                                child: Lottie.asset('assets/lottie/clock.json',
                                    width: 300))),
                      );
                    default:
                      //TODO: Esto pasa cuando no hay wifi! Mejorar la estética
                      if (snapshot.hasError) return Text('Error fetching data');

                      _student.fullname = snapshot.data[0].getFullname();
                      _student.profilePic = snapshot.data[0].getProfilePic();
                      _student.subjects = snapshot.data[0].getSubjects();
                      _student.uid = snapshot.data[0].getId();
                      _student.university = snapshot.data[0].getUniversity();
                      _student.carrerDocRefs =
                          snapshot.data[0].getCareerDocRefs();
                      _student.studentDocRef =
                          snapshot.data[0].getStudentDocRef();

                      _studentDao.updateStudent(_student);

                      Statistics _statistics = new Statistics(
                          snapshot.data[1][0],
                          snapshot.data[1][7],
                          snapshot.data[1][1],
                          snapshot.data[1][2],
                          snapshot.data[1][3],
                          snapshot.data[1][4],
                          snapshot.data[1][5],
                          snapshot.data[1][6],
                          snapshot.data[1][8],
                          snapshot.data[1][9]);

                      _student.statistics = _statistics;

                      return PageView(
                        controller: controller,
                        children: [
                          MainPage(),
                          ProfilePage(),
                        ],
                        onPageChanged: (page) {
                          _isPressed.value = page;
                        },
                      );
                  }
                }),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 50,
            color: Colors.white,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
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
                    Consumer<ValueNotifier<int>>(
                      builder: (_, value, __) => Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            curve: Curves.linear,
                            duration: Duration(milliseconds: 80),
                            width: value.value == 0 ? 44 : 0,
                            right: value.value == 0 ? 2 : 25,
                            top: value.value == 0 ? 2 : 8,
                            child: CircleAvatar(
                                radius: 22, backgroundColor: Color(0xff66AAFF)),
                          ),
                          IconButton(
                            icon: !(_isPressed.value == 0)
                                ? Image.asset(buttons['home'][0])
                                : Image.asset(buttons['home'][1]),
                            onPressed: () {
                              if (controller.page != 0)
                                controller.animateToPage(0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                            },
                          ),
                        ],
                      ),
                    ),
                    Consumer<ValueNotifier<int>>(
                      builder: (_, value, __) => Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            curve: Curves.bounceInOut,
                            duration: Duration(milliseconds: 80),
                            width: value.value == 1 ? 44 : 0,
                            right: value.value == 1 ? 2 : 25,
                            top: value.value == 1 ? 2 : 8,
                            child: CircleAvatar(
                                radius: 22, backgroundColor: Color(0xff66AAFF)),
                          ),
                          IconButton(
                            icon: !(_isPressed.value == 1)
                                ? Image.asset(buttons['user'][0])
                                : Image.asset(buttons['user'][1]),
                            onPressed: () {
                              if (controller.page != 1)
                                controller.animateToPage(1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSettings(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return OptionsDialog();
        });
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
