import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrailData{
  String trailName = "";
  int difficulty = 0;
  String hours = "";
  String minutes = "";
  String seconds = "";
  bool pavement = false;
  double totalDistance = 0.0;
}

void setTime(TrailData data, String h, String m, String s){
  data.hours = h;
  data.minutes = m;
  data.seconds = s;
}

void setDistance(TrailData data, double distance){
  data.totalDistance = distance;
}

void addTrail(TrailData data, CollectionReference trails) {
  trails
  .add({
    'trailName': data.trailName,
    'difficulty': data.difficulty,
    'hours': data.hours,
    'minutes': data.minutes,
    'seconds': data.seconds,
    'pavement': data.pavement,
    'totalDistance': data.totalDistance
  })
      .then((value) => print("Trail Added"))
      .catchError((error) => print("Failed to add trail: $error"));

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
  return DropdownButtonFormField<int>(
    onSaved: (val) {
      data.difficulty = val;
    },
    validator: (val) => val == null ? 'You must select a difficulty' : null,
    items: [
      1, 2, 3, 4, 5
    ].map<DropdownMenuItem<int>>(
        (val){
          return DropdownMenuItem(
            child: Text(val.toString()),
            value: val,
          );
        },

    ).toList(),
    onChanged: (val){
      data.difficulty = val;
    },
    decoration: InputDecoration(
      labelText: "Difficulty",
    ),
  );
}

Widget buildPaved(TrailData data){
  return DropdownButtonFormField<String>(
    onSaved: (val) {
      if(val == 'Is Paved')
        data.pavement = true;
      else
        data.pavement = false;
    },
    validator: (val) => val == null ? 'You must select a Pavement option' : null,
    items: [
      "Is Paved", "Is Not Paved"
    ].map<DropdownMenuItem<String>>(
          (val){
        return DropdownMenuItem(
          child: Text(val),
          value: val,
        );
      },
    ).toList(),
    onChanged: (val){
      if(val == 'Is Paved')
        data.pavement = true;
      else
        data.pavement = false;
    },
    decoration: InputDecoration(
      labelText: "Pavement",
    ),
  );
}

