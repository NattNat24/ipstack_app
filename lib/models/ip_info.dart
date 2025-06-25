class IPInfo {
  final String ip;
  final String city;
  final String countryName;
  final double latitude;
  final double longitude;

  IPInfo({
    required this.ip,
    required this.city,
    required this.countryName,
    required this.latitude,
    required this.longitude,
  });

  factory IPInfo.fromJson(Map<String, dynamic> json) {
    return IPInfo(
      ip: json['ip'] ?? '',
      city: json['city'] ?? 'Sin ciudad',
      countryName: json['country_name'] ?? 'Sin país',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}
