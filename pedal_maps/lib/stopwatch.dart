import 'dart:async';

//adopted from https://medium.com/analytics-vidhya/build-a-simple-stopwatch-in-flutter-a1f21cfcd7a8

Stream<int> stopWatchStream() {

  StreamController<int> streamController;
  Timer timer;
  Duration timerInterval = Duration(seconds: 1);
  int counter = 0;

  //check timer is running, if so stop process, reset timer and counter

  void stopTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
      counter = 0;
      streamController.close();
    }
  }

  void tick(_) {
    counter++;
    streamController.add(counter);
  }

  //while active calls tick function every second
  //Duration timerInterval = Duration(seconds: 1)
  void startTimer() {
    if(timer == null)
      timer = Timer.periodic(timerInterval, tick);
  }

  //functions to be called when events occur
  streamController = StreamController<int>(
    onListen: startTimer,
    onCancel: stopTimer,
    onResume: startTimer,
    onPause: stopTimer,
  );

  return streamController.stream;
}