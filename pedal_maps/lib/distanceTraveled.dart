import 'package:flutter/material.dart';
import 'stopwatch.dart';

class distanceTraveled extends StatefulWidget{
  _distanceTraveled createState() => _distanceTraveled();
}

class _distanceTraveled extends State<distanceTraveled> {

  var hoursStr = '00';
  var minutesStr = '00';
  var secondsStr = '00';
  var timerStream, timerSubscription;
  var start_check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Track a Ride"),
          backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$hoursStr:$minutesStr:$secondsStr",
              style: TextStyle(
                fontSize: 60.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: Colors.green,
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    if (start_check == false){
                    timerStream = stopWatchStream();
                    timerSubscription = timerStream.listen((int newTick) {
                      setState(() {
                        hoursStr = ((newTick / (60 * 60)) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        minutesStr = ((newTick / 60) % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        secondsStr = (newTick % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                      });
                    });
                    start_check = true;
                    }
                  },
                ),
                SizedBox(width: 30.0),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: Colors.red,
                  child: Text(
                    'RESET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    timerSubscription.cancel();
                    timerStream = null;
                    setState(() {
                      hoursStr = '00';
                      minutesStr = '00';
                      secondsStr = '00';
                    });
                    start_check = false;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
