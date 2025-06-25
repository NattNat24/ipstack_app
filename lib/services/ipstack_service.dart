import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/ip_info.dart';

class IPStackService {
  final String accessKey = dotenv.env['IPSTACK_API_KEY'] ?? '';

  Future<IPInfo> fetchIPInfo(String ip) async {
    final url = Uri.parse('http://api.ipstack.com/$ip?access_key=$accessKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("✅ Respuesta de ${ip}: ${response.body}");
      return IPInfo.fromJson(jsonDecode(response.body));
    } else {
      print("❌ Error ${response.statusCode}: ${response.body}");
      throw Exception('Fallo al cargar información');
    }
  }
}
