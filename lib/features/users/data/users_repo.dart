import 'package:neurozen_front/core/network/api_client.dart';
import 'package:neurozen_front/core/network/api_routes.dart';

class UsersRepository {
  final ApiClient apiClient;

  UsersRepository(this.apiClient);

  Future<Map<String, dynamic>> getUserById(String id) async {
    final res = await apiClient.dio.get(ApiRoutes.userById(id));
    return Map<String, dynamic>.from(res.data as Map);
  }
}
