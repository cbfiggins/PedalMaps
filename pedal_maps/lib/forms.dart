import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _TrailData{
  String trailName = "";
  int difficulty = 0;
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
