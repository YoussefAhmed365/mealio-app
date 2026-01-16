import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/authentication/presentation/models/user.dart';
import 'package:mealio/src/core/router/app_router.dart';

class AuthService {
  // Use authintication along the app
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Initialize storage
  final _storage = const FlutterSecureStorage();

  String? get baseUrl => dotenv.env['API_BASE_URL'];

  // Login
  Future<User?> login(String email, String password) async {
    if (baseUrl == null) throw Exception("API_BASE_URL not set");

    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Get & store token localy from response
      final responseData = jsonDecode(response.body);
      final token = responseData['token'] as String?;
      if (token != null) await _saveToken(token);

      // Fetch user profile
      if (responseData != null) {
        final user = User.fromJson(responseData);
        return user;
      }

      router.go('/home');
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Login failed');
    }
    return null;
  }

  // Signup
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
      if (token != null) await _saveToken(token);

      if (responseData != null) {
        final user = User.fromJson(responseData);
        router.go('/onboarding', extra: user);
        return null;
      }
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Signup failed');
    }
    return null;
  }

  // Logout
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
      await _storage.delete(key: 'authToken');
      router.go("/login");
    }
  }

  // Fetch user profile
  Future<User?> getUserProfile() async {
    if (baseUrl == null) throw Exception("API_BASE_URL not set");

    final token = await getToken();
    if (token == null) {
      await logout();
      return null;
    }

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

  // Save Preferences
  Future<void> completeOnboarding(dynamic onboardingData) async {
    if (baseUrl == null) throw Exception("API_BASE_URL not set");

    final url = Uri.parse('$baseUrl/meals');
    try {
      await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({''}),
      );
    } catch (e) {
      print("Error while saving preferences: $e");
    }
  }

  // Save token handler
  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  // Get token handler
  Future<String?> getToken() async {
    return await _storage.read(key: 'authToken');
  }
}
