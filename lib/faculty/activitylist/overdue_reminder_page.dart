import 'package:flutter/material.dart';

class OverdueReminderPage extends StatefulWidget {
  const OverdueReminderPage({super.key});

  @override
  _OverdueReminderPageState createState() => _OverdueReminderPageState();
}

class _OverdueReminderPageState extends State<OverdueReminderPage> {
  // 原因控制器
  TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("2024-2025春季学期"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.flag, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("逾期提醒"),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "消息编辑",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入提醒原因",
                    contentPadding: EdgeInsets.all(8),
                  ),
                  maxLines: null,
                ),
              ),
              SizedBox(height: 16),
              Text("发送至A Student"),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("取消"),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // 发送提醒逻辑
                      String reason = _reasonController.text;

                      // 在这里添加发送提醒的逻辑
                      print("发送逾期提醒：");
                      print("原因：$reason");

                      Navigator.pop(context);
                    },
                    child: Text("发送"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}