import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:excel/excel.dart' as ex;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/model/broadcast_model/boradcast_model.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailController extends GetxController{
  
  RxList<Profile> profiles = <Profile>[].obs;
  RxList<BroadcastMessage> announcements = <BroadcastMessage>[].obs;
  late StreamSubscription<RealtimeMessage> subscription;
  String jobId = '';
  bool isLoading = true;
  Rx<bool> isExpanded = false.obs;
  Rx<bool> search = false.obs;
  Rx<PlatformFile> selectedFile = PlatformFile(name: fileName.value, size: fileSize.value).obs;
  static Rx<String> fileName = ''.obs;
  static Rx<int> fileSize = 0.obs;

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

  //Search by name in profiles
  List<Profile> searchByName(String name){
    print('Searching by name!');
    List<Profile> relevantProfiles = [];
    for(Profile p in profiles){
      if(p.name == name){
        relevantProfiles.add(p);
      }
    }
    return relevantProfiles;
  }

  Profile? searchByIU(String IU){
    print('Searching by IU');
    for(Profile p in profiles){
      if(p.IU == IU){
        return p;
      }
    }
    return null;
  }

  Profile? searchByEmail(String email){
    print('Searching by email');
    for(Profile p in profiles){
      if(p.email == email){
        return p;
      }
    }
    return null;
  }

  Profile? searchByMobile(String number){
    print('Searching by number');
    for(Profile p in profiles){
      if(p.phoneNumber == number){
        return p;
      }
    }
    return null;
  }

  List<DataRow> searchData(String search){
    print('Entered search data function in controller');
    List<DataRow> dataRow = [];
    List<Profile> searchProfiles = [];
    List<Profile> prf = searchByName(search);
    if(prf.isNotEmpty){
      for(Profile p in prf){
        searchProfiles.add(p);
        print('Adding profile to list ${p.name}');
      }
    }
    for(int index = 0; index < searchProfiles.length; index++){
      Profile profile = searchProfiles[index];
      dataRow.add(
          DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle
                      ),
                      child: CircleAvatar(
                        radius: 50, // Adjust the radius as needed
                        backgroundColor: Colors.transparent, // Make the background transparent
                        backgroundImage: NetworkImage(AppwriteStorage.getImageViewUrl(profile.id), scale: 10, ),
                      ),
                    )
                ),
                DataCell(Text(profile.name)),
                DataCell(Text(profile.email)),
                DataCell(Text(profile.dateOfBirth)),
                DataCell(Text(profile.IU)),
                DataCell(Text(profile.phoneNumber)),
                DataCell(Text(profile.course)),
                DataCell(Text(profile.degree)),
                DataCell(Text(profile.year.toString())),
                DataCell(Text(profile.sem.toString())),
                DataCell(
                    TextButton(
                        onPressed: () {
                          final Uri _url = Uri.parse(AppwriteStorage.getResumeViewUrl(profile.id));
                          launchUrl(_url);
                        },
                        child: const Text('View resume')
                    )
                )
              ]
          )
      );
      print(searchProfiles.first.name);
    }
    if(searchProfiles.isEmpty){
      dataRow.add(
          DataRow(
              cells: [
                DataCell(Text('No profiles found!')),
              ]
          )
      );
    }
    return dataRow;
  }

  List<DataRow> getDataRow() {
    List<DataRow> dataRow = [];
    for(int index = 0; index < profiles.length; index++){
      Profile profile = profiles[index];
      dataRow.add(
          DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle
                        ),
                        child: CircleAvatar(
                        radius: 50, // Adjust the radius as needed
                        backgroundColor: Colors.transparent, // Make the background transparent
                        backgroundImage: NetworkImage(AppwriteStorage.getImageViewUrl(profile.id), scale: 10, ),
                        ),
                      )
                ),
                DataCell(Text(profile.name)),
                DataCell(Text(profile.email)),
                DataCell(Text(profile.dateOfBirth)),
                DataCell(Text(profile.IU)),
                DataCell(Text(profile.phoneNumber)),
                DataCell(Text(profile.course)),
                DataCell(Text(profile.degree)),
                DataCell(Text(profile.year.toString())),
                DataCell(Text(profile.sem.toString())),
                DataCell(
                    TextButton(
                        onPressed: () {
                          final Uri _url = Uri.parse(AppwriteStorage.getResumeViewUrl(profile.id));
                          launchUrl(_url);
                        },
                        child: const Text('View resume')
                    )
                )
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

  void sendAnnouncement(String message, JobPost jobPost) async{
    String pdfUrl = '';
    if(selectedFile.value.name.isNotEmpty){
      AppwriteStorage.sendDocInBroadcast(selectedFile.value).then((String pdfUrl) {
        BroadcastMessage msg = BroadcastMessage(
            message: message, date: DateTime.now().toIso8601String(),
            time: DateTime.now().toIso8601String(), jobId: jobPost.jobId, pdfUrl: pdfUrl);
        announcements.add(msg);
        AppWriteDb.sendBroadCastMessage(msg);
      });
    } else if(selectedFile.value.name.isEmpty){
      BroadcastMessage msg = BroadcastMessage(
          message: message, date: DateTime.now().toIso8601String(),
          time: DateTime.now().toIso8601String(), jobId: jobPost.jobId, pdfUrl: pdfUrl);
      announcements.add(msg);
      AppWriteDb.sendBroadCastMessage(msg);
    }
  }

  Future<void> uploadDocuments() async{
    selectedFile.value = (await Utils.pickDocs())!;
    fileName.value = selectedFile.value.name;
    fileSize.value = selectedFile.value.size;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    stopListeningToProfiles();
  }

  void exportToExcel(String jobName) {
    var excel = ex.Excel.createExcel();
    var sheet = excel[jobName];
    List<ex.TextCellValue> dataRow = [];

    sheet.appendRow([
      const ex.TextCellValue('Name'),
      const ex.TextCellValue('Email'),
      const ex.TextCellValue('IU Number'),
      const ex.TextCellValue('Gender'),
      const ex.TextCellValue('Contact Number'),
      const ex.TextCellValue('Date of Birth'),
      const ex.TextCellValue('Address'),
      const ex.TextCellValue('Branch'),
      const ex.TextCellValue('Semester'),
      const ex.TextCellValue('Year'),
      const ex.TextCellValue('Year of passing'),
      const ex.TextCellValue('CGPA'),
      const ex.TextCellValue('Active Backlogs'),
      const ex.TextCellValue('Total Backlogs'),
      const ex.TextCellValue('Degree'),
      const ex.TextCellValue('10th Marks'),
      const ex.TextCellValue('10th Passing year'),
      const ex.TextCellValue('12th Marks'),
      const ex.TextCellValue('12th Passing year'),
      const ex.TextCellValue('Board'),
      const ex.TextCellValue('Resume'),
    ]);

    for (var profile in profiles) {
      for(String value in profile.toList()){
        dataRow.add(ex.TextCellValue(value));
      }
      sheet.appendRow(dataRow);
      dataRow = [];
    }

    excel.save(fileName: '${jobName}.xlsx');
  }
}