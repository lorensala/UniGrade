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

  void nuevaSesion() async {
    cookieSesion = "pag=2; rec=0; usr=#{@legajo}%40#{@dominio}.frc.utn.edu.ar";

    var url = 'https://www.frc.utn.edu.ar/logon.frc';

    var response = await http.post(
      url,
      body: {
        'txtUsuario': legajo,
        'txtDominios': dominio,
        'pwdClave': password
      },
    );
    print({response.statusCode});
  }
}
