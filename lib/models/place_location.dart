class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  static PlaceLocation withoutAddress(
    double latitude,
    double longitude,
  ) {
    return PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: '',
    );
  }
}
