import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/patient_services.dart';

final recentPatientsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final data = await dbGetRecentPatients();
  return data;
});
