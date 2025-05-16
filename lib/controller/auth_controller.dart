// lib/services/auth_service.dart

import 'package:hrm_project/res/imports.dart';

import 'package:http/http.dart' as http;







class AuthController {
  Future<Map<String, dynamic>?> fetchLatLong() async {
  const email = 'arbaj.shaikh2034@gmail.com';
  final url = Uri.parse('http://192.168.1.47:8282/api/subadmin/subadmin-by-email/arbaj.shaikh2034@gmail.com');

  try {
    final response = await http.get(url);

    final data = jsonDecode(response.body);
    print("data");

    if (data is Map && data.containsKey('latitude') && data.containsKey('longitude')) {
      return {
        'latitude': data['latitude'] ?? '',
        'longitude': data['longitude'] ?? '',
      };
    } else {
      print('Response does not contain valid latitude/longitude.');
      return null;
    }
  } catch (e) {
    print('Error fetching or decoding lat/long: $e');
    return null;
  }
}
 
  Future<Map<String, dynamic>?> loginEmployee(String email, String password) async {
    final url = Uri.parse(
        'http://192.168.1.36:8282/api/employee/login-employee?email=$email&password=$password');

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
            await saveCredentials(email, password);

         print('login: ${response.statusCode}');

        return jsonDecode(response.body);
        

      } else {
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
  Future<List<Map<String, dynamic>>> fetchRecordsFromApi() async {
    String name = "rushi kapse";
String encodedName = Uri.encodeComponent(name);
  final url = Uri.parse('http://192.168.1.36:8282/api/employee/2/$encodedName/attendance/all');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load attendance records');
  }
}


  Future<void> saveCredentials(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  await prefs.setString('password', password);
}
Future<void> clearCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('email');
  await prefs.remove('password');
}

}

