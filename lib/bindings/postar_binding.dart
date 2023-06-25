import 'package:get/get.dart';
import '../controllers/postar_controller.dart';

class PostarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostarController>(() {
      return PostarController();
    });
  }
}