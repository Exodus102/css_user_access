import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchDataOfficeService {
  static const String baseUrl =
      "http://192.168.1.53/database/office/get_office.php";
  static Future<List<String>> fetchColleges() async {
    final response = await http.get(Uri.parse("$baseUrl/get_offices.php"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data["offices"]);
    } else {
      throw Exception("Failed to load offices");
    }
  }
}
