import 'dart:convert';
import 'package:http/http.dart' as http;

class Reserva {
  int _id;
  int _userId;
  int _periodId;
  int _roomId;
  String _date;

  int getId() => this._id;
  int getUserId() => this._userId;
  int getPeriodId() => this._periodId;
  int getRoomId() => this._roomId;
  String getDate() => this._date;

  Reserva.fromAPI(Map<String, dynamic> record) {
    this._id = record['id'];
    this._periodId = int.parse(record['period_id']);
    this._roomId = int.parse(record['room_id']);
    this._userId = int.parse(record['user_id']);
    this._date = record['date'];
  }

  static Future<List> getReservas(int id) async {
    final url =
        "https://laboratoriosi.andresmontano.website/api/reservation/index/$id";
    var response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['data'];
    } else {
      return null;
    }
  }

  static Future<int> reservarNueva(int periodId, String date, int userId) async {
    final url =
        "https://laboratoriosi.andresmontano.website/api/reservation/store/$periodId/$date/$userId";
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    if(response.statusCode == 200){
      return 1;
    }else{
      return null;
    }
  }
}
