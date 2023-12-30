

class Teacherinfo {
  String age;
  String qualification;
  List<String> subjects; // Changed to a List<String>
  String id;
  String description;
  String phoneNumber;

  Teacherinfo({
    required this.age,
    required this.qualification,
    required this.subjects,
    required this.id,
    required this.description,
    required this.phoneNumber,
  });

  static Teacherinfo fromJson(Map<String, dynamic> json) {
    return Teacherinfo(
      age: json['age'] as String? ?? 'field empty',
      qualification: json['qualification'] as String? ?? 'field empty',
      subjects: List<String>.from(json['subjects'] as List<dynamic>? ?? []),
      id: json['id'] as String? ?? 'field empty',
      description: json['description'] as String? ?? 'field empty',
      phoneNumber: json['phoneNumber'] as String? ?? 'field empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'qualification': qualification,
      'subjects': subjects,
      'id': id,
      'description': description,
      'phoneNumber': phoneNumber,
    };
  }
}
