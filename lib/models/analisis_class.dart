import 'dart:convert';
import 'package:http/http.dart' as http;

class Analisis {
  int _id;
  int _pruebaId;
  int _personalId;

  String _detalle;
  int _estado;
  String _precio;
  String _descuento;

  void setId(int id) => this._id = id;
  void setEstado(int estado) => this._estado = estado;
  int getID() => this._id;
  int getEstado() => this._estado;
  String getPrecio() => this._precio;
  String getDescuento() => this._descuento;
  int getPruebaId() => this._pruebaId;
  int getPersonalId() => this._personalId;
  String getDetalle() => this._detalle;

  Analisis.fromAPI(Map<String, dynamic> record) {
    this._id = record['id'];
    this._pruebaId = int.parse(record['proof_id']);
    this._personalId = int.parse(record['nurse_id']);

    this._estado = int.parse(record['status']);
    this._precio = record['price'];
    this._descuento = record['discount'];
    this._detalle = record['detail'];
  }

  static Future<List> getAnalisis(int id) async {
    final url =
        "https://laboratoriosi.andresmontano.website/api/analysis/getAnalyses/$id";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      List analisis = json.decode(response.body);
      return analisis;
    } else {
      return null;
    }
  }
}
