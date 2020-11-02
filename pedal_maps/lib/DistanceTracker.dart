import 'package:geolocator/geolocator.dart';

class DistanceTracker {
  Position _currentPosition;
  double _totalDistance;
  var _isTrackingDistance;
  List<Position> positions;

  //Constructor
  DistanceTracker() {
    double _totalDistance = 0;
    var _isTrackingDistance = false;
    positions.clear();
  }

  void StartTrackingDistance() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    positions.add(_currentPosition);
    _isTrackingDistance = true;
  }

  void PauseDistanceTracking() async {
    addDistance();
    _isTrackingDistance = false;
  }

  void StopTrackingDistance() {
    _totalDistance = 0;
    _isTrackingDistance = false;
  }

  void addDistance() async {
    if (_isTrackingDistance) {
      if (int.parse('5') % 5 == 0) {
        //update distance every 5 seconds
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
  }

  String PrintDistanceInMiles() {
    return (_totalDistance / 1609).toStringAsFixed(2);
  }
}
