import 'package:flutter/material.dart';

class AddPointsApprovalPage extends StatefulWidget {
  final List<Map<String, dynamic>> pointsList;
  final void Function(bool isApproved, String rejectReason) onApprovalComplete;

  const AddPointsApprovalPage({
    super.key,
    required this.pointsList,
    required this.onApprovalComplete,
  });

  @override
  State<AddPointsApprovalPage> createState() => _AddPointsApprovalPageState();
}

class _AddPointsApprovalPageState extends State<AddPointsApprovalPage> {
  bool isApproved = true;
  String rejectReason = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('加分审批'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '请选择审批结果',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isApproved = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isApproved? Colors.blue : Colors.transparent,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isApproved? Icons.check_box : Icons.check_box_outline_blank,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        const Text('通过', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isApproved = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isApproved? Colors.transparent : Colors.grey[300],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isApproved? Icons.check_box_outline_blank : Icons.check_box,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        const Text('不通过', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('理由（不通过必写）'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: TextEditingController(text: rejectReason),
                    onChanged: (value) {
                      setState(() {
                        rejectReason = value;
                      });
                    },
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '请输入不通过的理由（不超过100字）',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 提交审批结果
                    if (!isApproved && rejectReason.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('提示'),
                          content: const Text('请填写不通过理由'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('确定'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    widget.onApprovalComplete(isApproved, rejectReason);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('审批成功'),
                        content: Text('${isApproved? '通过' : '不通过'}成功！'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('确定'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('提交'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('返回'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}