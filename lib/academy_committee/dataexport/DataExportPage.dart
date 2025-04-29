import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class DataExportPage extends StatefulWidget {
  const DataExportPage({super.key});

  @override
  _DataExportPageState createState() => _DataExportPageState();
}

class _DataExportPageState extends State<DataExportPage> {
  List<Map<String, dynamic>> activities = [];
  List<Map<String, dynamic>> filtered = [];

  TextEditingController keywordController = TextEditingController();
  String classifyBy = '按班级';
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('pointsActivities') ?? [];

    final parsed = data.map((e) => json.decode(e)).cast<Map<String, dynamic>>().toList();

    setState(() {
      activities = parsed;
    });

    _filter(); // 初始加载时执行一次过滤
  }

  void _filter() {
    setState(() {
      filtered = activities.where((a) {
        final nameMatch = a['name'].toString().contains(keywordController.text);
        final dateMatch = () {
          if (startDate == null || endDate == null) return true;
          final d = DateTime.tryParse(a['time']) ?? DateTime(2000);
          return d.isAfter(startDate!) && d.isBefore(endDate!.add(Duration(days: 1)));
        }();
        final approvedOnly = a['status'] == '已审批'; // ✅ 只导出“已审批”的活动
        return nameMatch && dateMatch && approvedOnly;
      }).toList();
    });
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) startDate = picked;
        else endDate = picked;
      });
      _filter();
    }
  }

  Future<void> _exportToExcel() async {
    var excel = Excel.createExcel();
    final Sheet sheet = excel['加分导出'];

    // 添加表头
    sheet.appendRow(['活动名称', '时间', '学生姓名', '学号', '加分']);

    for (var a in filtered) {
      for (var s in a['students']) {
        sheet.appendRow([
          a['name'],
          a['time'],
          s['name'],
          s['id'],
          s['points'].toString()
        ]);
      }
    }

    // 请求权限
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('存储权限未授权')));
      return;
    }

    // 保存文件
    final directory = await getExternalStorageDirectory();
    String outputPath = '${directory!.path}/加分导出_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    final file = File(outputPath);
    await file.writeAsBytes(excel.encode()!);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('导出成功：$outputPath')));
    OpenFile.open(outputPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('数据导出'), backgroundColor: Colors.blue),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 筛选区域
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: keywordController,
                    decoration: InputDecoration(
                      labelText: '关键词',
                      hintText: '搜索活动名称',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) => _filter(),
                  ),
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: classifyBy,
                  items: ['按班级', '按辅导员', '按活动类型']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => classifyBy = val!),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(true),
                    child: Text('开始时间：${startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : '未选'}'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(false),
                    child: Text('结束时间：${endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : '未选'}'),
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final a = filtered[index];
                  return Card(
                    child: ExpansionTile(
                      title: Text('${a['name']} (${a['time']})'),
                      subtitle: Text('共 ${a['students'].length} 人参与'),
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('姓名')),
                              DataColumn(label: Text('学号')),
                              DataColumn(label: Text('加分')),
                            ],
                            rows: (a['students'] as List).map<DataRow>((s) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(s['name'])),
                                  DataCell(Text(s['id'])),
                                  DataCell(Text(s['points'].toString())),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _exportToExcel,
              icon: Icon(Icons.download),
              label: Text('导出为 Excel'),
            ),
          ],
        ),
      ),
    );
  }
}


