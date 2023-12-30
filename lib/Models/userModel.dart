

class user {
  String first_name;
  String last_name;
  String email;
  String id;
  String ProfileImagePath;
  String UserType;

  user(
      {required this.first_name,
      required this.last_name,
      required this.email,
      required this.id,
      required this.ProfileImagePath,
      required this.UserType});

  static user fromJson(Map<String, dynamic> json) {
    return user(
      first_name: json['Firstname'] as String? ?? 'field empty',
      last_name: json['LastName'] as String? ?? 'field empty',
      email: json['email'] as String? ?? 'field empty',
      id: json['id'] as String? ?? 'field empty',
      ProfileImagePath: json['ProfileImagePath'] as String? ?? 'field empty',
      UserType: json['UserType'] as String? ?? 'field empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Firstname': first_name,
      'LastName': last_name,
      'email': email,
      'id': id,
      'ProfileImagePath': ProfileImagePath,
      'UserType': UserType,
    };
  }
}
