import 'dart:async';

//adopted from https://medium.com/analytics-vidhya/build-a-simple-stopwatch-in-flutter-a1f21cfcd7a8

class Stopwatch {
  Timer _timer;
  Duration timerInterval;
  int counter;
  bool startpressed;
  bool pausepressed;

  Stopwatch() {
    startpressed = false;
    pausepressed = false;
    counter = 0;
    timerInterval = Duration(seconds: 1);
    _timer = Timer.periodic(timerInterval, AddSecond);
  }

  void AddSecond(_) {
    if (startpressed && !pausepressed) {
      counter++;
    }
  }

  //while active calls tick function every second
  //Duration timerInterval = Duration(seconds: 1)
  void StartStopwatch() {
    //log("Started Stopwatch");
    startpressed = true;
    pausepressed = false;
  }

  void PauseStopwatch() {
    pausepressed = true;
  }

  void ResetStopwatch() {
    startpressed = false;
    pausepressed = false;
    counter = 0;
  }

  String GetTime() {
    var hoursStr =
        ((counter / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    var minutesStr = ((counter / 60) % 60).floor().toString().padLeft(2, '0');
    var secondsStr = (counter % 60).floor().toString().padLeft(2, '0');
    return (hoursStr + ":" + minutesStr + ":" + secondsStr);
  }

  String GetHours() {
    return (((counter / (60 * 60)) % 60).floor().toString().padLeft(2, '0'));
  }

  String GetMinutes() {
    return (((counter / 60) % 60).floor().toString().padLeft(2, '0'));
  }

  String GetSeconds() {
    return ((counter % 60).floor().toString().padLeft(2, '0'));
  }
}
