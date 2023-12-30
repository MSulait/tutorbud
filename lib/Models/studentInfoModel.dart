

class Studentinfo {
  String age;
  String qualification;
  String id;
  String description;
  String phoneNumber;

  Studentinfo(
      {required this.age,
      required this.qualification,
      required this.id,
      required this.description,
      required this.phoneNumber});

  static Studentinfo fromJson(Map<String, dynamic> json) {
    return Studentinfo(
      age: json['age'] as String? ?? 'field empty',
      qualification: json['qualification'] as String? ?? 'field empty',
      id: json['id'] as String? ?? 'field empty',
      description: json['description'] as String? ?? 'field empty',
      phoneNumber: json['phoneNumber'] as String? ?? 'field empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'qualification': qualification,
      'id': id,
      'description': description,
      'phoneNumber': phoneNumber,
    };
  }
}
