import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuario {
  String _ci;
  String _direccion;
  String _email;
  String _fechaNacimiento;
  int _id;
  String _nombre;
  String _telefono;

  String _username;
  String _password;

  int _laboratorioId;

  Usuario(this._username, this._password, this._id, this._nombre, this._ci,
      this._direccion, this._email, this._telefono, this._fechaNacimiento);

  Usuario.fromLogin(this._username, this._password);

  String getUsername() => this._username;
  String getPassword() => this._password;
  String getName() => this._nombre;
  int getId()=>this._id;
  String getCI() => this._ci;
  String getDireccion() => this._direccion;
  String getEmail() =>  this._email;
  String getFechaNacimiento() => this._fechaNacimiento;
  String getTelefono() => this._telefono;
  int getLabId() => this._laboratorioId;

  void setPassword(String pasword) => this._password = pasword;


  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = {
      'username': this._username,
      'password': this._password
    };
    return mapa;
  }
  /* =======================
  ======API METHODS =======
  ========================*/

  Usuario.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._ci = map['ci'];
    this._email = map['email'];
    //this._fechaNacimiento = map['fechaNacimiento'];
    this._username = map['username'];
    this._nombre = map['name'];
    //this._password = map['password'];
    //this._telefono = map['telefono'];
    this._laboratorioId = int.parse(map['laboratory_id']);
  }

  static Future<Usuario> loginUser(Usuario user) async {
    final url = "https://laboratoriosi.andresmontano.website/api/login";
    Map<String, dynamic> mapa = user.toMap();
    var response = await http.post(url,
        body: {'username': mapa['username'], 'password': mapa['password']});
    if (response.statusCode == 200) {
      Map<String, dynamic> mapp = json.decode(response.body);
      return Usuario.fromMap(mapp['data']);
    } else {
      return null;
    }
  }
}
