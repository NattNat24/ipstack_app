import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/ip_info_adapter.dart';
import 'ip_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final Box<IPInfo> favoritesBox = Hive.box<IPInfo>('favorites');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: ValueListenableBuilder(
        valueListenable: favoritesBox.listenable(),
        builder: (context, Box<IPInfo> box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No hay favoritos.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index)!;
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
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    box.deleteAt(index);
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
