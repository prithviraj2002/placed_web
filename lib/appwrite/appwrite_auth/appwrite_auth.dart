import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:placed_web/appwrite/appwrite_constants/appwrite_constants.dart';

class AppWriteAuth{

  static Client client = Client()
      .setEndpoint(AppWriteConstants.apiEndPoint)
      .setProject(AppWriteConstants.projectId);

  static Account account = Account(client);

  static Future<Token> updatePassword(String userId, String code, String password, String passwordAgain) async{
    print('Entering updatePassword in appwriteauth');
    try{
      final response = await account.updateRecovery(
          userId: userId,
          secret: code,
          password: password,
          passwordAgain: passwordAgain
      );
      print('Here is the response of updateRecovery in updatePassword: ${response.secret}');
      return response;
    } on AppwriteException catch(e){
      print('An error occurred while updating password!: $e');
      rethrow;
    }
  }
}