import 'package:neurozen_front/core/network/api_client.dart';
import 'package:neurozen_front/core/network/api_routes.dart';

class ProfessionalsRepository {
  final ApiClient apiClient;

  ProfessionalsRepository(this.apiClient);

  Future<List<dynamic>> getAll() async {
    final res = await apiClient.dio.get(ApiRoutes.professionals);
    return res.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getById(String id) async {
    final res = await apiClient.dio.get(ApiRoutes.professionalById(id));
    return Map<String, dynamic>.from(res.data as Map);
  }

  Future<Map<String, dynamic>> createProfessional({
    required String name,
    required String specialty,
    required String availability, // string en BD
    required String experience,
    required int price,
    required int rating,
    required int reviews,
    required String bio,
    required String image,
  }) async {
    final res = await apiClient.dio.post(
      ApiRoutes.professionals,
      data: {
        'name': name,
        'specialty': specialty,
        'availability': availability,
        'experience': experience,
        'price': price,
        'rating': rating,
        'reviews': reviews,
        'bio': bio,
        'image': image,
      },
    );
    return Map<String, dynamic>.from(res.data as Map);
  }
}
