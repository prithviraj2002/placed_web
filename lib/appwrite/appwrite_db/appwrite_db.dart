import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';

class AppWriteDb {
  static Client client = Client()
      .setEndpoint(AppWriteConstants.apiEndPoint)
      .setProject(AppWriteConstants.projectId);

  static Databases databases = Databases(client);

  static Future<DocumentList> getProfilesFromDB() async {
    try {
      final DocumentList response = await databases.listDocuments(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.profileCollectionsId);
      return response;
    } on AppwriteException catch (e) {
      rethrow;
    }
  }
}
