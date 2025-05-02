class ActivityStudentPoints {
  String activityId;
  String studentId;
  double points;

  ActivityStudentPoints({
    required this.activityId,
    required this.studentId,
    required this.points,
  });

  factory ActivityStudentPoints.fromJson(Map<String, dynamic> json) {
    return ActivityStudentPoints(
      activityId: json['activityId'],
      studentId: json['studentId'],
      points: json['points'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityId': activityId,
      'studentId': studentId,
      'points': points,
    };
  }
}