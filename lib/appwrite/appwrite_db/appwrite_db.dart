import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dart_appwrite/models.dart' as dpm;
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/model/broadcast_model/boradcast_model.dart';
import 'package:placed_web/model/filter_model/filter_model.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/placed_response/placed_response.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dp;

class AppWriteDb {
  static Client client = Client()
      .setEndpoint(AppWriteConstants.apiEndPoint)
      .setProject(AppWriteConstants.projectId);
  static Databases databases = Databases(client);

  static dp.Client serverClient = dp.Client()
      .setEndpoint(AppWriteConstants.apiEndPoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: false)
      .setKey(AppWriteConstants.apiKey);
  static dp.Databases serverDatabases = dp.Databases(serverClient);

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

  static Future<Document> blockAccount(Profile profile) async{
    try{
      final response = await databases.updateDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.profileCollectionsId,
          documentId: profile.id,
          data: profile.toMap()
      );
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while blocking an account!: $e');
      rethrow;
    }
  }

  static Future<List<Profile>> getProfilesFromJobId(String jobId) async {
    List<Profile> profiles = [];
    try {
      final response = await databases.listDocuments(
          databaseId: AppWriteConstants.dbID, collectionId: jobId);
      for (var profile in response.documents) {
        print(profile.data);
        profiles.add(Profile.fromJson(profile.data, profile.$id));
      }
      return profiles;
    } on AppwriteException catch (e) {
      print('An error occurred while getting profiles from job id! :$e');
      rethrow;
    }
  }

  //get all jobs
  static Future<List<JobPost>> getAllJobs() async {
    final List<JobPost> jobs = [];
    try {
      final response = await databases.listDocuments(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.jobsCollectionId);
      for (var job in response.documents) {
        jobs.add(JobPost.fromJson(job.data, job.$id));
      }
      return jobs;
    } on AppwriteException catch (e) {
      print('An exception occurred while getting jobs from appwrite db!: $e');
      rethrow;
    }
  }

  //To update job post details
  static Future<Document> updateJob(JobPost jobPost) async {
    try {
      final response = await databases.updateDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.jobsCollectionId,
          documentId: jobPost.jobId,
          data: jobPost.toMap());
      return response;
    } on AppwriteException catch (e) {
      print('An error occurred while updating job in appwrite db!');
      rethrow;
    }
  }

  //Delete a job
  static Future<dynamic> delJob(JobPost jobPost) async {
    try {
      DocumentList profileList = await databases.listDocuments(
          databaseId: AppWriteConstants.dbID, collectionId: jobPost.jobId);
      for (var pr in profileList.documents) {
        Profile profile = Profile.fromJson(pr.data, pr.$id);
        profile.appliedJobs!.remove(jobPost.jobId);
      }
      final response = await databases
          .deleteDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.jobsCollectionId,
          documentId: jobPost.jobId)
          .then((value) {
        serverDatabases.deleteCollection(
            databaseId: AppWriteConstants.dbID, collectionId: jobPost.jobId);
      });
      final DocumentList msgs = await databases.listDocuments(
        databaseId: AppWriteConstants.dbID,
        collectionId: AppWriteConstants.broadcastCollectionsId,
      );
      for(var d in msgs.documents){
        if(d.data['jobId'] == jobPost.jobId){
          databases.deleteDocument(
              databaseId: AppWriteConstants.dbID,
              collectionId: AppWriteConstants.broadcastCollectionsId,
              documentId: d.$id
          );
        }
      }
      AppwriteStorage.delJobDocs(jobPost);
      return response;
    } on AppwriteException catch (e) {
      print('An exception occurred while deleting a job post!: $e');
      rethrow;
    }
  }

  //Send a broadcast message to a job on its id.
  static Future<Document> sendBroadCastMessage(BroadcastMessage msg) async {
    print('Sending broadcast message from appwrite! ${msg.message}');
    try {
      final response = await databases.createDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.broadcastCollectionsId,
          documentId: ID.unique(),
          data: msg.toMap());
      return response;
    } on AppwriteException catch (e) {
      print(
          'An error occurred while sending broadcast message from appwrite_db!: $e');
      rethrow;
    }
  }

  static Future<List<BroadcastMessage>> getBroadCastMessagesById(
      String id) async {
    final List<BroadcastMessage> msgs = [];
    try {
      final response = await databases.listDocuments(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.broadcastCollectionsId,
          queries: [Query.equal('jobId', id)]);
      for (var msg in response.documents) {
        msgs.add(BroadcastMessage.fromJson(msg.data));
      }
      return msgs;
    } on AppwriteException catch (e) {
      print('An error occurred while getting broad cast messages!: $e');
      rethrow;
    }
  }

  static Future<JobPost> getJobById(String id) async {
    try {
      final response = await databases.getDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.jobsCollectionId,
          documentId: id);
      JobPost jobPost = JobPost.fromJson(response.data, id);
      return jobPost;
    } on AppwriteException catch (e) {
      print('An error occurred while getting job by id!: $e');
      rethrow;
    }
  }

  static Future<int> getDocsFromCollection(String id) async{
    try{
      final DocumentList response = await databases.listDocuments(
          databaseId: AppWriteConstants.dbID,
          collectionId: id
      );
      return response.total;
    } on AppwriteException catch(e){
      print('An error occurred while getting docs from collection!: $e');
      rethrow;
    }
  }

  //To create job collection with id.
  static Future<dpm.Collection> createJobCollection(JobPost jobPost) async {
    try {
      final response = await serverDatabases.createCollection(
          databaseId: AppWriteConstants.dbID,
          collectionId: jobPost.jobId,
          name: jobPost.companyName,
          enabled: true,
          permissions: [
            Permission.read(Role.any()),
            Permission.write(Role.any()),
            Permission.update(Role.any()),
            Permission.delete(Role.any()),
          ]);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'name',
          size: 100,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'IU',
          size: 20,
          xrequired: true);
      serverDatabases.createIntegerAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'sem',
          min: 1,
          max: 9,
          xrequired: true);
      serverDatabases.createFloatAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'cgpa',
          min: 1.0,
          max: 10.1,
          xrequired: true);
      serverDatabases.createEmailAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'email',
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'dateOfBirth',
          size: 100,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'phoneNumber',
          size: 13,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'course',
          size: 100,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'degree',
          size: 100,
          xrequired: true);
      serverDatabases.createIntegerAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'year',
          min: 1,
          max: 5,
          xrequired: true);
      serverDatabases.createFloatAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'XMarks',
          min: 1.0,
          max: 100.1,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'XPassingYear',
          size: 20,
          xrequired: true);
      serverDatabases.createFloatAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'XIIMarks',
          xrequired: false);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'XIIPassingYear',
          size: 20,
          xrequired: false);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'diplomaBranch',
          size: 20,
          xrequired: false);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'diplomaPassingYear',
          size: 20,
          xrequired: false);
      serverDatabases.createFloatAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'diplomaMarks',
          min: 0.0,
          max: 100.0,
          xrequired: false);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'gender',
          size: 20,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'board',
          size: 20,
          xrequired: true);
      serverDatabases.createIntegerAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'activeBackLog',
          min: 0,
          xrequired: true);
      serverDatabases.createIntegerAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'totalBackLog',
          min: 0,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'address',
          size: 100,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'engYearOfPassing',
          size: 10,
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'linkedinProfile',
          size: 20,
          xrequired: false);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'githubProfile',
          size: 20,
          xrequired: false);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'otherLink',
          size: 20,
          xrequired: false);
      serverDatabases.createBooleanAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'status',
          xrequired: true);
      serverDatabases.createStringAttribute(
          databaseId: AppWriteConstants.dbID,
          collectionId: response.$id,
          key: 'appliedJobs',
          array: true,
          xrequired: true,
          size: 100);
      return response;
    } on AppwriteException catch (e) {
      print(
          'An error occurred while creating job collection in appwrite db!: $e');
      rethrow;
    }
  }

  static Future<PlacedResponse> createJob(JobPost jobPost) async {
    try {
      final Document response = await databases.createDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.jobsCollectionId,
          documentId: jobPost.jobId,
          data: jobPost.toMap());
      final PlacedResponse placedResponse =
      PlacedResponse(data: response.data, success: true, error: null);
      return placedResponse;
    } on AppwriteException catch (e) {
      print('An error occurred while creating job from appwrite db!: $e');
      final PlacedResponse placedResponse =
      PlacedResponse(data: '', success: false, error: e);
      return placedResponse;
    }
  }

  //To upload job post filters
  static Future<Document> uploadFilter(Filter filter, String jobId) async{
    try{
      final response = await databases.createDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.filtersCollectionId,
          documentId: jobId,
          data: filter.toMap()
      );
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while uploading Filter to database!');
      rethrow;
    }
  }

  //To delete job post filters while deleting a job post.
  static Future<void> delFilter(String jobId) async{
    try{
      final response = await databases.deleteDocument(
          databaseId: AppWriteConstants.dbID,
          collectionId: AppWriteConstants.filtersCollectionId,
          documentId: jobId
      );
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while deleting a filter from database');
      rethrow;
    }
  }
}