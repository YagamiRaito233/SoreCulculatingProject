import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:score_culculating_project/faculty/Interface/activity.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1/api'; // 根据实际情况修改

  Future<void> fetchAndSaveActivities() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get('$baseUrl/activities');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Activity> activities = data.map((e) => Activity.fromJson(e)).toList();
        final List<String> encodedActivities = activities.map((a) => json.encode(a.toJson())).toList();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('activities', encodedActivities);
      } else {
        print('获取活动信息失败: HTTP状态码为 ${response.statusCode}.');
      }
    } catch (e) {
      print('获取活动信息失败: $e');
    }
  }
}