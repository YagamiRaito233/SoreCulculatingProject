class Activity {
  String name;
  String organization;
  String date;
  String time;
  bool isApproved;
  String status;
  List<Map<String, dynamic>> pointsList;
  String? rejectReason;

  Activity({
    required this.name,
    required this.organization,
    required this.date,
    required this.time,
    required this.isApproved,
    required this.status,
    required this.pointsList,
    this.rejectReason,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'],
      organization: json['organization'],
      date: json['date'],
      time: json['time'],
      isApproved: json['isApproved']?? false,
      status: json['status']?? '未审批',
      pointsList: json['pointsList']?? [],
      rejectReason: json['rejectReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'organization': organization,
      'date': date,
      'time': time,
      'isApproved': isApproved,
      'status': status,
      'pointsList': pointsList,
      'rejectReason': rejectReason,
    };
  }
}