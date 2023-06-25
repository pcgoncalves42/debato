import 'package:get/get.dart';
import '../controllers/debate_controller.dart';

class DebateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebateController>(() {
      return DebateController();
    });
  }
}