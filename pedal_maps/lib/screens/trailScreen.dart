import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrailPage extends StatefulWidget {

  final DocumentSnapshot trail;

  TrailPage({this.trail});

  @override
  _TrailPageState createState() => _TrailPageState();
}

class _TrailPageState extends State<TrailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Pedal Maps'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.trail.get("trailName")),
            subtitle: Text("test"),
          ),
        ),
      ),
    );
  }
}