import 'package:get/get.dart';
import 'package:placed_web/modules/home_module/controller/home_controller.dart';

class PageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
  }
}