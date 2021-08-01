import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laboratorio_app2/costum_widgets/generic_widgets.dart';
import 'package:laboratorio_app2/generic_actions/validation_methods.dart';
import 'package:laboratorio_app2/models/usuario_class.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  int ingresando = 0;

  Usuario _user;

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _goToMenuPage(){
    Navigator.pushReplacementNamed(context, 'menuPage', arguments: _user);
  }

  startTimer(){
    var duration = new Duration(seconds: 2);
    return new Timer(duration, _goToMenuPage);
  }

  void _ingresarBtn() async{
    setState(() {
      ingresando = 1;
    });
    if (isNotEmpty(userController.text) &&
        isNotEmpty(passwordController.text)) {
      Usuario user = Usuario.fromLogin(userController.text, passwordController.text);
      Usuario response = await Usuario.loginUser(user);
      if (response != null) {
        _user = response;
        _user.setPassword(passwordController.text);
        startTimer();
      } else {
        wrongDataDialog(context, "Usuario no encontrado", 0);
        setState(() {
          ingresando = 0;
        });
      }
    } else {
      wrongDataDialog(context, "Datos erroneos", 0);
      setState(() {
        ingresando = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de sesion"),
      ),
      body: Container(
          child: ListView(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: screenwidth * 0.4,
              height: screenheight * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/loginImage.png',
                    ),
                  ))),
        ]),
        inputForm(userController, Icons.person, "Usuario"),
        inputFormPassword(passwordController, Icons.security, "Contraseña"),
        SizedBox(
          height: 50,
          width: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _ingresarBtn,
                child: Container(
                    alignment: Alignment.center,
                    width: screenwidth * 0.4,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Ingresar",
                      style: TextStyle(fontSize: 22),
                    ))),
          ],
        ),
        (ingresando == 1)
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: 40, left: screenwidth * 0.4, right: screenwidth * 0.4),
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.redAccent[400]),
                ),
              )
            : SizedBox(width: 10, height: 10)
      ])),
    );
  }
}
