import 'package:flutter/material.dart';
import 'package:laboratorio_app2/models/campanias_class.dart';

// ignore: must_be_immutable
class Campanias extends StatefulWidget {
  final String id;
  Campanias({this.id});

  @override
  __CampaniasState createState() {
    return __CampaniasState(id);
  }
}

class __CampaniasState extends State<Campanias> {
  String id;
  __CampaniasState(this.id);
  List<Widget> listaDeCards = List.generate(
      0,
      (index) => SizedBox(
            height: 1,
          ));

  @override
  void initState() {
    super.initState();
    loadListCampanias();
  }

  Widget loadingDialog(BuildContext context) {
    return AlertDialog(
        title: Text("Cargando"),
        content: Container(
          height: 80,
          width: 80,
          child: Center(child: CircularProgressIndicator()),
        ));
  }

  void popDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  void loadListCampanias() async {
    loadingDialog(context);
    List result = await Campania.loadCampanias(this.id);

    setState(() {
      if (result.isNotEmpty) {
        result.forEach((item) {
          var c = card(context, item['id'].toString(), item['title'],
              item['body'], item['expiration'], item['discount']);
          listaDeCards.add(c);
        });
      } else {
        popDialog(context);
      }
    });
  }

  Widget listOfCampanias() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campañas"),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: todo(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget todo(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.redAccent,
      padding: EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 10),
      child: Column(
        children: <Widget>[listOfCampanias()],
      ),
    );
  }

  Widget card(BuildContext context, String idCampania, String title,
      String body, String expiration, String discount) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: new Text(title),
            subtitle: Text(body),
          ),
          Text('Expira en: ' + expiration.substring(0, 10)),
          Text('Descuento: ' + discount + " %"),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text('Ver pruebas'),
                onPressed: () {
                  Navigator.pushNamed(context, 'campaignTestsPage',
                      arguments: idCampania);
                },
              ),
              SizedBox(width: 8),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
