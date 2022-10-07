// WESLEY ALEXANDRE FIGUEIREDO

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> filhos = ['1', '2', '3 ou mais'];
  List<String> salario = ['até 1 salário mínimo', 'até 2 salários mínimos', '3 salários mínimos ou mais'];
  final dropValuea = ValueNotifier('');
  String selecteda = "";
  final dropValueb = ValueNotifier('');
  String selectedb = "";
  bool estadoa = false;
  bool estadob = false;
  String _value = "";
  int? selectedRadioa = 0;
  int? selectedRadiob = 0;
  int? selectedRadioc = 0;
  String infoText = "Informe seus dados";
  double salariominimo = 1212.0;
  double auxilio = 0;

  void _calculate(){
    setState(() {
      if(selectedRadioa == 2 || selectedRadiob == 4){
        infoText = "Sem direito a auxílio.";
      } else if (selecteda.toString() == "3 ou mais" && (selectedb.toString() == "até 2 salários mínimos" || selectedb.toString() == "até 1 salário mínimo")){
        auxilio = salariominimo * 3;
        infoText = "Você tem direito a auxílio de $auxilio reais.";
      } else if ((selecteda.toString() == "2" || selecteda.toString() == "1") && selectedb.toString() == "até 1 salário mínimo"){
        auxilio = salariominimo * 2.5;
        infoText = "Você tem direito a auxílio de $auxilio reais.";
      } else if ((selecteda.toString() == "2" || selecteda.toString() == "1") && selectedb.toString() == "até 2 salários mínimos"){
        auxilio = salariominimo * 1.5;
        infoText = "Você tem direito a auxílio de $auxilio reais.";
      } else {
        infoText = "Sem direito a auxílio.";
      }
    });
  }

  void _resetfields(){
    setState(() {
      selectedRadioa = 0;
      selectedRadiob = 0;
      selectedRadioc = 0;
      dropValuea.value = "";
      dropValueb.value = "";
      infoText = "Informe seus dados.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora Auxílio"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: (){
                _resetfields();
              })
        ],
      ),
    body: Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder(
              valueListenable: dropValuea,
              builder: (BuildContext context, String value, _){
                return DropdownButton<String>(
                  hint: const Text("Número de filhos"),
                  value: (value.isEmpty) ? null : value,
                  onChanged: (op) {
                    selecteda = op.toString();
                    dropValuea.value = op.toString();
                  },
                  items: filhos.map((op) => DropdownMenuItem(
                    value: op,
                    child: Text(op),
                  )).toList(),
                );
              }),
            ),
            ValueListenableBuilder(
                valueListenable: dropValueb,
                builder: (BuildContext context, String value, _){
                  return DropdownButton<String>(
                    hint: const Text("Salário"),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (op) {
                      selectedb = op.toString();
                      dropValueb.value = op.toString();
                    },
                    items: salario.map((op) => DropdownMenuItem(
                      value: op,
                      child: Text(op),
                    )).toList(),
                  );
                }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Os filhos estão matriculados na escola?", textAlign: TextAlign.center),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sim", textAlign: TextAlign.center),
                  Radio(
                      value: 1,
                      groupValue: selectedRadioa,
                      onChanged: (val) {
                        setState(() {
                          selectedRadioa = val;
                        });
                      }
                  ),
                  Text("Não", textAlign: TextAlign.center),
                  Radio(
                      value: 2,
                      groupValue: selectedRadioa,
                      onChanged: (val) {
                        setState(() {
                          selectedRadioa = val;
                        });
                      }
                  ),
              ],
          ),
              Text("Os filhos estão matriculados na escola?", textAlign: TextAlign.center),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sim", textAlign: TextAlign.center),
                  Radio(
                      value: 3,
                      groupValue: selectedRadiob,
                      onChanged: (val) {
                        setState(() {
                          selectedRadiob = val;
                        });
                      }
                  ),
                  Text("Não", textAlign: TextAlign.center),
                  Radio(
                      value: 4,
                      groupValue: selectedRadiob,
                      onChanged: (val) {
                        setState(() {
                          selectedRadiob = val;
                        });
                      }
                  ),
                ],
              ),
              Text("A chefe da família é mãe solteira?", textAlign: TextAlign.center),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sim", textAlign: TextAlign.center),
                  Radio(
                      value: 5,
                      groupValue: selectedRadioc,
                      onChanged: (val) {
                        setState(() {
                          selectedRadioc = val;
                        });
                      }
                  ),
                  Text("Não", textAlign: TextAlign.center),
                  Radio(
                      value: 6,
                      groupValue: selectedRadioc,
                      onChanged: (val) {
                        setState(() {
                          selectedRadioc = val;
                        });
                      }
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _calculate();
                },
                child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                style: ElevatedButton.styleFrom(primary: Colors.green,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$infoText", style: TextStyle(color: Colors.black, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ],
        )),
    )
    );
  }
}

