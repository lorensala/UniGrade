import 'package:http/http.dart' as http;

class Sesion {
  final _dominios = [
    "cbasicas",
    "civil",
    "computos",
    "decanato",
    "egresado",
    "electrica",
    "electronica",
    "extension",
    "industrial",
    "mecanica",
    "metalurgica",
    "org",
    "posgrado",
    "punilla",
    "quimica",
    "radio",
    "sa",
    "sae",
    "scdt",
    "sistemas",
    "tecnicatura",
    "virtual",
    "frc"
  ];

  String legajo;
  String password;
  String dominio;
  var cookieSesion;
  var academico3;
  var gestorMensajes;

  Sesion(this.legajo, this.dominio, this.password) {
    legajo = legajo;
    dominio = dominio;
    password = password;

    nuevaSesion();
  }

  void getCookie() async {
    var _url = 'https://www.frc.utn.edu.ar/funciones/sesion/iniciarSesion.frc';

    var _request = http.Request('POST', Uri.parse(_url))
      ..followRedirects = false;

    var _data = {
      'page': 'login',
      'pwdClave': password,
      'redir': '/logon.frc',
      't': '79845687',
      'txtDominios': dominio,
      'txtUsuario': legajo,
      'userid': 'userid'
    };

    _request.bodyFields = _data;

    await _request.send().then((http.StreamedResponse res) {
      cookieSesion = res.headers['set-cookie'];
    });

    print(cookieSesion);
  }

  void getAcademico() async {
    var academico3 = await http
        .get('https://a4.frc.utn.edu.ar/', headers: {'Cookie': cookieSesion});

    print({academico3.statusCode});
    print({academico3.body});

    this.academico3 = academico3.body;
  }

  bool nuevaSesion() {
    try {
      getCookie();
      getAcademico();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
