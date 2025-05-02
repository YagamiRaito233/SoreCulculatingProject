class Activity {
  String name;
  String description;
  String location;
  String date;
  String status;

  Activity({
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.status,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'],
      description: json['description'],
      location: json['location'],
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'date': date,
      'status': status,
    };
  }
}