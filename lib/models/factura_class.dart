import 'dart:convert';
import 'package:http/http.dart' as http;

class Factura {
  int _id;
  double _descuento;
  String _fecha;
  String _nit;
  String _precioNeto;
  String _precioBruto;
  int _analisisId;


  Factura(this._id, this._descuento, this._fecha, this._nit, this._precioBruto,
      this._precioNeto);
  Factura.froMap(Map<String, dynamic> mapa) {
    this._id = mapa['id'];
    //this._descuento = mapa['descuento'];
    this._nit = mapa['nit'];
    //this._precioBruto = mapa['precioBruto'];
    //this._precioNeto = mapa['precioNeto'];
    this._fecha = mapa['fecha'];
    this._precioNeto = mapa['importe'];
    this._analisisId = int.parse(mapa['analysis_id']);
  }

  int getId() => this._id;
  String getNit() => this._nit;
  double getDescuento() => this._descuento;
  String getFecha() => this._fecha;
  String getPrecioNeto() => this._precioNeto;
  String getPrecioBruto() => this._precioBruto;
  int getAnalysisId() => this._analisisId;
  
  
  static Future<List> getFacturas(int id) async{
    final url = "https://laboratoriosi.andresmontano.website/api/invoice/getInvoices/$id";
    var response = await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200){
      var data = json.decode(response.body);
      return data;
    }else{
      return null;
    }
  }
}
