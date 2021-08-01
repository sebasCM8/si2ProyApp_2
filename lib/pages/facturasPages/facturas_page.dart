import 'package:flutter/material.dart';
import 'package:laboratorio_app2/models/factura_class.dart';
import 'package:laboratorio_app2/models/usuario_class.dart';
import 'package:laboratorio_app2/other_classes/facxuser_param.dart';

class FacturasPage extends StatefulWidget {
  final Usuario user;
  FacturasPage({this.user});
  @override
  _FacturasPageState createState() => _FacturasPageState();
}

class _FacturasPageState extends State<FacturasPage> {
  Usuario _user;
  List _facturas = [];

  void _getFacturas() async {
    List acturas = await Factura.getFacturas(_user.getId());
    if (acturas != null) {
      setState(() {
        acturas.forEach((element) {
          Factura fac = Factura.froMap(element);
          _facturas.add(fac);
        });
      });
    }

    /*for (int i = 1; i < 21; i++) {
      Factura fac = Factura(i, 12.0, '19/07/2021', '77767$i', 1000, 950);
      _facturas.add(fac);
    }*/
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _getFacturas();
  }

  void _verFactura(Factura fac) {
    print("hello");
    FacturaUsuario info = FacturaUsuario(_user, fac);
    Navigator.pushNamed(context, 'facturaDetallePage', arguments: info);
  }

  Widget _facturaCard(Factura fac) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: Icon(Icons.payment, color: Colors.white),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nit: ${fac.getNit()}', style: TextStyle(fontSize: 17)),
                Text('Descuento: ${fac.getPrecioNeto()}',
                    style: TextStyle(fontSize: 17)),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Realizada el:', style: TextStyle(fontSize: 17)),
                    Text('${fac.getFecha()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        _verFactura(fac);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Facturas"),
      ),
      body: Container(
          padding: EdgeInsets.all(14),
          child: (_facturas.length == 0)
              ? Center(
                  child: Text("No tiene facturas disponibles"),
                )
              : ListView.builder(
                  itemCount: _facturas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _facturaCard(_facturas[index]);
                  })),
    );
  }
}
