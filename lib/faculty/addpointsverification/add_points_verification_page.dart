import 'package:flutter/material.dart';
import 'package:score_culculating_project/faculty/addpointsverification/add_points_verification_activity_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPointsVerificationPage extends StatefulWidget {
  const AddPointsVerificationPage({super.key});

  @override
  State<AddPointsVerificationPage> createState() =>
      _AddPointsVerificationPageState();

  // 添加公共方法来获取已审批的活动列表
  Future<List<Map<String, dynamic>>> getApprovedActivities() async {
    _AddPointsVerificationPageState state = createState() as _AddPointsVerificationPageState;
    await state.loadAllApprovalStatus();
    return state.getApprovedActivities();
  }
}

class _AddPointsVerificationPageState extends State<AddPointsVerificationPage> {
  // 未审核的活动列表
  List<Map<String, dynamic>> unverifiedActivities = [
    {
      'name': '迎新晚会',
      'organization': 'A组织',
      'date': '2025.4.1',
      'time': '14:00:01',
      'isApproved': false,
      'status': '未审批',
      'pointsList': [
        {'name': '张三', 'points': 12.5},
        {'name': '李四', 'points': 8.0},
      ]
    },
    {
      'name': '篮球比赛',
      'organization': '体育协会',
      'date': '2025.3.15',
      'time': '13:30:00',
      'isApproved': false,
      'status': '未审批',
      'pointsList': [
        {'name': '王五', 'points': 5.0},
        {'name': '赵六', 'points': 7.5},
      ]
    },
    {
      'name': '校园文化节',
      'organization': '艺术团',
      'date': '2025.5.20',
      'time': '09:00:00',
      'isApproved': false,
      'status': '未审批',
      'pointsList': [
        {'name': '孙七', 'points': 6.0},
        {'name': '周八', 'points': 4.0},
      ]
    },
    {
      'name': '校园招聘会',
      'organization': '就业指导中心',
      'date': '2025.6.10',
      'time': '10:00:00',
      'isApproved': false,
      'status': '未审批',
      'pointsList': [
        {'name': '吴九', 'points': 3.0},
        {'name': '郑十', 'points': 2.0},
      ]
    },
  ];

  // 获取已审批的活动列表
  List<Map<String, dynamic>> getApprovedActivities() {
    return unverifiedActivities.where((activity) => activity['isApproved']).toList();
  }

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
    // 初始化过滤后的活动列表
    _filteredActivities = [...unverifiedActivities];
    // 加载所有活动的审批状态
    loadAllApprovalStatus();
  }

  @override
  void dispose() {
    // 当页面销毁时，返回已审批活动列表
    Navigator.pop(context, getApprovedActivities());
    super.dispose();
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
    // 确保在组件挂载后调用 setState
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
            (_selectedApprovalStatus == '已审批' && activity['isApproved']) ||
            (_selectedApprovalStatus == '未审批' &&!activity['isApproved']);
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
              '${unverifiedActivities.where((activity) =>!activity['isApproved']).length}个未核验活动',
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
                            color: activity['isApproved']? Colors.green[100] : Colors.red[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            activity['status'],
                            style: TextStyle(
                                color: activity['isApproved']? Colors.green : Colors.red,
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
