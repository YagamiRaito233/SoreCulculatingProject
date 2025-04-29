import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddPointsDetailPage extends StatelessWidget {
  final Map<String, dynamic> activity;
  final Function(String) updateStatus;

  const AddPointsDetailPage({
    super.key,
    required this.activity,
    required this.updateStatus,
  });

  String getWarning(double score) {
    if (score < 0) return '❗加分为负，错误';
    if (score > 10) return '⚠️ 过高，可能异常';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final students = activity['students'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('加分详情'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('活动：${activity['name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('时间：${activity['time']}'),
                Text('学院：${activity['college']}'),
                Text('状态：${activity['status']}'),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,  // 调整列间距，避免按钮和其他列过于紧凑
                columns: const [
                  DataColumn(label: Text('姓名')),
                  DataColumn(label: Text('学号')),
                  DataColumn(label: Text('加分')),
                  DataColumn(label: Text('提示')),
                  DataColumn(label: Text('操作')),  // 增加操作列
                ],
                rows: students.map((s) {
                  final score = (s['points'] as num).toDouble();
                  final warning = getWarning(score);
                  final isError = score < 0 || score > 10;
                  return DataRow(cells: [
                    DataCell(Text(s['name'])),
                    DataCell(Text(s['id'])),
                    DataCell(Text(score.toString())),
                    DataCell(Text(warning,
                        style: TextStyle(
                            color: warning.contains('❗')
                                ? Colors.red
                                : Colors.orange))),
                    DataCell(
                      isError
                          ? IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('确认删除'),
                              content: Text('确定要删除该学生加分记录吗？'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: Text('取消')),
                                TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: Text('删除')),
                              ],
                            ),
                          );
                          if (confirm) {
                            students.remove(s);
                            // 同步修改 SharedPreferences 中的活动数据
                            final prefs = await SharedPreferences.getInstance();
                            final allData =
                                prefs.getStringList('pointsActivities') ?? [];
                            final updated = allData.map((e) {
                              final map = json.decode(e);
                              if (map['id'] == activity['id']) {
                                map['students'] = students;
                                return json.encode(map);
                              }
                              return e;
                            }).toList();
                            await prefs.setStringList(
                                'pointsActivities', updated);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('已删除该学生加分')),
                            );
                            // 触发界面刷新
                            Navigator.pop(context);
                          }
                        },
                      )
                          : SizedBox(),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (activity['status'] == '未审批')
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                updateStatus('已审批');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('审批已完成')));
                Navigator.pop(context);
              },
              child: Text('完成审批'),
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

