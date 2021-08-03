import 'package:flutter/material.dart';
import 'package:laboratorio_app2/costum_widgets/generic_widgets.dart';
import 'package:laboratorio_app2/models/periodo_class.dart';
import 'package:laboratorio_app2/models/reserva_class.dart';
import 'package:laboratorio_app2/models/usuario_class.dart';
import 'package:intl/intl.dart';

class NuevaReservaPage extends StatefulWidget {
  final Usuario usu;
  NuevaReservaPage({this.usu});
  @override
  _NuevaReservaPageState createState() => _NuevaReservaPageState();
}

class _NuevaReservaPageState extends State<NuevaReservaPage> {
  Usuario _user;

  DateTime _dateTime;
  String formatedDate;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  List _periodos = [];

  Map<int, Color> periodsContainers = {};
  int _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _user = widget.usu;
  }

  void getPeriodosFecha() async {
    String fecha = "${_dateTime.year}-${_dateTime.month}-${_dateTime.day}";
    List periodos = await Periodo.getPeriodos(_user.getLabId(), fecha);
    if (periodos != null) {
      //print("Bringing periods!!!!...");
      setState(() {
        periodsContainers.clear();
        _periodos.clear();
        periodos.forEach((element) {
          //print(element);
          Periodo per = Periodo.fromAPI(element);
          _periodos.add(per);
          periodsContainers.putIfAbsent(per.getId(), () => Colors.grey);
        });
      });
    } else {
      print("Not working..");
    }
  }

  void _getPeriodos() {
    if (_dateTime != null) {
      bool ok = true;
      int todayDay = DateTime.now().day;
      int selectedDay = _dateTime.day;

      int currentMonth = DateTime.now().month;
      int selectedMonth = _dateTime.month;
      if (currentMonth == selectedMonth) {
        if (selectedDay <= todayDay) ok = false;
      }
      if (ok) {
        //print("going well");
        getPeriodosFecha();
      }
    }
  }

  String getHour(String h) {
    int inicioIndex = h.indexOf('T') + 1;
    return h.substring(inicioIndex, inicioIndex + 8);
  }

  void _selectPeriod(int id){
    if(_selectedPeriod != null){
      setState(() {
        periodsContainers[_selectedPeriod] = Colors.grey;
      });
    }
    setState(() {
      periodsContainers[id] = Colors.green;
    });
    _selectedPeriod = id;
  }

  Widget _periodoCard(Periodo per) {
    String begin = getHour(per.getBegin());
    String end = getHour(per.getEnd());

    return InkWell(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: periodsContainers[per.getId()],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text('$begin - $end',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w800))),
                  onTap: (){
                    _selectPeriod(per.getId());
                  },
    );
  }

  void _reservar() async{
    if(_selectedPeriod != null){
      String fecha = "${_dateTime.year}-${_dateTime.month}-${_dateTime.day}";
      int response = await Reserva.reservarNueva(_selectedPeriod, fecha, _user.getId());
      if(response != null){
        print("Reserva registrada correctamente");
        wrongDataDialog(context, "Reserva registrada exitosamente", 1);
      }else{
        wrongDataDialog(context, "No se pudo reservar..", 0);
      }
    }else{
      wrongDataDialog(context, "Seleccione un periodo primero", 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva reserva"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Text('Fecha de atencion:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                ),
                Expanded(
                    child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent, shape: BoxShape.circle),
                    child: IconButton(
                      focusColor: Colors.yellow,
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: _dateTime == null
                                    ? DateTime.now()
                                    : _dateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2022))
                            .then((date) {
                          setState(() {
                            _dateTime = date;
                            formatedDate = formatter.format(_dateTime);
                          });
                        });
                      },
                    ),
                  ),
                  title: Text((formatedDate == null) ? "Fecha" : formatedDate),
                ))
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _getPeriodos,
                    child: Container(
                        alignment: Alignment.center,
                        width: screenwidth * 0.4,
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "ver periodos",
                          style: TextStyle(fontSize: 20),
                        ))),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            (_periodos.length == 0)
                ? Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("No hay periodos disponibles"),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: _periodos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _periodoCard(_periodos[index]);
                              }),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: _reservar,
                                child: Container(
                                    alignment: Alignment.center,
                                    width: screenwidth * 0.4,
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Reservar",
                                      style: TextStyle(fontSize: 20),
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
