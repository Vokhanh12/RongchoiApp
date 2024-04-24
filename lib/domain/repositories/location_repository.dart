import 'package:rongchoi_app/domain/utils/location.dart';

/// Handles operations related to location services.
abstract class LocationRepository {
  /// Retireves the [User]'s current [Location].
  Future<Location> getLocation();

  /// Returns an [Observable] that fires every `5 seconds` with new [Location] data.
  //Stream<lib.LocationData> onLocationChanged();

  /// Requests `Location` permissions to be granted by the user.
  void enableDevice();
}