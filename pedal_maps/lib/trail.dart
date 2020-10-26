import 'package:geolocator/geolocator.dart';

class Trail {
  double mileage;
  List<Position> positions;

  void AddLocation(Position newL) {
    positions.add(newL);
  }
}
