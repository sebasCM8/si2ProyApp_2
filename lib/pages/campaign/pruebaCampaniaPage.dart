import 'package:flutter/material.dart';
import 'package:laboratorio_app2/models/prueba_class.dart';

class Tests extends StatefulWidget {
  final String idCampania;
  Tests({this.idCampania});

  @override
  __TestsState createState() {
    return __TestsState(idCampania);
  }
}

class __TestsState extends State<Tests> {
  String idCampania;
  __TestsState(this.idCampania);

  List<Widget> listaDeCards = List.generate(
      0,
      (index) => SizedBox(
            height: 1,
          ));

  @override
  void initState() {
    super.initState();
    loadListTests();
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

  void loadListTests() async {
    loadingDialog(context);
    List result = await Prueba.loadTests(idCampania);

    setState(() {
      if (result.isNotEmpty) {
        result.forEach((item) {
          var c = card(
              context, item['name'], item['detail'], item['price'].toString());
          listaDeCards.add(c);
        });
      } else {
        popDialog(context);
      }
    });
  }

  Widget listOfTests() {
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
      appBar: AppBar(title: Text("Campañas de prueba"),),
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
      color: Colors.red[400],
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      child: Column(
        children: <Widget>[listOfTests()],
      ),
    );
  }

  Widget card(BuildContext context, String name, String detail, String price) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: new Text(name),
            subtitle: Text(detail),
          ),
          Text('Precio: ' + price),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(width: 8),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}