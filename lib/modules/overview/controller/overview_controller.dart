import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';

class OverviewController extends GetxController{
  RxList<Profile> profiles = <Profile>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;
  RxList<JobPost> jobs = <JobPost>[].obs;
  RxDouble highestPackageOffered = 0.0.obs;
  Rx<JobPost> topRecruiter = JobPost(companyName: '', jobId: '', positionOffered: '', package: [], endDate: '', jobType: '', jobLocation: '', filters: [], logoUrl: '', pdfUrl: '').obs;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getProfiles();
    getAllJobs();
    listenToJobs();
    listenToProfiles();
  }

  Future<void> getProfiles() async {
    DocumentList listOfProfiles;
    listOfProfiles = await AppWriteDb.getProfilesFromDB();
    for (Document d in listOfProfiles.documents) {
      profiles.add(Profile.fromJson(d.data, d.$id));
    }
  }

  void listenToProfiles() {
    final realtime = Realtime(AppWriteDb.client);
    subscription = realtime
        .subscribe([
      "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents"
    ])
        .stream
        .listen((event) {
      if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents.*.create")) {
        profiles.add(Profile.fromJson(event.payload, event.payload["\$id"]));
      } else if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents.*.delete")) {
        getProfiles();
      }
    });
  }

  void listenToJobs() {
    final realtime = Realtime(AppWriteDb.client);
    subscription = realtime
        .subscribe([
      "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.jobsCollectionId}.documents"
    ])
        .stream
        .listen((event) {
      if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.jobsCollectionId}.documents.*.create")) {
        jobs.add(JobPost.fromJson(event.payload, event.payload["\$id"]));
        getAllJobs();
      } else if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.jobsCollectionId}.documents.*.delete")) {
        getAllJobs();
      }
    });
  }

  Future<void> getAllJobs() async{
    double highestPackage = 0.0;
    JobPost jobPost = JobPost(companyName: '', jobId: '', positionOffered: '', package: [], endDate: '', jobType: '', jobLocation: '', filters: [], logoUrl: '', pdfUrl: '');
    jobs.value = await AppWriteDb.getAllJobs();
    for(JobPost job in jobs){
      if(job.package.length == 2 && highestPackage < job.package.last){
        highestPackage = job.package.last;
        jobPost = job;
      }
      else if(job.package.length == 1 && highestPackage < job.package.first){
        highestPackage = job.package.first;
        jobPost = job;
      }
    }
    highestPackageOffered.value = highestPackage;
    topRecruiter.value = jobPost;
    isLoading = false;
  }

  void closeSubscription() {
    subscription.cancel();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    closeSubscription();
  }
}