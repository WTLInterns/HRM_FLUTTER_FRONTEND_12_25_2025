// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController {

  
  static Future<Map<String, dynamic>?> fetchLatLong() async {
    const email='arbaj.shaikh2034@gmail.com';
    final url = Uri.parse('http://localhost:8282/api/subadmin/subadmin-by-email/$email');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
          print('API is reachable');
        print('Full Response Body: ${response.body}');
        final data = jsonDecode(response.body);
        
        return {
          'latitude': data['latitude'] ?? '',
          'longitude': data['longitude'] ?? '',
        };
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching lat/long: $e');
      return null;
    }
  }
 


  static Future<Map<String, dynamic>?> fetchSubadminByEmail(String email) async {
    final url = Uri.parse('http://localhost:8282/api/subadmin/subadmin-by-email/$email'); // Use the email parameter

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Full Response Body: ${response.body}');
        final data = jsonDecode(response.body);
        return data; 
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching subadmin data: $e');
      return null;
    }
  }
}



