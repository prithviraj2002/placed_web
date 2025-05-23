import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dp;
import 'package:placed_web/utils/utils.dart';
import 'package:uuid/uuid.dart';

class AppwriteStorage{
  static Client client = Client()
      .setEndpoint(AppWriteConstants.apiEndPoint)
      .setProject(AppWriteConstants.projectId);
  static Storage storage = Storage(client);

  static dp.Client serverClient = dp.Client()
      .setEndpoint(AppWriteConstants.apiEndPoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: false)
      .setKey(AppWriteConstants.apiKey);
  static dp.Storage serverStorage = dp.Storage(serverClient);

  static Future<File> uploadFile(Uint8List bytes, String jobId, String companyName) async {
    try {
      final response = await storage.createFile(
          bucketId: AppWriteConstants.departmentBucketId,
          fileId: jobId,
          file: InputFile.fromBytes(bytes: bytes, filename: '${companyName} - logo'),
      );
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading image: $e');
      rethrow;
    }
  }

  static uploadDoc(PlatformFile doc, String jobId) async {
    try {
      if (doc.bytes == null) {
        throw Exception("Document bytes are null.");
      }

      List<int> bytes = doc.bytes!;

      final response = await storage.createFile(
          bucketId: AppWriteConstants.departmentBucketId,
          fileId: Utils.reverseString(jobId),
          file: InputFile.fromBytes(bytes: bytes, filename: doc.name));
      return response;
    } on AppwriteException catch(e) {
      print('An error occurred while uploading doc to appwrite storage!: $e');
      rethrow;
    }
  }

  static Future<String> sendDocInBroadcast(PlatformFile doc) async{
    try{
      List<int> bytes = doc.bytes!;

      String id = Uuid().v4();

      final response = await storage.createFile(
          bucketId: AppWriteConstants.departmentBucketId,
          fileId: id,
          file: InputFile.fromBytes(bytes: bytes, filename: doc.name));
      return getDeptDocViewUrl(id);
    } on AppwriteException catch(e) {
      print('An error occurred while uploading doc to broadcast message in appwrite storage!: $e');
      rethrow;
    }
  }

  static Future<String> getResume(String id) async{
    try{
      final File response = await storage.getFile(bucketId: AppWriteConstants.resumeBucketId, fileId: id);
      final String fileId = response.$id;
      final String viewUrl = '${AppWriteConstants.apiEndPoint}/storage/buckets/${AppWriteConstants.resumeBucketId}/files/$fileId/view?project=${AppWriteConstants.projectId}&mode=admin';
      return viewUrl;
    } on AppwriteException catch(e){
      print('An error occurred while getting resume from appwrite storage!');
      rethrow;
    }
  }

  static Future<void> delJobDocs(JobPost jobPost) async{
    try{
      final response = await storage.deleteFile(
          bucketId: AppWriteConstants.departmentBucketId,
          fileId: jobPost.jobId
      ).then((value) {
        storage.deleteFile(bucketId: AppWriteConstants.departmentBucketId, fileId: Utils.reverseString(jobPost.jobId));
      });
    } on AppwriteException catch(e){
      print('An error occurred while deleting job documents!: $e');
      rethrow;
    }
  }

  static String getResumeViewUrl(String fileId) {
    return '${AppWriteConstants.apiEndPoint}/storage/buckets/${AppWriteConstants.resumeBucketId}/files/$fileId/view?project=${AppWriteConstants.projectId}&mode=admin';
  }

  static String getDeptDocViewUrl(String fileId){
    return '${AppWriteConstants.apiEndPoint}/storage/buckets/${AppWriteConstants.departmentBucketId}/files/$fileId/view?project=${AppWriteConstants.projectId}&mode=admin';
  }

  static String getImageViewUrl(String fileId){
    return '${AppWriteConstants.apiEndPoint}/storage/buckets/${AppWriteConstants.imagesBucketId}/files/$fileId/view?project=${AppWriteConstants.projectId}&mode=admin';
  }
}