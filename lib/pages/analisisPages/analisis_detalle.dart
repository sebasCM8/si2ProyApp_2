import 'package:flutter/material.dart';
import 'package:laboratorio_app2/costum_widgets/generic_widgets.dart';
import 'package:laboratorio_app2/models/analisis_class.dart';
import 'package:laboratorio_app2/models/prueba_class.dart';

class AnalisisDetallePage extends StatefulWidget {
  final Analisis ana;
  AnalisisDetallePage({this.ana});
  @override
  _AnalisisDetallePageState createState() => _AnalisisDetallePageState();
}

class _AnalisisDetallePageState extends State<AnalisisDetallePage> {
  Analisis _ana;
  Prueba _prueba;

  @override
  void initState() {
    super.initState();
    _ana = widget.ana;
    _getPrueba();
  }

  void _getPrueba() async {
    Prueba pur = await Prueba.getPrueba(_ana.getPruebaId());
    if (pur != null) {
      setState(() {
        _prueba = pur;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de analisis"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: (_prueba == null)
            ? Center(
                child: Text("Cargando prueba.."),
              )
            : ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: ListTile(
                      leading: Icon(
                        Icons.local_hospital,
                        color: Colors.red,
                      ),
                      title: mediumText("Analisis", Colors.red),
                      subtitle: notableText(_prueba.getNombre(), Colors.black),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.money,
                      color: Colors.red,
                    ),
                    title: mediumText("Precio Analisis", Colors.red),
                    subtitle: notableText(_ana.getPrecio(), Colors.black),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.red,
                    ),
                    title: mediumText("Precio unitario prueba", Colors.red),
                    subtitle: notableText(_prueba.getPrecio(), Colors.black),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.description_outlined,
                      color: Colors.red,
                    ),
                    title: mediumText("Descuento", Colors.red),
                    subtitle: notableText(_ana.getDescuento(), Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      mediumText("Estado: ", Colors.red),
                      Text((_ana.getEstado() == 1) ? "Terminado" : "En proceso",
                          style: TextStyle(
                            color: (_ana.getEstado() == 1)
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                          ))
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
