import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../DatabaseManagement/attractionModel.dart';

final attractionProvider =
    StateNotifierProvider<AttractionNotifier, Attraction>((ref) {
  return AttractionNotifier();
});

class AttractionNotifier extends StateNotifier<Attraction> {
  AttractionNotifier()
      : super(Attraction(
          name: 'Default Name',
          description: 'Default Description',
          coordinates: LatLng(0.0, 0.0),
        ));

  static Attraction _initialAttraction() {
    return Attraction(
      name: '',
      description: '',
      coordinates: LatLng(0.0, 0.0), // Default coordinates, change as needed
      photo: null, // Assuming no default photo
    );
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setCoordinates(LatLng coordinates) {
    state = state.copyWith(coordinates: coordinates);
  }

  void setPhoto(LatLng coordinates) {
    state = state.copyWith(coordinates: coordinates);
  }

  void reset() {
    state = _initialAttraction();
  }
}
