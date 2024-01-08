import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://example.com/api';

  Future<List<dynamic>> getAttractions() async {
    var response = await http.get(Uri.parse('$baseUrl/attractions'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load attractions');
    }
  }

// Other API methods like post, update, delete can be added here
}
