import 'package:coveredncurly/data/api/repository/popular_salon_repo.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

//food video
class PopularSalonController extends GetxController {
  final PopularSalonRepo popularSalonRepo;
  PopularSalonController({required this.popularSalonRepo});
  List<dynamic> _popularSalonList = [];
  List<dynamic> get popularSalonList => _popularSalonList;

  Future<void> getPopularSalonList() async {
    Response response = await popularSalonRepo.getPopularSalonList();
    if (response.statusCode == 200) {
      _popularSalonList = [];
      //_popularSalonList.addAll();
      update();
    } else {}
  }
}
