//import 'package:YSDirectory/models/locationData.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  LocationData? _locationData;
  String? _currentAddress;

  LocationData? get locationData => _locationData;
  String? get currentAddress => _currentAddress;

  void updateLocation(LocationData? location) {
    _locationData = location;
    updateCurrentAddress();
    notifyListeners();
  }

  Future<void> updateCurrentAddress() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        _locationData!.latitude!,
        _locationData!.longitude!,
      );
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        _currentAddress =
            '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      } else {
        _currentAddress = 'No address available';
      }
    } catch (e) {
      print('Failed to get current address: $e');
      _currentAddress = 'Error retrieving address';
    }
  }
}
