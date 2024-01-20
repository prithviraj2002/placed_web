class Profile {
  final String name;
  final String IU;
  final String email;
  final String branch;
  final int sem;
  final double cgpa;

  Profile({
    required this.name,
    required this.IU,
    required this.email,
    required this.branch,
    required this.sem,
    required this.cgpa
  });

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(name: json['name'],
        IU: json['IU'],
        email: json['email'],
        branch: json['branch'],
        sem: json['sem'],
        cgpa: json['cgpa']);
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'IU': IU,
      'email': email,
      'branch': branch,
      'sem': sem,
      'cgpa': cgpa
    };
  }

  List<String> toList(){
    return [name, IU, email, branch, sem.toString(), cgpa.toString()];
  }
}