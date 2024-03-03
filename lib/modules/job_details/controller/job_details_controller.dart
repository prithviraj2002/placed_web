import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';

class JobDetailController extends GetxController{
  
  RxList<Profile> profiles = <Profile>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;
  String jobId = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    listenToProfiles();
  }

  void getProfiles(String jobId) async{
    profiles.value = await AppWriteDb.getProfilesFromJobId(jobId);
    jobId = jobId;
  }

  void listenToProfiles(){
    final realtime = Realtime(AppWriteDb.client);
    subscription = realtime
        .subscribe([
      "databases.${AppWriteConstants.dbID}.collections.${jobId}.documents"
    ])
        .stream
        .listen((event) {
      if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${jobId}.documents.*.create")) {
        getProfiles(jobId);
      } else if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${jobId}.documents.*.delete")) {
        getProfiles(jobId);
      }
    });
  }

  void stopListeningToProfiles(){
    subscription.cancel();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    stopListeningToProfiles();
  }
}