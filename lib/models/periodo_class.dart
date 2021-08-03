import 'dart:convert';
import 'package:http/http.dart' as http;

class Periodo {
  int _id;
  String _begin;
  String _end;
  int _labId;

  int getId() => this._id;
  int getLabId() => this._labId;
  String getBegin() => this._begin;
  String getEnd() => this._end;

  Periodo.fromAPI(Map<String, dynamic> record){
    this._id = record['id'];
    this._begin = record['begin'];
    this._end = record['end'];
    this._labId = int.parse(record['laboratory_id']);
  }

  static Future<List> getPeriodos(int id, String fecha) async {
    final url =
        "https://laboratoriosi.andresmontano.website/api/reservation/searched/$id";
    var response = await http.post(url, body: {'date': fecha});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['data'];
    } else {
      return null;
    }
  }
}
