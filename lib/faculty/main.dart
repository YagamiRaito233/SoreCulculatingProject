import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:score_culculating_project/faculty/activitylist/activity_list_page.dart';
import 'package:score_culculating_project/faculty/activityapproval/activity_approval_page.dart';
import 'package:score_culculating_project/faculty/addpointsverification/add_points_verification_page.dart';
import 'package:score_culculating_project/faculty/dataexport/data_export_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '教师日常行为分系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TeacherHomePage(),
      routes: {
        '/activityList': (context) => ActivityListPage(),
        '/activityApproval': (context) => ActivityApprovalPage(),
        '/addpointsverification': (context) => AddPointsVerificationPage(),
      },
    );
  }
}

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  // 模拟数据
  int ongoingActivities = 2;
  int participants = 200;
  double participationRate = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("教师首页"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部选项卡栏
            Row(
              children: [
                Expanded(
                  child: TabButton(
                    label: '全部活动',
                    count: 10,
                    isSelected: true,
                  ),
                ),
                Expanded(
                  child: TabButton(
                    label: '正在进行',
                    count: 2,
                    isSelected: false,
                  ),
                ),
                Expanded(
                  child: TabButton(
                    label: '待审批',
                    count: 3,
                    isSelected: false,
                  ),
                ),
                Expanded(
                  child: TabButton(
                    label: '已结束',
                    count: 5,
                    isSelected: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 数据看板标题
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '数据看板',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    _buildDropdownButton('月度'),
                    const SizedBox(width: 8),
                    _buildDropdownButton('活动'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 饼图
            SizedBox(
              height: 200,
              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataSource: [
                      ChartData('参与学生', participationRate),
                      ChartData('未报到学生', 1 - participationRate),
                    ],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    dataLabelMapper: (ChartData data, _) => data.x,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 实时数据部分
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('实时数据', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
                Text('参与率 ${(participationRate * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('正在进行的活动:'),
                Text('$ongoingActivities 个',
                    style: const TextStyle(color: Colors.red)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('参与人数:'),
                Text('$participants 个',
                    style: const TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(height: 16),
            // 底部功能按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFunctionButton(Icons.person, '活动进度查看', context),
                _buildFunctionButton(Icons.event, '活动审批', context),
                _buildFunctionButton(Icons.checklist, '加分核验', context),
                _buildFunctionButton(Icons.download, '数据导出', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建状态按钮
  Widget _buildStatusButton(String label, int count) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            const SizedBox(width: 4),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text(
                '$count',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建下拉选择框
  Widget _buildDropdownButton(String value) {
    return DropdownButton<String>(
      value: value,
      items: [value].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // 处理筛选类型选择逻辑
      },
    );
  }

// 底部功能按钮
  // 底部功能按钮
  Widget _buildFunctionButton(IconData icon, String label, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              // 按钮功能跳转到对应页面
              if (label == '活动进度查看') {
                Navigator.pushNamed(context, '/activityList');
              } else if (label == '活动审批') {
                Navigator.pushNamed(context, '/activityApproval');
              } else if (label == '加分核验') {
                Navigator.pushNamed(context, '/addpointsverification');
              } else if (label == '数据导出') {
                // 直接获取已审批活动列表
                AddPointsVerificationPage verificationPage = AddPointsVerificationPage();
                List<Map<String, dynamic>> approvedActivities = await verificationPage.getApprovedActivities();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataExportPage(
                      approvedActivities: approvedActivities,
                    ),
                  ),
                );
              }
            },
            child: Column(
              children: [
                Icon(icon, size: 40),
                const SizedBox(height: 4),
                Text(label),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;

  const TabButton({
    super.key,
    required this.label,
    required this.count,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected? Colors.blue[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(width: 4),
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.red,
            child: Text(
              '$count',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}