import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrailData{
  String trailName = "";
  int difficulty = 0;
  String hours = "";
  String minutes = "";
  String seconds = "";
}

void setTime(TrailData data, String h, String m, String s){
  data.hours = h;
  data.minutes = m;
  data.seconds = s;
}

Widget buildTrailName(TrailData data){
  return TextFormField(
    validator: (value) => value.isEmpty ? "You must enter a trail name" : null,
    onSaved: (String value) {
      data.trailName = value;
    },
    decoration: InputDecoration(
        hintText: "Trail Name"
    ),
  );
}

Widget buildDifficulty(TrailData data){
  return TextFormField(
    validator: (value) => value.isEmpty || int.parse(value) > 5 || int.parse(value) < 1 ? "You must enter a difficulty 1 - 5" : null,
    onSaved: (String value) {
      data.difficulty = int.parse(value);
    },
    keyboardType: TextInputType.number,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly
    ],
    decoration: InputDecoration(
        hintText: "Difficulty"
    ),
  );
}
