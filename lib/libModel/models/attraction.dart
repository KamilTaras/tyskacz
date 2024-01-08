class Attraction {
  final int? id;
  final String title;
  final String photos;
  final String description;
  final double latitude;
  final double longitude;
  final String location;

  Attraction({
    this.id,
    required this.title,
    required this.photos,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'photos': photos,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
    };
  }

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(
      id: json['id'],
      title: json['title'],
      photos: json['photos'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
    );
  }
}
