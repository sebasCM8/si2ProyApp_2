import 'package:flutter/material.dart';
import 'package:laboratorio_app2/models/reserva_class.dart';
import 'package:laboratorio_app2/models/usuario_class.dart';

class ReservasPage extends StatefulWidget {
  final Usuario usu;
  ReservasPage({this.usu});
  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  Usuario _user;
  List _reservas = [];

  void getReservasUsuario() async {
    List reservas = await Reserva.getReservas(_user.getId());
    if (reservas != null) {
      setState(() {
        reservas.forEach((element) {
          Reserva res = Reserva.fromAPI(element);
          _reservas.add(res);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _user = widget.usu;
    getReservasUsuario();
  }

  Widget _reservaCard(Reserva res) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.red, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
            child: Icon(Icons.wallet_giftcard, color: Colors.white),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nro Reserva: ${res.getId()}',
                    style: TextStyle(fontSize: 17)),
                Text('Fecha reserva: ', style: TextStyle(fontSize: 17)),
                Text(res.getDate(), style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reservas"),
        ),
        body: Container(
            child: (_reservas.length == 0)
                ? Center(
                    child: Text("No tiene reservas disponibles"),
                  )
                : ListView.builder(
                    itemCount: _reservas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _reservaCard(_reservas[index]);
                    },
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'nuevaReservaPage', arguments: _user);
          },
          child: Icon(Icons.add),
        ));
  }
}
