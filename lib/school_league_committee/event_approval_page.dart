import 'dart:ffi';
import 'package:flutter/material.dart';

class EventApprovalPage extends StatefulWidget {
  const EventApprovalPage({super.key, required this.title});

  final String title;

  @override
  State<EventApprovalPage> createState() => _EventApprovalPageState();
}

class _EventApprovalPageState extends State<EventApprovalPage> {
  // 全局变量设置
  final termName = "2024-2025春季学期"; // 学期名字
  final termTime = "2025.2.28-2025.6.28"; // 学期时间

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: maxWidth,
                height: maxHeight * 0.15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      Colors.blue,
                      Color(0xFFE2E2E2),
                    ],
                    stops: [0.0, 0.7, 1.0],
                  ),
                ),
                child: TopNavigationContent(termName: termName, termTime: termTime),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: maxWidth,
                height: maxHeight * 0.85,
                decoration: BoxDecoration(
                  color: Color(0xFFE2E2E2),
                ),
                child: EventApprovalPageContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TopNavigationContent extends StatefulWidget {
  const TopNavigationContent({super.key, required this.termName, required this.termTime});

  final String termName, termTime;

  @override
  State<TopNavigationContent> createState() => _TopNavigationContentState(termName: termName, termTime: termTime);
}

// 顶部导航栏内容
class _TopNavigationContentState extends State<TopNavigationContent> {
  _TopNavigationContentState({required this.termName, required this.termTime});

  final String termName, termTime;

