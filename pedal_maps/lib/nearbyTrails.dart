import 'package:flutter/material.dart';
import 'map.dart';

class nearbyTrails extends StatefulWidget {
  _nearbyTrails createState() => _nearbyTrails();
}

class _nearbyTrails extends State<nearbyTrails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Nearby Trails"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: map(),
      ),
    );
  }
}
