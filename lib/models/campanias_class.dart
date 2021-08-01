import 'dart:convert';
import 'package:http/http.dart' as http;

class Campania{

  int _id;
  String _title;
  String _desc;
  String _expiration;
  double _descount;

  int getId() => this._id;
  String getTitle() => this._title;
  String getDesc() => this._desc;
  String getExpiration() => this._expiration;
  double getDescount() => this._descount;

  Campania.fromAPI(Map<String, dynamic> item){
    this._id = item['id'];
    this._title = item['title'];
    this._desc = item['body'];
    this._expiration = item['expiration'];
    this._descount = item['discount'];
  }

  static Future<List> loadCampanias(String id) async {
    String host='https://laboratoriosi.andresmontano.website/';

    var url = Uri.parse(host+'api/campaign/index/'+id);
    var response = await http.get(url);

    const JsonDecoder decoder = const JsonDecoder();
    var json=decoder.convert(response.body);
    return json['data'];
  }
}