import 'package:dio/dio.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';

class ApiClient {
  final SessionStorage sessionStorage;
  late final Dio dio;

  ApiClient(this.sessionStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://neurozen-backend-mobile.onrender.com',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await sessionStorage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }
}
