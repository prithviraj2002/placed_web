import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dp;

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

  static Future<File> uploadLogo(String imagePath, JobPost jobPost) async {
    try {
      final response = await storage.createFile(
          bucketId: AppWriteConstants.logosBucketId,
          fileId: jobPost.jobId,
          file: InputFile.fromPath(path: imagePath, filename: '${jobPost.companyName} - logo'));
      return response;
    } on AppwriteException catch (e) {
      print('An Exception occurred while uploading image: $e');
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

  static String getResumeViewUrl(String fileId) {
    return '${AppWriteConstants.apiEndPoint}/storage/buckets/${AppWriteConstants.resumeBucketId}/files/$fileId/view?project=${AppWriteConstants.projectId}&mode=admin';
  }

  static String getLogoViewUrl(String fileId){
    return '${AppWriteConstants.apiEndPoint}/storage/buckets/${AppWriteConstants.logosBucketId}/files/$fileId/view?project=${AppWriteConstants.projectId}&mode=admin';
  }

  static String getImageViewUrl(String fileId){
    return '${AppWriteConstants.apiEndPoint}/storage/buckets/${AppWriteConstants.imagesBucketId}/files/$fileId/view?project=${AppWriteConstants.projectId}&mode=admin';
  }
}