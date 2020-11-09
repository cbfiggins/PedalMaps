import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DistanceTracker {
  Position _currentPosition;
  double _totalDistance;
  var _isTrackingDistance;
  List<LatLng> positions;
  Timer _timer;
  Duration timerInterval;
  Set<Polyline> _polylines = {};

  //Constructor
  DistanceTracker() {
    _totalDistance = 0;
    _isTrackingDistance = false;
    positions = new List<LatLng>();
    timerInterval = Duration(seconds: 5);
    _timer = Timer.periodic(timerInterval, AddDistance);
  }

  void StartTrackingDistance() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    positions
        .add(LatLng(_currentPosition.latitude, _currentPosition.longitude));
    _isTrackingDistance = true;
  }

  void PauseTrackingDistance() async {
    _isTrackingDistance = false;
  }

  void StopTrackingDistance() {
    _totalDistance = 0;
    positions.clear();
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
      positions
          .add(LatLng(_currentPosition.latitude, _currentPosition.longitude));

      _polylines.add(Polyline(
        polylineId: PolylineId("Where you been"),
        visible: true,
        points: positions,
        color: Colors.blue,
      ));
    }
  }

  Set<Polyline> GetPolylines() {
    return _polylines;
  }

  double PrintDistanceInMiles() {
    return (_totalDistance / 1609);
  }
}
