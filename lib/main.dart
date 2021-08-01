import 'package:flutter/material.dart';
import 'package:laboratorio_app2/pages/analisisPages/analisis_detalle.dart';
import 'package:laboratorio_app2/pages/analisisPages/analisis_page.dart';
import 'package:laboratorio_app2/pages/campaign/campaignsPages.dart';
import 'package:laboratorio_app2/pages/campaign/pruebaCampaniaPage.dart';
import 'package:laboratorio_app2/pages/facturasPages/facturas_page.dart';
import 'package:laboratorio_app2/pages/facturasPages/fafctura_detalle_page.dart';
import 'package:laboratorio_app2/pages/home_page.dart';
import 'package:laboratorio_app2/pages/login_pages/login_page.dart';
import 'package:laboratorio_app2/pages/menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home_page',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        'home_page': (context) => HomePage(),
        'login_page': (context) => LoginPage(),
        'menuPage':(context)=>MenuPage(user: ModalRoute.of(context).settings.arguments,),
        'facturasPage': (context)=>FacturasPage(user: ModalRoute.of(context).settings.arguments,),
        'facturaDetallePage': (context) => FacturaDetallePage(info: ModalRoute.of(context).settings.arguments,),
        'analisisPage': (context)=>AnalisisPage(user: ModalRoute.of(context).settings.arguments,),
        'campaignsPage': (context) => Campanias(id:ModalRoute.of(context).settings.arguments),
        'campaignTestsPage': (context) => Tests(idCampania: ModalRoute.of(context).settings.arguments),
        'analisisDetallePage':(context)=>AnalisisDetallePage(ana: ModalRoute.of(context).settings.arguments)
      },
    );
  }
}