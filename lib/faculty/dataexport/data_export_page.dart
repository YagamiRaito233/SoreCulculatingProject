import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DataExportPage extends StatefulWidget {
  final List<Map<String, dynamic>> approvedActivities;
  const DataExportPage({super.key, required this.approvedActivities});

  @override
  State<DataExportPage> createState() => _DataExportPageState();
}

class _DataExportPageState extends State<DataExportPage> {
  String searchKeyword = '';
  DateTime? startDate;
  DateTime? endDate;
  String selectedCollege = '全部';
  String selectedActivity = '全部';
  List<Map<String, dynamic>> filteredActivities = [];
  // 用于记录每个活动的展开状态
  Map<int, bool> activityExpansionStates = {};

  @override
  void initState() {
    super.initState();
    filterActivities();
    // 初始化每个活动的展开状态为 false
    for (int i = 0; i < filteredActivities.length; i++) {
      activityExpansionStates[i] = false;
    }
  }

  void filterActivities() {
    setState(() {
      filteredActivities = widget.approvedActivities.where((activity) {
        bool nameMatches = activity['name']
            .toString()
            .toLowerCase()
            .contains(searchKeyword.toLowerCase());
        bool dateMatches = true;
        if (startDate != null && endDate != null) {
          DateTime activityDate =
          DateFormat('yyyy.MM.dd').parse(activity['date']);
          dateMatches = activityDate.isAfter(startDate!) &&
              activityDate.isBefore(endDate!);
        }
        bool collegeMatches = selectedCollege == '全部' ||
            activity['organization'] == selectedCollege;
        bool activityMatches = selectedActivity == '全部' ||
            activity['name'] == selectedActivity;
        return nameMatches && dateMatches && collegeMatches && activityMatches;
      }).toList();
      // 更新展开状态的 Map，确保与筛选后的活动数量一致
      activityExpansionStates = {};
      for (int i = 0; i < filteredActivities.length; i++) {
        activityExpansionStates[i] = false;
      }
    });
  }

  void exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    List<List<String>> excelData = [
      ['活动名称', '组织', '日期', '时间', '加分人员及加分']
    ];
    for (var activity in filteredActivities) {
      String pointsListString = '';
      // 这里进行类型检查和转换
      List<Map<String, dynamic>> pointsList = [];
      if (activity['pointsList'] != null &&
          activity['pointsList'] is List<dynamic>) {
        pointsList =
            (activity['pointsList'] as List<dynamic>).cast<Map<String, dynamic>>();
      }
      for (var point in pointsList) {
        pointsListString += '${point['name']}: ${point['points']}, ';
      }
      if (pointsListString.isNotEmpty) {
        pointsListString = pointsListString.substring(0, pointsListString.length - 2);
      }
      excelData.add([
        activity['name'],
        activity['organization'],
        activity['date'],
        activity['time'],
        pointsListString
      ]);
    }
    for (int i = 0; i < excelData.length; i++) {
      for (int j = 0; j < excelData[i].length; j++) {
        sheetObject.cell(CellIndex.indexByString('${String.fromCharCode(65 + j)}${i + 1}')).value = excelData[i][j];
      }
    }
    var fileBytes = excel.save()!;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/approved_activities.xlsx';
    File file = File(filePath);
    await file.writeAsBytes(fileBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据导出'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                searchKeyword = value;
                filterActivities();
              },
              decoration: const InputDecoration(
                hintText: '搜索关键词',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('开始日期'),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              startDate = pickedDate;
                              filterActivities();
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                              text: startDate == null
                                  ? ''
                                  : DateFormat('yyyy-MM-dd').format(startDate!),
                            ),
                            decoration: const InputDecoration(
                              hintText: '选择开始日期',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('结束日期'),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              endDate = pickedDate;
                              filterActivities();
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: TextEditingController(
                              text: endDate == null
                                  ? ''
                                  : DateFormat('yyyy-MM-dd').format(endDate!),
                            ),
                            decoration: const InputDecoration(
                              hintText: '选择结束日期',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedCollege,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCollege = newValue;
                    filterActivities();
                  });
                }
              },
              items: const [
                DropdownMenuItem(value: '全部', child: Text('全部')),
                DropdownMenuItem(value: 'A学院', child: Text('A学院')),
                DropdownMenuItem(value: 'B学院', child: Text('B学院')),
              ],
              underline: Container(),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedActivity,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedActivity = newValue;
                    filterActivities();
                  });
                }
              },
              items: widget.approvedActivities
                  .map((activity) => DropdownMenuItem<String>(
                value: activity['name'],
                child: Text(activity['name']),
              ))
                  .toList()
                ..insert(0, const DropdownMenuItem<String>(
                    value: '全部', child: Text('全部'))),
              underline: Container(),
            ),
            const SizedBox(height: 16),
            Column(
              children: filteredActivities.asMap().entries.map((entry) {
                List<Map<String, dynamic>> pointsList = [];
                if (entry.value['pointsList'] != null &&
                    entry.value['pointsList'] is List<dynamic>) {
                  pointsList =
                      (entry.value['pointsList'] as List<dynamic>).cast<Map<String, dynamic>>();
                }
                return ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.value['name']),
                      Text('共 ${pointsList.length}人参与')
                    ],
                  ),
                  initiallyExpanded: activityExpansionStates[entry.key]?? false,
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                      activityExpansionStates[entry.key] = isExpanded;
                    });
                  },
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('姓名')),
                        DataColumn(label: Text('加分')),
                      ],
                      rows: pointsList.map((point) {
                        return DataRow(
                          cells: [
                            DataCell(Text(point['name'])),
                            DataCell(Text(point['points'].toStringAsFixed(1))),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: exportToExcel,
              child: const Text('导出'),
            ),
          ],
        ),
      ),
    );
  }
}