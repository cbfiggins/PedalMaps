import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'map.dart';
import 'stopwatch.dart';
import 'forms.dart';
import 'dart:async';
import 'DistanceTracker.dart';

class distanceTraveled extends StatefulWidget {
  _distanceTraveled createState() => _distanceTraveled();
}

class _distanceTraveled extends State<distanceTraveled> {
  final _formkey = GlobalKey<FormState>();
  TrailData _data = TrailData();

  DistanceTracker _tracker = DistanceTracker();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference database = FirebaseFirestore.instance.collection('trails');
  final FirebaseAuth auth = FirebaseAuth.instance;

  var hoursStr = '00';
  var minutesStr = '00';
  var secondsStr = '00';
  var timerStream, timerSubscription;
  var start_pressed = false;
  var pause_pressed = false;

  int prevTick = 0;

  void StopWatchStart() {
    //function that affects stopwatch when start button pressed
    if (start_pressed == false) {
      timerStream = stopWatchStream();
      timerSubscription = timerStream.listen((int newTick) {
        setState(() {
          hoursStr =
              ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
          minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
          secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
          prevTick = newTick;
        });
      });
      start_pressed = true;
    }
    if (start_pressed == true && pause_pressed == true) {
      timerStream = stopWatchStream();
      timerSubscription = timerStream.listen((int newTick) {
        setState(() {
          hoursStr = (((prevTick + 1) / (60 * 60)) % 60)
              .floor()
              .toString()
              .padLeft(2, '0');
          minutesStr =
              (((prevTick + 1) / 60) % 60).floor().toString().padLeft(2, '0');
          secondsStr = ((prevTick + 1) % 60).floor().toString().padLeft(2, '0');
          prevTick = prevTick + 1;
        });
      });
      pause_pressed = false;
    }
  } //end StopWatchStart

  void StopWatchReset() {
    // function that affects stopwatch when reset button is pressed
    if (timerStream != null) {
      timerSubscription.cancel();
      timerStream = null;
      setState(() {
        hoursStr = '00';
        minutesStr = '00';
        secondsStr = '00';
        prevTick = 0;
      });
      start_pressed = false;
      pause_pressed = false;
    } else {
      setState(() {
        hoursStr = '00';
        minutesStr = '00';
        secondsStr = '00';
        prevTick = 0;
      });
    }
  } // end StopWatchReset

  void StopWatchPause() {
    // function that affects stopwatch when pause button is pressed
    if (start_pressed == true) {
      //timerStream.stop();
      timerSubscription.cancel();
      timerStream = null;
      pause_pressed = true;
    }
  } // end StopWatchPause

  Future<void> _endRide() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('End Ride'),
            content: Form(
                key: _formkey,
                child: Container(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Are you sure you want to end the ride?'),
                        buildTrailName(_data),
                        buildDifficulty(_data),
                        buildPaved(_data),
                      ],
                    ),
                  ),
                )),
            actions: <Widget>[
              FlatButton(
                  child: Text('CONTINUE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text('END'),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();
                      setTime(_data, hoursStr, minutesStr, secondsStr);
                      setDistance(_data, _tracker.PrintDistanceInMiles());
                      setUser(_data, auth);
                      print('Trail Name: ${_data.trailName}');
                      print('Difficulty: ${_data.difficulty}');
                      print(
                          'Time: ${_data.hours}:${_data.minutes}:${_data.seconds}');
                      print(
                          "Trail length: ${_data.totalDistance.toStringAsFixed(2)} Mi");
                      if (_data.pavement == true)
                        print('Trail is paved');
                      else
                        print('Trail is not paved');
                      addTrail(_data, database);
                      StopWatchReset();
                      _tracker.StopTrackingDistance();
                      Navigator.of(context).pop();
                    }
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Track Ride"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: map(),
              width: 350,
              height: 400,
              padding: new EdgeInsets.only(bottom: 25),
            ),
            Text(
              "$hoursStr:$minutesStr:$secondsStr",
              style: TextStyle(
                fontSize: 60.0,
              ),
            ),
            Text(
              _tracker.PrintDistanceInMiles().toStringAsFixed(2) + "  Mi",
              style: TextStyle(
                fontSize: 60.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.green,
                  child: Text(
                    'START',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    _tracker.StartTrackingDistance();
                    StopWatchStart();
                  },
                ),
                SizedBox(width: 30.0),
                RaisedButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.red,
                  child: Text(
                    'END',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    StopWatchPause();
                    _tracker.PauseTrackingDistance();
                    _endRide();
                  },
                ),
              ], // RowChildren
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.white24,
              child: Text(
                'PAUSE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                _tracker.PauseTrackingDistance();
                StopWatchPause();
              },
            ),
          ], // ColumnChildren
        ),
      ),
    );
  } // Build
} // DistanceTraveled
