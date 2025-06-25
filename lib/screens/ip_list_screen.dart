import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../services/ipstack_service.dart';
import '../models/ip_info_adapter.dart';
import 'ip_detail_screen.dart';

class IPListScreen extends StatefulWidget {
  @override
  _IPListScreenState createState() => _IPListScreenState();
}

class _IPListScreenState extends State<IPListScreen> {
  final List<String> ips = [
    '8.8.8.8',
    '134.201.250.155',
    '72.229.28.185',
    '110.174.164.124',
    '186.1.129.130',
    '181.129.104.123',
    '45.33.32.156',
    '201.144.14.1',
    '213.87.141.36',
    '185.199.110.153',
  ];

  final IPStackService service = IPStackService();
  late Future<List<IPInfo?>> futureIPInfos;

  @override
  void initState() {
    super.initState();
    futureIPInfos = fetchAllIPs();
  }

  Future<List<IPInfo?>> fetchAllIPs() async {
    List<IPInfo?> results = [];

    for (int i = 0; i < ips.length; i++) {
      await Future.delayed(Duration(seconds: 1)); // delay de 1 segundo entre llamadas
      try {
        final info = await service.fetchIPInfo(ips[i]);
        results.add(info);
      } catch (e) {
        print('❌ Error al cargar ${ips[i]}: $e');
        results.add(null); // Error: deja el espacio vacío
      }
    }

    return results;
  }

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
      body: FutureBuilder<List<IPInfo?>>(
        future: futureIPInfos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error general: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se pudo cargar ninguna IP.'));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              final ip = ips[index];

              if (item == null) {
                return ListTile(
                  title: Text('❌ Error al cargar $ip'),
                );
              }

              return ListTile(
                title: Text('${item.city}, ${item.countryName}'),
                subtitle: Text(item.ip),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IPDetailScreen(info: item),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    final alreadyExists = favoritesBox.values.any(
                          (element) => element.ip == item.ip,
                    );

                    if (alreadyExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ya está en favoritos')),
                      );
                    } else {
                      favoritesBox.add(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Agregado a favoritos')),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
