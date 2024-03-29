import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:placed_web/modules/students/controller/students_controller.dart';

class OverviewController extends GetxController{
  RxList<Profile> profiles = <Profile>[].obs;
  RxList<Profile> profilesCE = <Profile>[].obs;
  RxList<Profile> profilesCSE = <Profile>[].obs;
  RxList<Profile> profilesIT = <Profile>[].obs;
  RxMap<String, int> rolesOffered = {'': 0}.obs;
  late StreamSubscription<RealtimeMessage> subscription;
  RxList<JobPost> jobs = <JobPost>[].obs;
  RxDouble highestPackageOffered = 0.0.obs;
  Rx<JobPost> topRecruiter = JobPost(companyName: '', jobId: '', positionOffered: '', package: [], endDate: '', jobType: '', jobLocation: '', filters: [], logoUrl: '', pdfUrl: '').obs;
  bool isLoading = true;

  // RxMap<String, int> studentsPerJob = {'' : 0}.obs;

  @override
  void onInit() {
    super.onInit();
    getProfiles();
    getAllJobs();
    listenToJobs();
    listenToProfiles();
    // departmentWiseProfiles();
    getStudentsPerJob();
  }

  Future<Map<String, int>> getStudentsPerJob() async{
    List<JobPost> jobPosts = await AppWriteDb.getAllJobs();
    Map<String, int> studentsPerJob = {'' : 0};
    for(JobPost job in jobPosts){
      studentsPerJob[job.companyName] = await AppWriteDb.getDocsFromCollection(job.jobId);
    }
    return studentsPerJob;
  }

  Future<void> getProfiles() async {
    DocumentList listOfProfiles;
    print('get profiles');
    listOfProfiles = await AppWriteDb.getProfilesFromDB();
    profiles.value = [];
    for (Document d in listOfProfiles.documents) {
      profiles.add(Profile.fromJson(d.data, d.$id));
    }
  }

  // Future<void> departmentWiseProfiles() async{
  //   print('department wise profiles');
  //   List<Profile> profiles = [];
  //   final DocumentList data = await AppWriteDb.getProfilesFromDB();
  //   for(var profile in data.documents){
  //     profiles.add(Profile.fromJson(profile.data, profile.$id));
  //   }
  //   profilesCE.value = [];
  //   profilesIT.value = [];
  //   profilesCSE.value = [];
  //   for(Profile profile in profiles){
  //     if(profile.course == 'CE' || profile.course == 'ce'){
  //       profilesCE.add(profile);
  //     }
  //     else if(profile.course == 'CSE' || profile.course == 'cse'){
  //       profilesCSE.add(profile);
  //     }
  //     else if(profile.course == 'IT' || profile.course == 'it'){
  //       profilesIT.add(profile);
  //     }
  //   }
  // }

  Future<Map<String, int>> getDepartmentWiseProfiles() async{
    int cseCount = 0; int ceCount = 0; int itCount = 0; Map<String, int> profilesPerDepartment = {'': 0};
    await getProfiles();
    for(Profile profile in profiles){
      if(profile.course == 'CE' || profile.course == 'ce'){
        ceCount += 1;
      }
      else if(profile.course == 'CSE' || profile.course == 'cse'){
        cseCount += 1;
      }
      else if(profile.course == 'IT' || profile.course == 'it'){
        itCount += 1;
      }
    }
    profilesPerDepartment['CE'] = ceCount;
    profilesPerDepartment['CSE'] = cseCount;
    profilesPerDepartment['IT'] = itCount;
    return profilesPerDepartment;
  }

  void jobRoles(){
    for(JobPost job in jobs){
      String role = job.positionOffered;
      rolesOffered[role] = (rolesOffered[role] ?? 0) + 1;
    }
  }

  Future<Map<String, int>> getJobRoles() async{
    await getAllJobs();
    Map<String, int> rolesOffered = {'': 0};
    for(JobPost job in jobs){
      String role = job.positionOffered;
      rolesOffered[role] = (rolesOffered[role] ?? 0) + 1;
    }
    return rolesOffered;
  }

  void listenToProfiles() {
    final realtime = Realtime(AppWriteDb.client);
    print('listen to profiles');
    subscription = realtime
        .subscribe([
      "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents"
    ])
        .stream
        .listen((event) {
      if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents.*.create")) {
        // profiles.add(Profile.fromJson(event.payload, event.payload["\$id"]));
        getProfiles();
      } else if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents.*.delete")) {
        getProfiles();
      }
    });
  }

  void listenToJobs() {
    print('listen to jobs');
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
    print('get all jobs');
    JobPost jobPost = JobPost(companyName: '', jobId: '', positionOffered: '', package: [], endDate: '', jobType: '', jobLocation: '', filters: [], logoUrl: '', pdfUrl: '');
    jobs.value = [];
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