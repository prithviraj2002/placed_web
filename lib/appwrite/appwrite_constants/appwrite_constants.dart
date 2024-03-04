class AppWriteConstants{
  static const String projectId = '659f955654db1b66e4b6';
  static const String apiEndPoint = 'https://cloud.appwrite.io/v1';

  //Database
  static const String dbID = '65ab73cee9265f8b049b';
  static const String profileCollectionsId = '65ab73eec953f243cdac';
  static const String broadcastCollectionsId = '65aca87fbf43f6aef2bb';
  static const String jobsCollectionId = '65ad06fdc3b55e37ae8b';

  //Storage
  static const String logosBucketId = '65e59e475d2b35953495';
  static const String resumeBucketId = '65b108a4e427ecd7669c';
  static const String imagesBucketId = '65b35832b94925a129da';
  static const String resumeViewUrl = '$apiEndPoint/storage/buckets/$resumeBucketId/files/65d843736885561b6a1d/view?project=$projectId&mode=admin';
  static const String imageViewUrl = '$apiEndPoint/storage/buckets/$imagesBucketId/files/65d843736885561b6a1d/view?project=$projectId&mode=admin';

  //server-side api key
  static const String apiKey = 'a1fbf14d4f21bf448cf713c0002584e8942b209d9202026cd069a0665d378793e042fdcb22065044e76d99e0444e9dd2e09b158e8cad7b3a61d3b786aac527c4881bd17461775213ea753c2674146f1a4c5413a58f37bf2c21fd49fb81322fdc38282912ef59b8bb51b0cfe87023cf433214cb175fde831aadba95b1c8a3faab';
}