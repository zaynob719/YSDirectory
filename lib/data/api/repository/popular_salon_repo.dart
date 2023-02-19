import 'package:coveredncurly/data/api/api_client.dart';
import 'package:get/get.dart';

class PopularSalonRepo extends GetxService {
  final ApiClient apiClient;
  PopularSalonRepo({required this.apiClient});

  Future<Response> getPopularSalonList() async {
    return await apiClient.getData("end point url");
  }
}
