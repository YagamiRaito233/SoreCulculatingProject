import 'package:flutter/material.dart';

class ActivityApprovalActionPage extends StatefulWidget {
  final String activityName;
  final Function(String) updateStatus;

  const ActivityApprovalActionPage({
    super.key,
    required this.activityName,
    required this.updateStatus,
  });

  @override
  _ActivityApprovalActionPageState createState() => _ActivityApprovalActionPageState();
}

class _ActivityApprovalActionPageState extends State<ActivityApprovalActionPage> {
  String? selectedAction = '批准通过';
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('活动审批操作')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(widget.activityName[0], style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            Text('活动名称：${widget.activityName}'),
            SizedBox(height: 24),
            Row(
              children: [
                Radio<String>(
                  value: '批准通过',
                  groupValue: selectedAction,
                  onChanged: (value) => setState(() => selectedAction = value),
                ),
                Text('批准通过'),
                SizedBox(width: 16),
                Radio<String>(
                  value: '不通过',
                  groupValue: selectedAction,
                  onChanged: (value) => setState(() => selectedAction = value),
                ),
                Text('不通过'),
              ],
            ),
            SizedBox(height: 24),
            Text('理由'),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                hintText: '请输入理由...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('提交'),
              onPressed: () {
                widget.updateStatus('已审批');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('审批结果已提交')));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


