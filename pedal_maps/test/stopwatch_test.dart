import "package:pedal_maps/stopwatch.dart";
import "package:test/test.dart";


void main(){

  test("Stopwatch started", (){
    Stopwatch stop = Stopwatch();
    stop.StartStopwatch();
    var result = stop.startpressed == true;
    expect(result, true);
  });

  test("Stopwatch paused", (){
    Stopwatch stop = Stopwatch();
    stop.PauseStopwatch();
    var result = stop.pausepressed == true;
  expect(result, true);
  });

  test("Stopwatch reset", (){
    Stopwatch stop = Stopwatch();
    stop.StartStopwatch();
    stop.ResetStopwatch();
    var result = (stop.counter == 0 && stop.pausepressed == false && stop.startpressed == false);
    expect(result, true);
  });

  test("Add second", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 10; i++){
      stop.AddSecond(0);
    }
    expect(stop.counter, equals(10));

  });

  test("Get seconds single digit", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 9; i++){
      stop.AddSecond(0);
    }
    String sec = stop.GetSeconds();
    expect(sec, equals("09"));
  });

  test("Get seconds double digit", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 35; i++){
      stop.AddSecond(0);
    }
    String sec = stop.GetSeconds();
    expect(sec, equals("35"));
  });

  test("Get minutes single digit", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 61; i++){
      stop.AddSecond(0);
    }
    String sec = stop.GetMinutes();
    expect(sec, equals("01"));
  });

  test("Get minutes double digit", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 601; i++){
      stop.AddSecond(0);
    }
    String sec = stop.GetMinutes();
    expect(sec, equals("10"));
  });

  test("Get hours single digit", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 3601; i++){
      stop.AddSecond(0);
    }
    String sec = stop.GetHours();
    expect(sec, equals("01"));
  });

  test("Get hours double digit", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 36001; i++){
      stop.AddSecond(0);
    }
    String sec = stop.GetHours();
    expect(sec, equals("10"));
  });



  test("Get time", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 10; i++){
      stop.AddSecond(0);
    }
    String time = stop.GetTime();
    expect(time, equals("00:00:10"));
  });

  test("Get time all", (){
    Stopwatch stop = Stopwatch();
    stop.startpressed = true;
    for(int i = 0; i < 3725; i++){
      stop.AddSecond(0);
    }
    String time = stop.GetTime();
    expect(time, equals("01:02:05"));
  });



}