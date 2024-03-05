import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/broadcast_model/boradcast_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';

class JobDetailController extends GetxController{
  
  RxList<Profile> profiles = <Profile>[].obs;
  RxList<BroadcastMessage> announcements = <BroadcastMessage>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;
  String jobId = '';
  bool isLoading = true;
  Rx<bool> isExpanded = false.obs;

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
    isLoading = false;
    jobId = jobId;
  }

  List<DataRow> getDataRow() {
    List<DataRow> dataRow = [];
    for(int index = 0; index < profiles.length; index++){
      Profile profile = profiles[index];
      dataRow.add(
          DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(profile.name)),
                DataCell(Text(profile.email)),
                DataCell(Text(profile.dateOfBirth)),
                DataCell(Text(profile.IU)),
                DataCell(Text(profile.phoneNumber)),
                DataCell(Text(profile.course)),
                DataCell(Text(profile.degree)),
                DataCell(Text(profile.year.toString())),
                DataCell(Text(profile.sem.toString())),
              ]
          )
      );
    }
    return dataRow;
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

  Future<void> getAnnouncements(String jobId) async{
    announcements.value = await AppWriteDb.getBroadCastMessagesById(jobId);
  }

  void sendAnnouncement(BroadcastMessage msg){
    announcements.add(msg);
    AppWriteDb.sendBroadCastMessage(msg);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    stopListeningToProfiles();
  }

  void exportToExcel() {}
}