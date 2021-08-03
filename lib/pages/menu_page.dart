import 'package:flutter/material.dart';
import 'package:laboratorio_app2/costum_widgets/generic_widgets.dart';
import 'package:laboratorio_app2/models/usuario_class.dart';

class MenuPage extends StatefulWidget {
  final Usuario user;
  MenuPage({this.user});
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Usuario _user;
  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  void _goFacturas(){
    Navigator.pushNamed(context, 'facturasPage', arguments: _user);
  }

  void _irAnalisis(){
    Navigator.pushNamed(context, 'analisisPage', arguments: _user);
  }

  void _goCampaigns(){
    Navigator.pushNamed(context, 'campaignsPage', arguments: '2');
  }

  void _goReservas(){
    Navigator.pushNamed(context, 'reservasPage', arguments: _user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laboratorio Menu"),
      ),
      body: Container(
        child: Center(
          child: mediumText("Bienvenido: ${_user.getUsername()}", Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.red),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )),
            ListTile(
                leading: Icon(
                  Icons.explore,
                  color: Colors.blue,
                ),
                title: Text("Mis analisis"),
                onTap: _irAnalisis,),
            ListTile(
                leading: Icon(
                  Icons.phone_callback,
                  color: Colors.green,
                ),
                title: Text("Reserva"),
                onTap: _goReservas,),
            ListTile(
                leading: Icon(Icons.book, color: Colors.red),
                title: Text("Mis facturas"),
                onTap: _goFacturas,),
            ListTile(
                leading: Icon(Icons.local_hospital, color: Colors.red),
                title: Text("Campañas"),
                onTap: _goCampaigns,),
          ],
        ),
      ),
    );
  }
}
