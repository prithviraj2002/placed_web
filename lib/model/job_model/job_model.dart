class Job{
  final String companyName;
  final String description;
  final String jobId;

  Job({
    required this.companyName,
    required this.description,
    required this.jobId
  });

  factory Job.fromJson(Map<String, dynamic> json){
    return Job(companyName: json['companyName'], description: json['description'], jobId: json['jobId']);
  }

  Map<String, dynamic> toMap(){
    return {
      'companyName': companyName,
      'description': description,
      'jobId': jobId
    };
  }

  List<String> toList(){
    return [
      companyName,
      description,
      jobId
    ];
  }
}