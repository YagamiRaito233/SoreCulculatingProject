class Student {
  String classInfo;
  String organization;
  String id;
  String name;
  String counselor;
  String phone;
  String isInOtherOrg;

  Student({
    required this.classInfo,
    required this.organization,
    required this.id,
    required this.name,
    required this.counselor,
    required this.phone,
    required this.isInOtherOrg,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      classInfo: json['classInfo'],
      organization: json['organization'],
      id: json['id'],
      name: json['name'],
      counselor: json['counselor'],
      phone: json['phone'],
      isInOtherOrg: json['isInOtherOrg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classInfo': classInfo,
      'organization': organization,
      'id': id,
      'name': name,
      'counselor': counselor,
      'phone': phone,
      'isInOtherOrg': isInOtherOrg,
    };
  }
}