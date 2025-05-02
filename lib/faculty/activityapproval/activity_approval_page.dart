import 'package:flutter/material.dart';
import 'package:score_culculating_project/faculty/Interface/activity.dart';
import 'activity_approval_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:score_culculating_project/faculty/Interface/ApiService.dart';

class ActivityApprovalPage extends StatefulWidget {
  const ActivityApprovalPage({super.key});

  @override
  State<ActivityApprovalPage> createState() => _ActivityApprovalPageState();
}

class _ActivityApprovalPageState extends State<ActivityApprovalPage> {
  List<Activity> activities = [];
  String _selectedApprovalStatus = '全部';
  String _selectedTimeRange = '本周';
  String _selectedOrganization = '组织';

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    try {
      await ApiService().fetchAndSaveActivities();
      final prefs = await SharedPreferences.getInstance();
      final List<String>? saved = prefs.getStringList('activities');
      if (saved != null) {
        setState(() {
          activities = saved.map((e) => Activity.fromJson(jsonDecode(e))).toList();
        });
      }
    } catch (e) {
      print('加载活动数据失败: $e');
    }
  }

  void _filterActivities() {
    setState(() {
      // 这里可以根据筛选条件实现过滤逻辑
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("2024-2025春季学期"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios, color: Colors.blue),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text("返回"),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "活动审批",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${activities.where((activity) =>!activity.isApproved && (activity.status == '未审批')).length}个未审批活动',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedApprovalStatus,
                      items: ["全部", "已审批", "未审批"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _selectedApprovalStatus = newValue;
                          _filterActivities();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedTimeRange,
                      items: ["本周", "本月"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _selectedTimeRange = newValue;
                          _filterActivities();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedOrganization,
                      items: ["组织", "班级"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _selectedOrganization = newValue;
                          _filterActivities();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return GestureDetector(
                    onTap: () {
                      // 将 Activity 对象转换为 Map<String, dynamic>
                      final activityMap = {
                        'name': activity.name,
                        'organization': activity.organization,
                        'time': activity.time,
                        'isApproved': activity.isApproved,
                        'rejectReason': activity.rejectReason?? '',
                        // 如果 Activity 类还有其他属性，也需要添加到这里
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityDetailPage(activity: activityMap),
                        ),
                      ).then((updatedActivity) {
                        if (updatedActivity != null) {
                          setState(() {
                            activity.isApproved = updatedActivity['isApproved'];
                            activity.rejectReason = updatedActivity['rejectReason'];
                          });
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(activity.name),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(activity.organization),
                              Text(activity.time),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (activity.isApproved || activity.status == '已审批')
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  (activity.isApproved || activity.status == '已审批')
                                      ? '已审批'
                                      : '未审批',
                                  style: TextStyle(
                                    color: (activity.isApproved || activity.status == '已审批')
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}