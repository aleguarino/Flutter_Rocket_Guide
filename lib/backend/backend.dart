import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class Backend {
  final String hostUrl;

  const Backend(this.hostUrl);

  Future<List<Rocket>> getRockets() async {
    final url = '$hostUrl/rockets';
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final jsonData = json.decode(response.body) as List;

    return jsonData.map((json) => Rocket.fromMap(json)).toList();
  }
}

class Rocket {
  final String id;
  final String name;
  final String description;
  final bool active;
  final int boosters;
  final List<String> flickrImages;
  final String wikipedia;
  final DateTime firstFlight;
  final double height;
  final double diameter;
  final double mass;

  const Rocket({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.active,
    @required this.boosters,
    @required this.flickrImages,
    @required this.wikipedia,
    @required this.firstFlight,
    @required this.height,
    @required this.diameter,
    @required this.mass,
  });

  factory Rocket.fromMap(Map<String, dynamic> json) => Rocket(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        active: json['active'],
        boosters: json['boosters'],
        flickrImages: List<String>.from(json['flickr_images']),
        wikipedia: json['wikipedia'],
        firstFlight: DateTime.parse(json['first_flight']),
        height: (json['height']['meters'] as num).toDouble(),
        diameter: (json['diameter']['meters']).toDouble(),
        mass: (json['mass']['kg']).toDouble(),
      );
}