  // layout
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          return Stack(
            children: <Widget>[
              Positioned(
                top: maxHeight * 0.40,
                left: maxWidth * 0.06,
                child: Container(
                  width: maxWidth * 0.12,
                  height: maxWidth * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text("校",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                ),
              ),
              Positioned(
                top: maxHeight * 0.40,
                left: 0,
                child: Container(
                  width: maxWidth,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("$termName",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: maxHeight * 0.02),
                        Text("$termTime",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}

class EventApprovalPageContent extends StatefulWidget {
  const EventApprovalPageContent({super.key});

  @override
  State<EventApprovalPageContent> createState() => _EventApprovalPageContentState();
}

// 界面主要框架
class _EventApprovalPageContentState extends State<EventApprovalPageContent> {

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: maxHeight * 0.01),
            Positioned(
              left: maxWidth * 0.03,
              child: Container(
                width: maxWidth * 0.94,
                height: maxHeight * 0.885,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5.0, 2.0),
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      )
                    ]
                ),
                child: EventApprovalList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EventApprovalList extends StatefulWidget {
  const EventApprovalList({super.key});

  @override
  State<EventApprovalList> createState() => _EventApprovalListState();
}

// 界面主要列表
class _EventApprovalListState extends State<EventApprovalList> {
  // 定义未审批活动数
  int notApprovalActivities = 0;
  List<Activity> _activities = [];

  // 初始化列表
  @override
  void initState() {
    super.initState();
    _fetchActivities();
  }

  Future<void> _fetchActivities() async {
    // 从后端获取数据
    // final response = await http.get(Uri.parse('your_api_url'));
    // setState(() {
    //   _accounts = (json.decode(response.body) as List)
    //       .map((item) => Account.fromJson(item))
    //       .toList();
    // });

    _activities = [
      Activity(id: 1, name: '迎新晚会1', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 2, name: '迎新晚会2', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 3, name: '迎新晚会3', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 4, name: '迎新晚会4', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 5, name: '迎新晚会5', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 6, name: '迎新晚会6', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 7, name: '迎新晚会7', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 8, name: '迎新晚会8', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
      Activity(id: 9, name: '迎新晚会9', employee: 'A学院 A老师', time: '2025.04.01 14:00:01'),
    ];
  }

  // 获取审批菜单
  List<String> _getApprovalMenu() {
    List<String> approvals = ['已审批', '未审批', '审批中'];
    return approvals;
  }

  // 获取时间菜单
  List<String> _getTimeMenu() {
    List<String> times = ['全部', '本月', '本周', '本日'];
    return times;
  }

  // 获取学院菜单
  List<String> _getMajorMenu() {
    List<String> majors = ['计算机技术与科学暨软件学院', '海洋工程学院', '紫丁香书院', '商学院'];
    return majors;
  }

  // 下拉菜单的选择逻辑
  void _onSelected(String? value) {

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Positioned(
              left: maxWidth * 0.01,
              child: Container(
                  width: maxWidth * 0.98,
                  child: TextButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios_new,
                          size: 25,
                          color: Colors.black54,
                        ),
                        Text("返回首页",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.0,
                              decoration: TextDecoration.none,
                            )
                        ),
                      ],
                    ),
                    onPressed: (){Navigator.pop(context);},
                  )
              ),
            ),
            Positioned(
              left: maxWidth * 0.05,
              child: Container(
                width: maxWidth * 0.90,
                child: Text("活动审批",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.01),
            Positioned(
              left: maxWidth * 0.05,
              child: Container(
                width: maxWidth * 0.90,
                child: Text("${notApprovalActivities}个未审批活动",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.02),
            Positioned(
              left: 0,
              child: Container(
                width: maxWidth,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Material(
                        child: DropdownMenu<String>(
                          dropdownMenuEntries: _buildApprovalMenu(_getApprovalMenu()),
                          initialSelection: _getApprovalMenu().first,
                          onSelected: _onSelected,
                          width: maxWidth * 0.3,
                          enableFilter: false,
                          requestFocusOnTap: false,
                          textStyle: TextStyle(
                            color: Colors.black,
                            height: 1.0,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Color(0xFFE2E2E2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            constraints: BoxConstraints.tightFor(height: maxHeight * 0.05),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: maxWidth * 0.03),
                      Material(
                        child: DropdownMenu<String>(
                          dropdownMenuEntries: _buildTimeMenu(_getTimeMenu()),
                          initialSelection: _getTimeMenu().first,
                          onSelected: _onSelected,
                          width: maxWidth * 0.25,
                          enableFilter: false,
                          requestFocusOnTap: false,
                          textStyle: TextStyle(
                            color: Colors.black,
                            height: 1.0,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Color(0xFFE2E2E2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            constraints: BoxConstraints.tightFor(height: maxHeight * 0.05),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: maxWidth * 0.03),
                      Material(
                        child: DropdownMenu<String>(
                          dropdownMenuEntries: _buildMajorMenu(_getMajorMenu()),
                          initialSelection: _getMajorMenu().first,
                          onSelected: _onSelected,
                          width: maxWidth * 0.3,
                          enableFilter: false,
                          requestFocusOnTap: false,
                          textStyle: TextStyle(
                            color: Colors.black,
                            height: 1.0,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Color(0xFFE2E2E2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            constraints: BoxConstraints.tightFor(height: maxHeight * 0.05),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.01),
            Positioned(
              left: maxWidth * 0.025,
              child: Container(
                  width: maxWidth * 0.95,
                  height: maxHeight * 0.700,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    itemCount: _activities.length,
                    itemBuilder: (context, index) {
                      return _buildActivityItem(context, _activities[index]);
                    },
                  )
              ),
            ),
          ],
        );
      },
    );
  }

  List<DropdownMenuEntry<String>> _buildApprovalMenu(List<String> approvals) {
    return approvals.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  List<DropdownMenuEntry<String>> _buildTimeMenu(List<String> times) {
    return times.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  List<DropdownMenuEntry<String>> _buildMajorMenu(List<String> majors) {
    return majors.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  Widget _buildActivityItem(BuildContext context, Activity activity) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: ListTile(
        leading: Text(activity.name),
        title: Text(activity.employee),
        subtitle: Text(activity.time),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _showActivityActionsDialog(context, activity),
      ),
    );
  }

  void _showActivityActionsDialog(BuildContext context, Activity account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("活动详情"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue, // 设置背景色
              radius: 24,
              child: Text(
                account.employee.isNotEmpty ? account.employee[0] : '?', // 取名字首字母
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Text("${account.name}"),
            Text("活动名称: ${account.name}"),
            Text("负责学院: ${account.name}"),
            Text("活动时间: ${account.name}"),
            Text("活动地点: ${account.name}"),
            Text("附件: ${account.name}"),
            Text("批注: ${account.name}"),
          ],
        ),
        actions: [
          TextButton(
            child: Text("操作"),
            onPressed: () => _showOperatorDialog(context, account),
          ),
        ],
      ),
    );
  }

  void _showOperatorDialog(BuildContext context, Activity activity) {
    final nameController = TextEditingController(text: activity.name);
    final employeeController = TextEditingController(text: activity.employee);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("操作活动"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "姓名"),
            ),
            TextField(
              controller: employeeController,
              decoration: InputDecoration(labelText: ""),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("取消"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("确认"),
            onPressed: () {
              final updatedActivity = Activity(
                id: activity.id,
                name: nameController.text,
                employee: employeeController.text,
                time: activity.time,
              );
              // 更新数据
              Navigator.pop(context); // 关闭操作对话框
              Navigator.pop(context); // 关闭详情对话框
              _showActivityActionsDialog(context, updatedActivity); // 重新打开（可选）
            },
          ),
        ],
      ),
    );
  }
}

class Activity {
  final int id;
  final String name;
  final String employee;
  final String time;

  Activity({
    required this.id,
    required this.name,
    required this.employee,
    required this.time,
  });
}