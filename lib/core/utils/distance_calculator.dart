import 'dart:math';

// 2. Distance Calculation
// For each location reading, compute the distance between the device and the target coordinates
// using the Haversine formula. The result should be expressed in metres or kilometres.
class DistanceCalculator {

  /// Removed Calculation, replaced with Geolocator.distanceBetween(startLat, startLng, endLat, endLng) result in double
  /// 

  static String formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    } else {
      final km = meters / 1000;
      return '${km.toStringAsFixed(2)} km';
    }
  }
}
