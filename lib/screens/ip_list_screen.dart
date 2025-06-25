import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../services/ipstack_service.dart';
import '../models/ip_info_adapter.dart';
import 'ip_detail_screen.dart';

class IPListScreen extends StatelessWidget {
  final List<String> ips = [
    '8.8.8.8',
    '134.201.250.155',
    '72.229.28.185',
  ];

  final IPStackService service = IPStackService();

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box<IPInfo>('favorites');

    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de IPs'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ips.length,
        itemBuilder: (context, index) {
          return FutureBuilder<IPInfo>(
            future: service.fetchIPInfo(ips[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListTile(title: Text('Cargando...'));
              } else if (snapshot.hasError) {
                print('ERROR: ${snapshot.error}');
                return ListTile(title: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;
                print('DATO RECIBIDO: ${data.city}, ${data.countryName}');
                return ListTile(
                  title: Text('${data.city}, ${data.countryName}'),
                  subtitle: Text(data.ip),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IPDetailScreen(info: data),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      final alreadyExists = favoritesBox.values.any(
                        (element) => element.ip == data.ip,
                      );

                      if (alreadyExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ya está en favoritos')),
                        );
                      } else {
                        favoritesBox.add(data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Agregado a favoritos')),
                        );
                      }
                    },
                  ),
                );
              } else {
                return ListTile(title: Text('Sin datos'));
              }
            },
          );
        },
      ),
    );
  }
}
