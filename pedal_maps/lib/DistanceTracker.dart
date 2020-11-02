import 'package:geolocator/geolocator.dart';
import 'dart:async';

class DistanceTracker {
  Position _currentPosition;
  double _totalDistance;
  var _isTrackingDistance;
  List<Position> positions;
  Timer timer;
  Duration timerInterval;

  //Constructor
  DistanceTracker() {
    _totalDistance = 0;
    _isTrackingDistance = false;
    positions.clear();
    timerInterval = Duration(seconds: 5);
    timer = Timer.periodic(timerInterval, AddDistance);
  }

  void StartTrackingDistance() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    positions.add(_currentPosition);
    _isTrackingDistance = true;
  }

  void PauseDistanceTracking() async {
    _isTrackingDistance = false;
  }

  void StopTrackingDistance() {
    _totalDistance = 0;
    _isTrackingDistance = false;
  }

  //gets called every 5 seconds
  void AddDistance(_) async {
    if (_isTrackingDistance) {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _totalDistance += Geolocator.distanceBetween(
          positions.last.latitude,
          positions.last.longitude,
          _currentPosition.latitude,
          _currentPosition.longitude);
      positions.add(_currentPosition);
    }
  }

  String PrintDistanceInMiles() {
    return (_totalDistance / 1609).toStringAsFixed(2);
  }
}
