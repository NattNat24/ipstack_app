import 'package:hive/hive.dart';

part 'ip_info_adapter.g.dart';

@HiveType(typeId: 0)
class IPInfo extends HiveObject {
  @HiveField(0)
  String ip;

  @HiveField(1)
  String city;

  @HiveField(2)
  String countryName;

  @HiveField(3)
  double latitude;

  @HiveField(4)
  double longitude;

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
      city: json['city'] ?? '',
      countryName: json['country_name'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}
