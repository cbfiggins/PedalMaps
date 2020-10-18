import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrailData{
  String trailName = "";
  int difficulty = 0;
  int tick = 0;
}

void setTime(TrailData data, int tick){
  data.tick = tick;
}

Widget buildTrailName(){
  return TextFormField(
    validator: (value) => value.isEmpty ? "You must enter a trail name" : null,
    decoration: InputDecoration(
        hintText: "Trail Name"
    ),
  );
}

Widget buildDifficulty(){
  return TextFormField(
    validator: (value) => value.isEmpty || int.parse(value) > 5 || int.parse(value) < 1 ? "You must enter a difficulty 1 - 5" : null,
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly
    ],
    decoration: InputDecoration(
        hintText: "Difficulty"
    ),
  );
}

/*
class TrailForm extends StatefulWidget {
  @override
  _TrailForm createState() => _TrailForm();
}

class TrailForm extends State<StopWatch> {
  final _formkey = GlobalKey<FormState>();
  TrailData _data = TrailData();

  Future<void> _endRide() async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('End Ride'),
            content: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Are you sure you want to end the ride?'),
                    buildTrailName(),
                    buildDifficulty(),
                  ],
                ),
              ),
            ),

            actions: <Widget>[
              FlatButton(
                  child: Text('CONTINUE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
              FlatButton(
                  child: Text('END'),
                  onPressed: () {
                    if( _formkey.currentState.validate()){
                      _formkey.currentState.save();
                      StopWatchReset();
                      Navigator.of(context).pop();
                    }
                  }
              )
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {


  }


}

 */