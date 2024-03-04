import 'package:get/get.dart';
import 'package:placed_web/modules/home_module/controller/home_controller.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:placed_web/modules/post_a_job_module/controller/post_job_controller.dart';
import 'package:placed_web/modules/post_a_job_module/view/post_a_job.dart';
import 'package:placed_web/modules/students/controller/students_controller.dart';

class PageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<JobController>(() => JobController());
    Get.lazyPut<PostJobController>(() => PostJobController());
    Get.lazyPut<JobDetailController>(() => JobDetailController());
    Get.lazyPut<StudentsController>(() => StudentsController());
  }
}