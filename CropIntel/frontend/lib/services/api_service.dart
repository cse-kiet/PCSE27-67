import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_constants.dart';


class ApiService {
  static String get baseUrl => ApiConstants.baseUrl;


  // =========================
  // DISEASE PREDICTION
  // =========================

  static Future<http.Response> predictDisease(
    Uint8List imageBytes,
    String fileName,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/disease/predict'),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: fileName,
      ),
    );

    final streamedResponse = await request.send();

    return http.Response.fromStream(streamedResponse);
  }


  // =========================
  // PRICE PREDICTION
  // =========================

  static Future<http.Response> predictPrice({
    required String state,
    required String district,
    required String market,
    required String commodity,
    required String variety,
    required String grade,
    required String date,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/price/predict'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'state': state,
        'district': district,
        'market': market,
        'commodity': commodity,
        'variety': variety,
        'grade': grade,
        'date': date,
      }),
    );

    return response;
  }


  // =========================
  // SIGNUP
  // =========================

  static Future<http.Response> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        'token',
        data['access_token'],
      );
    }

    return response;
  }


  // =========================
  // LOGIN
  // =========================

  static Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
        'token',
        data['access_token'],
      );
    }

    return response;
  }


  // =========================
  // GET TOKEN
  // =========================

  static Future<String?> getToken() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString('token');
  }


  // =========================
  // LOGOUT
  // =========================

  static Future<void> logout() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove('token');
  }
}