import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';

class StudentsController extends GetxController{

  RxList<Profile> profiles = <Profile>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllProfiles();
    listenToProfiles();
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

  Future<void> getAllProfiles() async{
    final DocumentList profileList = await AppWriteDb.getProfilesFromDB();
    for(var doc in profileList.documents){
      profiles.add(Profile.fromJson(doc.data, doc.$id));
    }
    isLoading = false;
  }

  void listenToProfiles(){
    final realtime = Realtime(AppWriteDb.client);
    subscription = realtime
        .subscribe([
      "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents"
    ])
        .stream
        .listen((event) {
      if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents.*.create")) {
        getAllProfiles();
      } else if (event.events.contains(
          "databases.${AppWriteConstants.dbID}.collections.${AppWriteConstants.profileCollectionsId}.documents.*.delete")) {
        getAllProfiles();
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

  void exportToExcel() {}
}