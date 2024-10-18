import 'package:flutter/material.dart';
import 'services/album_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  void _loadAlbums() async {
    // ignore: unused_local_variable
    final albums = await AlbumService.generateAlbums(count: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tintin Albums'),
      ),
      body: const Center(
        child: Text('Albums chargés dans la console'),
      ),
    );
  }
}
