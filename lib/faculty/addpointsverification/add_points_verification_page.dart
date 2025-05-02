import 'package:flutter/material.dart';
import 'add_points_verification_activity_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:score_culculating_project/faculty/Interface/ApiService.dart';

class AddPointsVerificationPage extends StatefulWidget {
  const AddPointsVerificationPage({super.key});

  @override
  State<AddPointsVerificationPage> createState() => _AddPointsVerificationPageState();

  // 添加公共方法来获取已审批的活动列表
  Future<List<Map<String, dynamic>>> getApprovedActivities() async {
    _AddPointsVerificationPageState state = createState() as _AddPointsVerificationPageState;
    await state.loadAllApprovalStatus();
    return state.getApprovedActivities();
  }
}

class _AddPointsVerificationPageState extends State<AddPointsVerificationPage> {
  // 未审核的活动列表
  List<Map<String, dynamic>> unverifiedActivities = [];
  // 当前选择的审批状态
  String _selectedApprovalStatus = '全部';
  // 当前选择的时间范围
  String _selectedTimeRange = '全部';
  // 当前选择的学院
  String _selectedCollege = '全部';
  // 过滤后的活动列表
  List<Map<String, dynamic>> _filteredActivities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    try {
      await ApiService().fetchAndSaveActivities();
      final prefs = await SharedPreferences.getInstance();
      final List<String>? saved = prefs.getStringList('activities');
      if (saved != null) {
        setState(() {
          unverifiedActivities = saved.map((e) => jsonDecode(e)).cast<Map<String, dynamic>>().toList();
          // 处理可能为null的字段
          for (var activity in unverifiedActivities) {
            activity['organization'] = activity['organization']?? '未知组织';
            activity['date'] = activity['date']?? '未知日期';
            activity['time'] = activity['time']?? '未知时间';
            activity['isApproved'] = activity['isApproved']?? false;
            activity['status'] = activity['status']?? '未审批';
            activity['rejectReason'] = activity['rejectReason'];
          }
          _filteredActivities = [...unverifiedActivities];
        });
      }
    } catch (e) {
      // 处理获取活动数据时的错误，例如显示错误提示
      print('获取活动数据失败: $e');
    }
  }

  // 获取已审批的活动列表
  List<Map<String, dynamic>> getApprovedActivities() {
    return unverifiedActivities.where((activity) => activity['isApproved']?? false).toList();
  }

  // 加载所有活动的审批状态
  Future<void> loadAllApprovalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    for (var activity in unverifiedActivities) {
      bool? approved = prefs.getBool('${activity['name']}_isApproved');
      if (approved != null) {
        activity['isApproved'] = approved;
        // 不管是否通过，都设为已审批
        activity['status'] = '已审批';
        if (!approved) {
          activity['rejectReason'] = prefs.getString('${activity['name']}_rejectReason');
        }
      }
    }
    // 确保在组件挂载后调用setState
    if (mounted) {
      setState(() {
        _filteredActivities = [...unverifiedActivities];
      });
    }
  }

  // 过滤活动列表
  void _filterActivities() {
    setState(() {
      _filteredActivities = unverifiedActivities.where((activity) {
        bool matchesApproval = _selectedApprovalStatus == '全部' ||
            (_selectedApprovalStatus == '已审批' && (activity['isApproved']?? false)) ||
            (_selectedApprovalStatus == '未审批' &&!(activity['isApproved']?? false));
        bool matchesTime = _selectedTimeRange == '全部' || activity['status'] == _selectedTimeRange;
        bool matchesCollege = _selectedCollege == '全部' || activity['organization'] == _selectedCollege;
        return matchesApproval && matchesTime && matchesCollege;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('加分核验'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 加分审核标题和信息图标
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '加分审核',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.info_outline, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 8),
            // 显示未核验活动的数量
            Text(
              '${unverifiedActivities.where((activity) =>!(activity['isApproved']?? false)).length}个未核验活动',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            // 筛选条件的下拉菜单
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 审批状态筛选
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedApprovalStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedApprovalStatus = newValue!;
                          _filterActivities();
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: '全部', child: Text('全部')),
                        DropdownMenuItem(value: '已审批', child: Text('已审批')),
                        DropdownMenuItem(value: '未审批', child: Text('未审批')),
                      ],
                      underline: Container(),
                      isExpanded: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 时间范围筛选
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedTimeRange,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTimeRange = newValue!;
                          _filterActivities();
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: '全部', child: Text('全部')),
                        DropdownMenuItem(value: '本周', child: Text('本周')),
                        DropdownMenuItem(value: '本月', child: Text('本月')),
                      ],
                      underline: Container(),
                      isExpanded: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 学院筛选
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedCollege,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCollege = newValue!;
                          _filterActivities();
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: '全部', child: Text('全部')),
                        DropdownMenuItem(value: 'A学院', child: Text('A学院')),
                        DropdownMenuItem(value: 'B学院', child: Text('B学院')),
                      ],
                      underline: Container(),
                      isExpanded: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 显示过滤后的活动列表
            ..._filteredActivities.map((activity) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPointsVerificationActivityDetails(activity: activity),
                  ),
                ).then((_) {
                  // 审批完成后重新加载状态
                  loadAllApprovalStatus();
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 活动名称和时间
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${activity['date']} ${activity['time']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    // 活动组织和审批状态
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          activity['organization'],
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (activity['isApproved']?? false)? Colors.green[100] : Colors.red[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            (activity['isApproved']?? false)? '已审批' : '未审批',
                            style: TextStyle(
                                color: (activity['isApproved']?? false)? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}