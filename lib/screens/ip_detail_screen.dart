import 'package:flutter/material.dart';
import '../models/ip_info.dart';

class IPDetailScreen extends StatelessWidget {
  final IPInfo info;

  IPDetailScreen({required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de ${info.ip}')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IP: ${info.ip}', style: TextStyle(fontSize: 18)),
            Text('Ciudad: ${info.city}'),
            Text('País: ${info.countryName}'),
            Text('Latitud: ${info.latitude}'),
            Text('Longitud: ${info.longitude}'),
          ],
        ),
      ),
    );
  }
}

