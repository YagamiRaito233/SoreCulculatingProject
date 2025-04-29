import 'package:flutter/material.dart';
import 'package:score_culculating_project/academy_committee/activityApproval/ActivityApprovalActionPage.dart';

class ActivityDetailPage extends StatelessWidget {
  final String activityName;
  final String activityteacher;
  final String activitydate;
  final String activitycollege;
  final Function(String) updateStatus; // 添加 updateStatus 参数

  const ActivityDetailPage({super.key, required this.activityName,
    required this.activityteacher,required this.activitydate,required this.activitycollege,
    required this.updateStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('活动详情'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(activityName[0], style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            Text('活动名称：$activityName'),
            Text('负责人：$activityteacher'),
            Text('时间：$activitydate'),
            Text('学院：$activitycollege'),
            Text('附件：无'),
            Text('备注：无'),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('操作'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityApprovalActionPage(activityName: activityName, updateStatus: updateStatus)), // 传递 updateStatus
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



