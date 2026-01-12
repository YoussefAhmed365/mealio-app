import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/models/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  String? get baseUrl => dotenv.env['API_BASE_URL'];

  Future<User?> login(String email, String password) async {
    if (baseUrl == null) throw Exception("API_BASE_URL not set");

    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'] as String?;

      // Save token (if backend sends it, which it should for session)
      // Note: The previous code manually saved authToken.
      // Based on verification, backend sends token in cookie, but maybe we need it explicitly?
      // User added logic to save 'authToken' from response['token'].
      if (token != null) {
        await _saveToken(token);
      }

      if (responseData != null) {
        final user = User.fromJson(responseData);
        await _saveUser(user);
        return user;
      }
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Login failed');
    }
    return null;
  }

  Future<User?> signup(
    String firstname,
    String lastname,
    String email,
    String password,
  ) async {
    if (baseUrl == null) throw Exception("API_BASE_URL not set");

    final url = Uri.parse('$baseUrl/users/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'] as String?;
      if (token != null) {
        await _saveToken(token);
      }

      if (responseData != null) {
        final user = User.fromJson(responseData);
        await _saveUser(user);
        return user;
      }
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Signup failed');
    }
    return null;
  }

  Future<void> logout() async {
    if (baseUrl == null) throw Exception("API_BASE_URL not set");

    final url =
        '$baseUrl/users/logout'; // Corrected route based on verification
    try {
      await http.post(Uri.parse(url));
    } catch (e) {
      // Ignore network error on logout, just clear local session
      print("Logout API call failed: $e");
    } finally {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');
      await prefs.remove('user_data');
    }
  }

  Future<User?> getUserProfile() async {
    if (baseUrl == null) throw Exception("API_BASE_URL not set");

    final token = await getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/users/profile');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer $token', // Assuming Bearer token auth if cookies aren't enough
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return User.fromJson(responseData);
    }
    return null;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    // Serialize user to JSON string for storage
    // We might need toJson in User model.
    // For now, simpler to just re-fetch or rely on token.
    // Adding primitive toJson here if needed or just storing separate fields.
  }
}
