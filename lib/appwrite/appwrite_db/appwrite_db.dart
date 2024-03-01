import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/model/broadcast_model/boradcast_model.dart';

class AppWriteDb {
  static Client client = Client()
      .setEndpoint(AppWriteConstants.apiEndPoint)
      .setProject(AppWriteConstants.projectId);

  static Databases databases = Databases(client);

  //To get profiles from database.
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

  //Send a broadcast message to a job on its id.
  static Future<Document> sendBroadCastMessage(BroadCastMessage msg) async {
    try {
      final response = await databases.createDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.broadcastCollectionsId,
          documentId: ID.unique(),
          data: msg.toMap());
      return response;
    } on AppwriteException catch (e) {
      rethrow;
    }
  }
}
