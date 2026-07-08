import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neurozen_front/core/network/api_client.dart';
import 'package:neurozen_front/core/network/api_routes.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SessionStorage storage;

  AuthRepository({required this.apiClient, required this.storage});

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    final body = {'username': username.trim(), 'password': password};

    try {
      final res = await apiClient.dio.post(ApiRoutes.signIn, data: body);
      final raw = res.data;

      Map<String, dynamic> data;
      if (raw is Map<String, dynamic>) {
        data = raw;
      } else if (raw is Map) {
        data = raw.map((k, v) => MapEntry(k.toString(), v));
      } else if (raw is String) {
        data = jsonDecode(raw) as Map<String, dynamic>;
      } else {
        throw Exception('Formato inesperado sign-in: ${raw.runtimeType}');
      }

      // Backend real: { id, username, email, token }
      final token = (data['token'] ?? data['Token'])?.toString();
      final userId = (data['id'] ?? data['Id'])?.toString();

      if (token == null || token.isEmpty) {
        throw Exception('No vino token en response: $data');
      }
      if (userId == null || userId.isEmpty) {
        throw Exception('No vino id en response: $data');
      }

      await storage.saveSession(token: token, userId: userId);
    } on DioException catch (e) {
      throw Exception(
        'LOGIN_DIO type=${e.type} status=${e.response?.statusCode} data=${e.response?.data}',
      );
    } catch (e) {
      throw Exception('LOGIN_UNKNOWN error=$e');
    }
  }

  Future<void> signUp({
    required String username,
    required String password,
    required String email,
  }) async {
    await apiClient.dio.post(
      ApiRoutes.signUp,
      data: {'username': username, 'password': password, 'email': email},
    );
  }

  Future<void> logout() async {
    await storage.clearSession();
  }
}
