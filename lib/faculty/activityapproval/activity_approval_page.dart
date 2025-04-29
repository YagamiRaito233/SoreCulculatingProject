import 'package:flutter/material.dart';
import 'activity_approval_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityApprovalPage extends StatefulWidget {
  const ActivityApprovalPage({super.key});

  @override
  State<ActivityApprovalPage> createState() => _ActivityApprovalPageState();
}

class _ActivityApprovalPageState extends State<ActivityApprovalPage> {
  List<Map<String, dynamic>> activities = [
    {
      'name': '迎新晚会',
      'organization': 'A组织',
      'time': '2025.4.1 14:00:01',
      'isApproved': false,
      'rejectReason': '',
    },
    {
      'name': '校园歌唱比赛',
      'organization': 'B组织',
      'time': '2025.4.15 19:00:00',
      'isApproved': false,
      'rejectReason': '',
    },
    {
      'name': '足球游戏',
      'organization': 'B组织',
      'time': '2025.4.16 19:00:00',
      'isApproved': false,
      'rejectReason': '',
    },
    {
      'name': '诗词大赛',
      'organization': 'A组织',
      'time': '2025.4.16 16:00:00',
      'isApproved': false,
      'rejectReason': '',
    },

  ];
  String _selectedApprovalStatus = '全部';
  String _selectedTimeRange = '本周';
  String _selectedOrganization = '组织';

  @override
  void initState() {
    super.initState();
    loadApprovalStatus();
  }

  Future<void> loadApprovalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    for (var activity in activities) {
      bool? isApproved = prefs.getBool(activity['name'] + '_isApproved');
      String? rejectReason = prefs.getString(activity['name'] + '_rejectReason');
      if (isApproved != null) {
        activity['isApproved'] = isApproved;
        activity['rejectReason'] = rejectReason;
      }
    }
    setState(() {});
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
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("2024-2025春季学期"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("返回"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "活动审批",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '${activities.where((activity) =>!activity['isApproved'] && (activity['rejectReason'] == null || activity['rejectReason'].isEmpty)).length}个未审批活动',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
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
                  SizedBox(width: 16),
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
                  SizedBox(width: 16),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityDetailPage(activity: activity),
                        ),
                      ).then((updatedActivity) {
                        if (updatedActivity != null) {
                          setState(() {
                            activity['isApproved'] = updatedActivity['isApproved'];
                            activity['rejectReason'] = updatedActivity['rejectReason'];
                          });
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(activity['name']),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(activity['organization']),
                              Text(activity['time']),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (activity['isApproved'] || (activity['rejectReason'] != null && activity['rejectReason'].isNotEmpty))
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  (activity['isApproved'] || (activity['rejectReason'] != null && activity['rejectReason'].isNotEmpty))
                                      ? '已审批'
                                      : '未审批',
                                  style: TextStyle(
                                    color: (activity['isApproved'] || (activity['rejectReason'] != null && activity['rejectReason'].isNotEmpty))
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