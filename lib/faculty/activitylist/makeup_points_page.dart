import 'package:flutter/material.dart';

class ScoreSupplementPage extends StatefulWidget {
  const ScoreSupplementPage({super.key});

  @override
  _ScoreSupplementPageState createState() => _ScoreSupplementPageState();
}

class _ScoreSupplementPageState extends State<ScoreSupplementPage> {
  // 分数类型选择
  String _selectedScoreType = "日常行为分";

  // 补录分数控制器
  TextEditingController _scoreController = TextEditingController();

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
                  Text("学生分数详细信息"),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.blue),
                        SizedBox(width: 8),
                        Text("A Student"),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Radio(
                          value: "日常行为分",
                          groupValue: _selectedScoreType,
                          onChanged: (value) {
                            setState(() {
                              _selectedScoreType = value.toString();
                            });
                          },
                        ),
                        Text("日常行为分"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "个性发展分",
                          groupValue: _selectedScoreType,
                          onChanged: (value) {
                            setState(() {
                              _selectedScoreType = value.toString();
                            });
                          },
                        ),
                        Text("个性发展分"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("补录分数"),
                    TextField(
                      controller: _scoreController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "请输入分数",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("原因"),
                    TextField(
                      controller: _reasonController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "请输入补录原因",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          // 提交补录逻辑
                          String score = _scoreController.text;
                          String reason = _reasonController.text;
                          String scoreType = _selectedScoreType;

                          // 在这里添加提交逻辑
                          print("提交补录信息：");
                          print("分数类型：$scoreType");
                          print("分数：$score");
                          print("原因：$reason");

                          Navigator.pop(context);
                        },
                        child: Text("提交"),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("取消"),
                      ),
                    ),
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