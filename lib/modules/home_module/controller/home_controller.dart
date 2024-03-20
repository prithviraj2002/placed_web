import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:excel/excel.dart';

class HomeController extends GetxController {
  RxList<Profile> profiles = <Profile>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;

  @override
  void onInit() {
    super.onInit();
    getProfiles();
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


  //void exportToExcel() {
  //   var excel = Excel.createExcel();
  //   var sheet = excel['Master Data'];
  //   List<TextCellValue> dataRow = [];
  //
  //   sheet.appendRow([
  //     const TextCellValue('Name'),
  //     const TextCellValue('IU Number'),
  //     const TextCellValue('Email'),
  //     const TextCellValue('Branch'),
  //     const TextCellValue('Semester'),
  //     const TextCellValue('CGPA'),
  //   ]);
  //
  //   for (var profile in profiles) {
  //     for(String value in profile.toList()){
  //       dataRow.add(TextCellValue(value));
  //     }
  //     sheet.appendRow(dataRow);
  //     dataRow = [];
  //   }
  //
  //   excel.save(fileName: 'student_master_data.xlsx');
  // }