import 'package:flutter/material.dart';
import 'package:laboratorio_app2/costum_widgets/generic_widgets.dart';
import 'package:laboratorio_app2/models/factura_class.dart';
import 'package:laboratorio_app2/models/usuario_class.dart';
import 'package:laboratorio_app2/other_classes/facxuser_param.dart';

class FacturaDetallePage extends StatefulWidget {
  final FacturaUsuario info;
  FacturaDetallePage({this.info});
  @override
  _FacturaDetallePageState createState() => _FacturaDetallePageState();
}

class _FacturaDetallePageState extends State<FacturaDetallePage> {
  Factura _laFactura;
  Usuario _user;

  @override
  void initState() {
    super.initState();
    _laFactura = widget.info.fac;
    _user = widget.info.usu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle factura"),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.redAccent,
                  ),
                  title: mediumText("Cliente: ", Colors.red[800]),
                  subtitle: notableText(_user.getName(), Colors.black),
                )),
                Expanded(
                    child: ListTile(
                        leading: Icon(
                          Icons.note,
                          color: Colors.redAccent,
                        ),
                        title: mediumText("NIT: ", Colors.red[800]),
                        subtitle:
                            notableText(_laFactura.getNit(), Colors.black)))
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: ListTile(
                    leading: Icon(
                      Icons.money,
                      color: Colors.redAccent,
                    ),
                    title: mediumText("Total factura: ", Colors.red[800]),
                    subtitle: notableText(
                        "${_laFactura.getPrecioNeto()}", Colors.black))),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 10, left: 15, right: 15),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.red, width: 3))),
              child: SizedBox(
                height: 3,
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: ListTile(
                    leading: Icon(
                      Icons.format_list_numbered,
                      color: Colors.redAccent,
                    ),
                    title: mediumText("Nro factura: ", Colors.red[800]),
                    subtitle: notableText(
                        "${_laFactura.getId()}", Colors.black))),
            Container(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: ListTile(
                    leading: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.redAccent,
                    ),
                    title: mediumText("Fecha: ", Colors.black),
                    subtitle:
                        notableText(_laFactura.getFecha(), Colors.black)))
          ],
        ),
      ),
    );
  }
}
