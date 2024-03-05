import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/job_model/job_model.dart';

class JobController extends GetxController{
  RxList<JobPost> jobs = <JobPost>[].obs;
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllJobs();
  }

  Future<void> getAllJobs() async{
    jobs.value = await AppWriteDb.getAllJobs();
    isLoading = false;
  }
}