class BroadCastMessage {
  final String message;
  final String jobId;
  final String timeAndDate;

  BroadCastMessage(
      {required this.message, required this.jobId, required this.timeAndDate});

  factory BroadCastMessage.fromJson(Map<String, dynamic> json) {
    return BroadCastMessage(
        message: json['title'],
        jobId: json['desc'],
        timeAndDate: json['timeAndDate']);
  }

  Map<String, dynamic> toMap(){
    return{
      'message': message,
      'jobId': jobId,
      'timeAndDate': timeAndDate
    };
  }
}
