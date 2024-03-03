import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:uuid/uuid.dart';

class PostJobController extends GetxController{

  Rx<String> companyName = ''.obs;
  Rx<String> jobLocation = ''.obs;
  Rx<String> jobTitle = ''.obs;
  Rx<String> jobType = ''.obs;
  Rx<String> packageStarterRange = ''.obs;
  Rx<String> packageEndRange = ''.obs;
  Rx<String> endDate = ''.obs;
  Rx<String> desc = ''.obs;
  Rx<String> uploadDocs = ''.obs;

  JobController jobController = Get.find<JobController>();

  //To upload logo of the company
  void uploadPhoto() {

  }

  //To upload pdf docs
  void uploadDocuments() {

  }

  String generateRandomId(){
    var uuid = Uuid();
    String randomId = uuid.v4();
    return randomId;
  }

  void createJobPost(){
    String randomId = generateRandomId();
    final JobPost jobPost = JobPost(
        companyName: companyName.value,
        jobId: randomId,
        positionOffered: jobTitle.value,
        package: [packageStarterRange.value, packageEndRange.value ?? ''],
        endDate: endDate.value,
        jobType: jobType.value,
        jobLocation: jobLocation.value,
        filters: []
    );
    jobController.jobs.add(jobPost);
    AppWriteDb.createJobCollection(jobPost);
    AppWriteDb.createJob(jobPost);
  }
}