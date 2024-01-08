import 'package:flutter/material.dart';

import '../models/attraction.dart';
import '../services/database_service.dart';

class AttractionProvider with ChangeNotifier {
  final List<Attraction> _attractions = [];
  final DatabaseService _databaseService = DatabaseService();

  List<Attraction> get attractions => _attractions;

  AttractionProvider() {
    loadAttractions();
  }

  Future<void> addNewAttraction(Attraction newAttraction) async {
    await _databaseService.addAttraction(newAttraction);
    await loadAttractions(); // Reload attractions to update the list
  }
  
  Future<void> loadAttractions() async {
    _attractions.clear();
    _attractions.addAll(await _databaseService.getAttractions());
    notifyListeners();
  }

// Add methods for add, update, and delete
// Call notifyListeners() after each operation
}
