import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:score_culculating_project/academy_committee/addpointsverification/AddPointsDetailPage.dart';
import 'package:score_culculating_project/academy_committee/Interface documentation/ApiService.dart'; // 接口请求方法在这个文件中

class AddPointsVerificationPage extends StatefulWidget {
  const AddPointsVerificationPage({super.key});

  @override
  _AddPointsVerificationPageState createState() => _AddPointsVerificationPageState();
}

class _AddPointsVerificationPageState extends State<AddPointsVerificationPage> {
  List<Map<String, dynamic>> activities = [];
  String selectedStatus = '全部';
  String selectedCollege = '全部';

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    // 从接口获取并保存活动学生加分信息
    await ApiService().fetchAndSaveActivityStudentPoints();

    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('activityStudentPoints')?? [];
    setState(() {
      activities = data.map((e) => json.decode(e)).cast<Map<String, dynamic>>().toList();
    });
  }

  int get unapprovedCount =>
      activities.where((a) => a['status'] == '未审批').length;

  List<String> get colleges => ['全部', ...{
    for (var a in activities) a['college']
  }];

  void _updateActivityStatus(String id, String newStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final updated = activities.map((a) {
      if (a['id'] == id) {
        a['status'] = newStatus;
      }
      return a;
    }).toList();
    await prefs.setStringList(
        'activityStudentPoints', updated.map((e) => json.encode(e)).toList());
    setState(() {
      activities = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = activities.where((a) {
      final statusMatch = selectedStatus == '全部' || a['status'] == selectedStatus;
      final collegeMatch = selectedCollege == '全部' || a['college'] == selectedCollege;
      return statusMatch && collegeMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('加分核验'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text('未核验活动：$unapprovedCount 个', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                DropdownButton<String>(
                  value: selectedStatus,
                  items: ['全部', '未审批', '已审批']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => selectedStatus = val!),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCollege,
                  items: colleges
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => selectedCollege = val!),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final a = filtered[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(a['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('时间：${a['time']}'),
                        Text('学院：${a['college']}'),
                        Text('状态：${a['status']}'),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddPointsDetailPage(
                            activity: a,
                            updateStatus: (newStatus) =>
                                _updateActivityStatus(a['id'], newStatus),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


