import 'package:neurozen_front/core/network/api_client.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';

class ScheduleRepository {
  final ApiClient apiClient;
  final SessionStorage storage;

  ScheduleRepository({required this.apiClient, required this.storage});

  Future<String> getAvailabilityString() async {
    final userId = await storage.readUserId();
    if (userId == null) throw Exception('No hay userId en sesión');

    try {
      final res = await apiClient.dio.get('/psychologists/$userId');
      final raw = (res.data['availability'] ?? '') as String;
      await storage.saveAvailabilityCache(raw);
      return raw;
    } catch (_) {
      final cached = await storage.readAvailabilityCache();
      if (cached != null) return cached;
      rethrow;
    }
  }

  Future<void> saveAvailabilityString(String raw) async {
    final userId = await storage.readUserId();
    if (userId == null) throw Exception('No hay userId en sesión');

    await apiClient.dio.patch(
      '/psychologists/$userId',
      data: {'availability': raw},
    );

    await storage.saveAvailabilityCache(raw);
  }
}
