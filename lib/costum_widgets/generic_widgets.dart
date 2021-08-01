import 'package:flutter/material.dart';
import 'package:laboratorio_app2/models/factura_class.dart';

Widget bigText(String theText, Color theColor) {
  return Text(theText,
      style: TextStyle(
          color: theColor, fontSize: 40, fontWeight: FontWeight.bold));
}

Widget mediumText(String theText, Color theColor) {
  return Text(theText,
      style: TextStyle(
          color: theColor, fontSize: 22, fontWeight: FontWeight.w400));
}

Widget notableText(String theText, Color theColor) {
  return Text(theText,
      style: TextStyle(
          color: theColor, fontSize: 17));
}

Widget inputForm(TextEditingController controller, IconData icon, String text) {
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: ListTile(
      leading: Icon(icon),
      title: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: '$text...',
            labelStyle: TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder()),
      ),
    ),
  );
}

Widget inputFormPassword(TextEditingController controller, IconData icon, String text) {
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: ListTile(
      leading: Icon(icon),
      title: TextField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
            labelText: '$text...',
            labelStyle: TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder()),
      ),
    ),
  );
}

Future<void> wrongDataDialog(
    BuildContext context, String theText, int notiTipo) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(theText,
              style: TextStyle(
                  color: (notiTipo == 1) ? Colors.green : Colors.red)),
          content: SingleChildScrollView(
              child: ListBody(
            children: [
              SimpleDialogOption(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.close),
                  ),
                  onPressed: () => Navigator.pop(context))
            ],
          )),
        );
      });
}

Widget facturaCard(Factura fac) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border.all(
            color: Colors.redAccent,
            width: 1.5
          ),
          boxShadow: [
            BoxShadow(
              color:Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0,4)
            )
          ]),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text('${fac.getId()}'),
              Text('Nit: ${fac.getNit()}'),
              Text('Descuento: ${fac.getDescuento()}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Realizada el:', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('${fac.getFecha()}')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }