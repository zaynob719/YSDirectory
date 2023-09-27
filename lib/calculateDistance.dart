// import 'package:geolocator/geolocator.dart';

// double calculateDistance(
//     double userLat, double userLng, double salonLat, double salonLng) {
//   return Geolocator.distanceBetween(userLat, userLng, salonLat, salonLng);
// }

import 'package:geolocator/geolocator.dart';

double calculateDistance(
    double userLat, double userLng, double salonLat, double salonLng) {
  double distanceInMeters =
      Geolocator.distanceBetween(userLat, userLng, salonLat, salonLng);
  double distanceInMiles = distanceInMeters / 1609.344;
  return distanceInMiles;
}
