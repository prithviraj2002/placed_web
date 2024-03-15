import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/model/broadcast_model/boradcast_model.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:placed_web/placed_response/placed_response.dart';
import 'package:placed_web/utils/utils.dart';
import 'package:uuid/uuid.dart';

class PostJobController extends GetxController{

  Rx<String> companyName = ''.obs;
  Rx<String> jobLocation = ''.obs;
  Rx<String> jobTitle = ''.obs;
  Rx<String> jobType = ''.obs;
  Rx<String> packageStarterRange = ''.obs;
  Rx<String> packageEndRange = ''.obs;
  Rx<String> endDate = ''.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<String> desc = ''.obs;
  Rx<String> uploadDocs = ''.obs;
  static Rx<String> imagePath = ''.obs;
  Rx<Uint8List> bytes = Uint8List(0).obs;
  Rx<XFile?> selectedPhoto = XFile(imagePath.value).obs;
  Rx<PlatformFile> selectedFile = PlatformFile(name: fileName.value, size: fileSize.value).obs;
  static Rx<String> fileName = ''.obs;
  static Rx<int> fileSize = 0.obs;

  JobController jobController = Get.find<JobController>();

  //To upload logo of the company
  Future<void> uploadPhoto() async{
    bytes.value = await Utils.pickLogo();
  }

  //To upload pdf docs
  Future<void> uploadDocuments() async{
    selectedFile.value = (await Utils.pickDocs())!;
    fileName.value = selectedFile.value.name;
    fileSize.value = selectedFile.value.size;
  }

  String generateRandomId(){
    var uuid = Uuid();
    String randomId = uuid.v4();
    return randomId;
  }

  Future<PlacedResponse> createJobPost() async{
    String randomId = generateRandomId();
    AppwriteStorage.uploadFile(bytes.value, randomId, companyName.value);
    AppwriteStorage.uploadDoc(selectedFile.value, randomId);
    print('This is the pdf view url: ${AppwriteStorage.getDeptDocViewUrl(Utils.reverseString(randomId))}');
    final JobPost jobPost = JobPost(
        companyName: companyName.value,
        description: desc.value,
        jobId: randomId,
        positionOffered: jobTitle.value,
        package: [packageStarterRange.value, packageEndRange.value ?? ''],
        endDate: endDate.value,
        jobType: jobType.value,
        jobLocation: jobLocation.value,
        filters: [],
      logoUrl: AppwriteStorage.getDeptDocViewUrl(randomId),
      pdfUrl: AppwriteStorage.getDeptDocViewUrl(Utils.reverseString(randomId))
    );
    jobController.jobs.add(jobPost);
    AppWriteDb.createJobCollection(jobPost);
    PlacedResponse response = await AppWriteDb.createJob(jobPost);
    sendSystemGenMsg(randomId, companyName.value);
    fileName.value = '';
    fileSize.value = 0;
    selectedFile.value = PlatformFile(name: fileName.value, size: fileSize.value);
    bytes.value = Uint8List(0);
    return response;
  }

  void sendSystemGenMsg(String jobId, String companyName){
    print('Sending broadcast message!: ${companyName}');
    final BroadcastMessage msg = BroadcastMessage(
        message: '$companyName invites your application! This is a system generated announcement. You will receive all the announcements from T&P department here.',
        date: DateTime.now().toString(),
        time: DateTime.now().toString(),
        jobId: jobId,
      pdfUrl: '',
    );
    AppWriteDb.sendBroadCastMessage(msg);
  }
}