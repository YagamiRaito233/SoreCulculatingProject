import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:score_culculating_project/academy_committee/activityApproval/ActivityDetailPage.dart';

class ActivityApprovalPage extends StatefulWidget {
  const ActivityApprovalPage({super.key});

  @override
  _ActivityApprovalPageState createState() => _ActivityApprovalPageState();
}

class _ActivityApprovalPageState extends State<ActivityApprovalPage> {
  String? selectedStatus = '未审批';
  String? selectedCollege = '学院A';
  List<Map<String, String>> activities = [];

  final List<Map<String, String>> exampleActivities = [
    {
      'name': '春游集会',
      'status': '未审批',
      'time': '2025-04-18 08:00',
      'teacher': '张老师',
      'college': '学院A',
    },
    {
      'name': '篮球联赛',
      'status': '未审批',
      'time': '2025-04-20 14:30',
      'teacher': '李老师',
      'college': '学院B',
    },
    {
      'name': '红歌大赛',
      'status': '已审批',
      'time': '2025-03-25 19:00',
      'teacher': '赵老师',
      'college': '学院C',
    },
    {
      'name': '校园科技节',
      'status': '未审批',
      'time': '2025-04-28 10:00',
      'teacher': '王老师',
      'college': '学院A',
    },
    {
      'name': '诗词朗诵会',
      'status': '已审批',
      'time': '2025-03-30 18:30',
      'teacher': '钱老师',
      'college': '学院B',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('activities');

    if (saved == null || saved.isEmpty) {
      final encoded = exampleActivities.map((e) => jsonEncode(e)).toList();
      await prefs.setStringList('activities', encoded);
      setState(() => activities = exampleActivities);
    } else {
      setState(() {
        activities = saved.map((e) => Map<String, String>.from(jsonDecode(e))).toList();
      });
    }
  }

  Future<void> _saveActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = activities.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList('activities', encoded);
  }

  void updateActivityStatus(String activityName, String newStatus) {
    setState(() {
      final activity = activities.firstWhere((a) => a['name'] == activityName);
      activity['status'] = newStatus;
    });
    _saveActivities();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = activities.where((a) {
      final matchStatus = selectedStatus == '全部' || a['status'] == selectedStatus;
      final matchCollege = selectedCollege == '全部学院' || a['college'] == selectedCollege;
      return matchStatus && matchCollege;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('活动审批')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: selectedStatus,
                  items: ['未审批', '已审批', '全部'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => setState(() => selectedStatus = val),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedCollege,
                  items: ['学院A', '学院B', '学院C', '全部学院']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => selectedCollege = val),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '未审批活动：${filtered.where((e) => e['status'] == '未审批').length} 个',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final a = filtered[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(a['name'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('时间：${a['time']}'),
                        Text('负责人：${a['teacher']}'),
                        Text('学院：${a['college']}'),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ActivityDetailPage(
                            activityName: a['name']!,
                            activityteacher: a['teacher']!,
                            activitydate: a['time']!,
                            activitycollege: a['college']!,
                            updateStatus: (status) => updateActivityStatus(a['name']!, status),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}







