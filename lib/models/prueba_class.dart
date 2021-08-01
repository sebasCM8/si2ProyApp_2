import 'dart:convert';
import 'package:http/http.dart' as http;

class Prueba{

  int _id;
  String _name;
  String _desc;
  String _price;

  int getId() => this._id;
  String getDesc() => this._desc;
  String getNombre() => this._name;
  String getPrecio() => this._price;

  Prueba.fromAPI(Map<String, dynamic> item){
    this._id = item['id'];
    this._name = item['name'];
    this._desc = item['detail'];
    this._price = item['price'];
  }

  static Future<Prueba> getPrueba(int id) async {
    final url = 'https://laboratoriosi.andresmontano.website/api/proofs/show/$id';
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      return Prueba.fromAPI(json.decode(response.body)['data']);
    } else {
      return null;
    }
  }

  static Future<List> loadTests(String idCampania) async {
    String host = 'https://laboratoriosi.andresmontano.website/';

    var url = Uri.parse(host + 'api/tests/index/' + idCampania);
    var response = await http.get(url);
    
    const JsonDecoder decoder = const JsonDecoder();
    var json = decoder.convert(response.body);
    return json['data'];
  }
}