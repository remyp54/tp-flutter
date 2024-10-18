import 'dart:math';
import '../models/album.dart';
import '../models/gps.dart';

class AlbumService {
  static Future<List<Album>> generateAlbums({int count = 10}) async {
    final random = Random();

    return List.generate(count, (index) {
      return Album(
        title: 'Album ${index + 1}',
        numero: index + 1,
        year: 1930 + random.nextInt(50),
        yearInColor: random.nextBool() ? 1940 + random.nextInt(40) : null,
        image: 'image_${index + 1}.jpg',
        resume: 'Résumé de l\'album ${index + 1}. ' * (1 + random.nextInt(3)),
        gps: GPS(
          latitude: -90 + random.nextDouble() * 180,
          longitude: -180 + random.nextDouble() * 360,
        ),
        location: 'Location ${index + 1}',
      );
    });
  }
}
