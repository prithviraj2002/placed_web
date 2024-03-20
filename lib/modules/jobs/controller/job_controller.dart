import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/job_model/job_model.dart';

class JobController extends GetxController{
  RxList<JobPost> jobs = <JobPost>[].obs;
  RxDouble highestPackageOffered = 0.0.obs;
  Rx<JobPost> topRecruiter = JobPost(companyName: '', jobId: '', positionOffered: '', package: [], endDate: '', jobType: '', jobLocation: '', filters: [], logoUrl: '', pdfUrl: '').obs;
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllJobs();
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

  void delJob(JobPost jobPost){
    jobs.remove(jobPost);
    AppWriteDb.delJob(jobPost);
  }
}