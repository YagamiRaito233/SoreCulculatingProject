import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApprovalDetailPage extends StatefulWidget {
  final Map<String, dynamic> activity;
  const ApprovalDetailPage({super.key, required this.activity});

  @override
  State<ApprovalDetailPage> createState() => _ApprovalDetailPageState();
}

class _ApprovalDetailPageState extends State<ApprovalDetailPage> {
  bool isApproved = false;
  String rejectReason = '';
  final TextEditingController _rejectReasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isApproved = widget.activity['isApproved']?? false;
    rejectReason = widget.activity['rejectReason']?? '';
    _rejectReasonController.text = rejectReason;
  }

  @override
  void dispose() {
    _rejectReasonController.dispose();
    super.dispose();
  }

  Future<void> saveApprovalStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.activity['name']}_isApproved', isApproved);
    if (!isApproved) {
      await prefs.setString('${widget.activity['name']}_rejectReason', rejectReason);
    } else {
      await prefs.remove('${widget.activity['name']}_rejectReason');
    }
    widget.activity['isApproved'] = isApproved;
    widget.activity['rejectReason'] = rejectReason;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            saveApprovalStatus().then((_) {
              Navigator.pop(context, widget.activity); // 返回更新后的 activity
            });
          },
        ),
        title: const Text("2024 - 2025春季学期"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "审批详情",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isApproved = true;
                      rejectReason = '';
                      _rejectReasonController.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isApproved? Colors.blue : Colors.grey,
                  ),
                  child: const Text("通过"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isApproved = false;
                    });
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("驳回原因"),
                        content: TextField(
                          controller: _rejectReasonController,
                          decoration: const InputDecoration(
                            hintText: "请输入驳回原因",
                          ),
                          onChanged: (value) {
                            rejectReason = value;
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("取消"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                rejectReason = _rejectReasonController.text;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("确定"),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:!isApproved? Colors.blue : Colors.grey,
                  ),
                  child: const Text("驳回"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (!isApproved && rejectReason.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "驳回原因：",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(rejectReason),
                ],
              ),
          ],
        ),
      ),
    );
  }
}