import 'package:flutter/material.dart';

class AddPointsApprovalPage extends StatefulWidget {
  final Map<String, dynamic> activity;
  final Function(String) updateStatus;

  const AddPointsApprovalPage({
    super.key,
    required this.activity,
    required this.updateStatus,
  });

  @override
  _AddPointsApprovalPageState createState() => _AddPointsApprovalPageState();
}

class _AddPointsApprovalPageState extends State<AddPointsApprovalPage> {
  bool isApproved = true;
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('加分审批'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: isApproved,
                  onChanged: (value) {
                    setState(() {
                      isApproved = value!;
                    });
                  },
                ),
                Text('通过'),
                SizedBox(width: 20),
                Radio<bool>(
                  value: false,
                  groupValue: isApproved,
                  onChanged: (value) {
                    setState(() {
                      isApproved = value!;
                    });
                  },
                ),
                Text('不通过'),
              ],
            ),
            if (!isApproved) ...[
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: '理由（不通过必填）',
                  hintText: '请输入不通过的理由',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (!isApproved && reasonController.text.isEmpty) {
                      // 如果选择不通过，且理由为空，提示
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('不通过时必须填写理由')),
                      );
                    } else {
                      // 提交审批
                      widget.updateStatus(isApproved ? '已审批' : '未通过');
                      Navigator.pop(context); // 返回
                    }
                  },
                  child: Text('提交'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // 返回
                  },
                  child: Text('返回'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
