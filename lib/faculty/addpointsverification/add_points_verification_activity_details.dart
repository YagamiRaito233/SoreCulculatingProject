import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:score_culculating_project/faculty/addpointsverification/add_points_approval_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPointsVerificationActivityDetails extends StatefulWidget {
  final Map<String, dynamic> activity;
  const AddPointsVerificationActivityDetails({super.key, required this.activity});

  @override
  State<AddPointsVerificationActivityDetails> createState() => _AddPointsVerificationActivityDetailsState();
}

class _AddPointsVerificationActivityDetailsState extends State<AddPointsVerificationActivityDetails> {
  bool isApproved = false;
  List<Map<String, dynamic>> pointsList = [];
  String? rejectReason; // 定义为可空类型

  @override
  void initState() {
    super.initState();
    pointsList = widget.activity['pointsList'] ?? [];
    isApproved = widget.activity['isApproved'] ?? false;
    loadApprovalStatus();
  }

  void loadApprovalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isApproved = prefs.getBool('${widget.activity['name']}_isApproved') ?? false;
      rejectReason = prefs.getString('${widget.activity['name']}_rejectReason');
      widget.activity['status'] = '已审批'; // 不管是否通过，都设为已审批
    });
  }

  void _deletePoint(int index) async { // 将方法标记为异步方法
    setState(() {
      pointsList.removeAt(index);
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('${widget.activity['name']}_pointsList', jsonEncode(pointsList));
      print('加分列表数据已保存到本地存储');
    } catch (e) {
      print('保存加分列表数据到本地存储时出错: $e');
    }
  }

  void saveApprovalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.activity['name']}_isApproved', isApproved);
    if (!isApproved && rejectReason != null) {
      await prefs.setString('${widget.activity['name']}_rejectReason', rejectReason!);
    }
    widget.activity['status'] = '已审批'; // 保存时也更新状态
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('加分详情'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '加分详情',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '数据疑似存在异常！',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('表格展示', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('姓名')),
                      DataColumn(label: Text('加分')),
                      DataColumn(label: Text('状态')),
                      DataColumn(label: Text('操作')),
                    ],
                    rows: pointsList.map((point) {
                      String status = '';
                      Color textColor = Colors.black;
                      if (point['points'] < 0) {
                        status = '加分异常';
                        textColor = Colors.red;
                      } else if (point['points'] > 10) {
                        status = '加分过高';
                        textColor = Colors.orange;
                      } else {
                        status = '正常';
                        textColor = Colors.green;
                      }
                      return DataRow(
                        cells: [
                          DataCell(Text(point['name'])),
                          DataCell(Text(point['points'].toStringAsFixed(1))),
                          DataCell(Text(status, style: TextStyle(color: textColor))),
                          DataCell(Container(
                            width: 50, // 设置合适的宽度
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deletePoint(pointsList.indexOf(point)),
                            ),
                          )),
                        ],
                        onSelectChanged: (selected) {
                          if (point['points'] < 0) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('加分异常'),
                                content: const Text('加分为负数，请检查数据！'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('确定'),
                                  ),
                                ],
                              ),
                            );
                          } else if (point['points'] > 10) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('加分提醒'),
                                content: const Text('加分超过10分，请确认是否正确！'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('确定'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('审批详情', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(
                            isApproved
                                ? '已审批'
                                : rejectReason != null
                                ? '活动未通过审批，原因：$rejectReason'
                                : '您还未审批！',
                            style: TextStyle(
                              color: isApproved
                                  ? Colors.green
                                  : rejectReason != null
                                  ? Colors.red
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddPointsApprovalPage(
                                        pointsList: pointsList,
                                        onApprovalComplete: (bool approved, String reason) {
                                          setState(() {
                                            isApproved = approved;
                                            rejectReason = reason.isEmpty ? null : reason;
                                            widget.activity['isApproved'] = approved;
                                            widget.activity['rejectReason'] = rejectReason;
                                            saveApprovalStatus();
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                ),
                                child: const Text('操作'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}