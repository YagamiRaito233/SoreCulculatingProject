import 'package:dio/dio.dart';
import 'package:score_culculating_project/academy_committee/Interface%20documentation/activity.dart';
import 'package:score_culculating_project/academy_committee/Interface%20documentation/activitystudentpoints.dart';
import 'package:score_culculating_project/academy_committee/Interface%20documentation/student.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1/api'; // 根据实际情况修改
  final Dio dio = Dio();

  ApiService() {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    );
  }

  Future<void> fetchAndSaveStudents() async {
    try {
      Response response = await dio.get('$baseUrl/students');
      if (response.statusCode == 200) {
        final List<dynamic> studentList = response.data;
        final List<String> studentJsons = studentList.map((s) => json.encode(Student.fromJson(s).toJson())).toList();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('students', studentJsons);
      } else {
        print('获取学生信息失败: HTTP状态码为 ${response.statusCode}.');
      }
    } catch (e) {
      print('获取学生信息失败: $e');
    }
  }

  Future<void> fetchAndSaveActivities() async {
    try {
      Response response = await dio.get('$baseUrl/activities');
      if (response.statusCode == 200) {
        final List<dynamic> activityList = response.data;
        final List<String> activityJsons = activityList.map((a) => json.encode(Activity.fromJson(a).toJson())).toList();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('activities', activityJsons);
      } else {
        print('获取活动信息失败: HTTP状态码为 ${response.statusCode}.');
      }
    } catch (e) {
      print('获取活动信息失败: $e');
    }
  }

  Future<void> fetchAndSaveActivityStudentPoints() async {
    try {
      Response response = await dio.get('$baseUrl/activityStudentPoints');
      if (response.statusCode == 200) {
        final List<dynamic> pointsList = response.data;
        final List<String> pointsJsons = pointsList.map((p) => json.encode(ActivityStudentPoints.fromJson(p).toJson())).toList();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('activityStudentPoints', pointsJsons);
      } else {
        print('获取活动学生加分信息失败: HTTP状态码为 ${response.statusCode}.');
      }
    } catch (e) {
      print('获取活动学生加分信息失败: $e');
    }
  }
}