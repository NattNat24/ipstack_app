import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/ip_info_adapter.dart';
import 'screens/ip_list_screen.dart';
import 'screens/favorites_screen.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Carga tu archivo .env antes de cualquier acceso a DotEnv
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  Hive.registerAdapter(IPInfoAdapter());
  await Hive.openBox<IPInfo>('favorites');

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPStack App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => IPListScreen(),
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
