import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:score_culculating_project/academy_committee/studentinfo/student_info_page.dart'; // 导入学生信息管理页面
import 'package:score_culculating_project/academy_committee/activityApproval/ActivityApprovalPage.dart';
import 'package:score_culculating_project/academy_committee/addpointsverification/AddPointsVerificationPage.dart';
import 'package:score_culculating_project/academy_committee/dataexport/DataExportPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '院团委日常行为分系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/studentInfo': (context) => StudentInfoPage(),
        '/activityApproval': (context) => ActivityApprovalPage(),
        '/addpointsverification':(context )=> AddPointsVerificationPage(),
        '/dataexportpage':(context) => DataExportPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 模拟数据
  int ongoingActivities = 2;
  int participants = 200;
  double participationRate = 0.6;

  // 模拟活动数据
  List<String> activities = [
    '迎新晚会',
    '春游活动',
    '讲座活动',
    '篮球比赛',
    '文艺晚会',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2024 - 2025春季学期'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
            SizedBox(height: 16),
            // 数据看板标题
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '数据看板',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: '月度',
                      items: ['月度', '年度'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // 处理时间范围选择逻辑
                      },
                    ),
                    SizedBox(width: 8),
                    DropdownButton<String>(
                      value: '活动',
                      items: ['活动', '学生'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // 处理筛选类型选择逻辑
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
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
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // 实时数据
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '实时数据',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '参与率 ${(participationRate * 100).toStringAsFixed(0)}%',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('正在进行的活动:'),
                Text(
                  '$ongoingActivities 个',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('参与人数:'),
                Text(
                  '$participants 个',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 底部功能按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFunctionButton(Icons.person, '学生信息管理', context),
                _buildFunctionButton(Icons.event, '活动审批', context), // 更新按钮跳转到活动审批页面
                _buildFunctionButton(Icons.checklist, '加分核验',context),
                _buildFunctionButton(Icons.download, '数据导出',context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionButton(IconData icon, String label, [BuildContext? context]) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (label == '活动审批' && context != null) {
                Navigator.pushNamed(context, '/activityApproval'); // 点击进入活动审批页面
              } else if (label == '学生信息管理' && context != null) {
                Navigator.pushNamed(context, '/studentInfo');
              } else if(label == '加分核验' && context != null){
                Navigator.pushNamed(context, '/addpointsverification');
              } else if(label == '数据导出' && context != null){
                Navigator.pushNamed(context, '/dataexportpage');
              }
            },
            child: Column(
              children: [
                Icon(icon, size: 40),
                SizedBox(height: 4),
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

  const TabButton({super.key,
    required this.label,
    required this.count,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected? Colors.blue[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          SizedBox(width: 4),
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.red,
            child: Text(
              '$count',
              style: TextStyle(color: Colors.white, fontSize: 12),
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
