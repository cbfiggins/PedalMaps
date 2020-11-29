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




}
