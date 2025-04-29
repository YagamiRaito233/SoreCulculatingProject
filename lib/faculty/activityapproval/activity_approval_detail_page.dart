import 'package:flutter/material.dart';
import 'approval_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityDetailPage extends StatefulWidget {
  final Map<String, dynamic> activity;
  const ActivityDetailPage({super.key, required this.activity});

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("2024 - 2025春季学期"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("返回"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "活动详情",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    "A",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                widget.activity['organization'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("活动名称：${widget.activity['name']}"),
                  SizedBox(height: 8),
                  Text("负责组织："),
                  SizedBox(height: 8),
                  Text("时间：${widget.activity['time']}"),
                  SizedBox(height: 8),
                  Text("地点："),
                  SizedBox(height: 8),
                  Text("附件："),
                  SizedBox(height: 8),
                  Text("备注："),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text("审批详情"),
                    SizedBox(height: 8),
                    Text(
                      widget.activity['isApproved'] || (widget.activity['rejectReason']!= null && widget.activity['rejectReason'].isNotEmpty)
                          ? '已审批'
                          : '您还未审批!',
                      style: TextStyle(
                        color: widget.activity['isApproved']
                            ? Colors.green
                            : widget.activity['rejectReason']!= null && widget.activity['rejectReason'].isNotEmpty
                            ? Colors.red
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text("驳回详情"),
                    SizedBox(height: 8),
                    Text(
                      widget.activity['isApproved']
                          ? '无'
                          : widget.activity['rejectReason']!= null && widget.activity['rejectReason'].isNotEmpty
                          ? '未通过审批，原因：${widget.activity['rejectReason']}'
                          : '您还未审批!',
                      style: TextStyle(
                        color: widget.activity['isApproved']
                            ? Colors.green
                            : widget.activity['rejectReason']!= null && widget.activity['rejectReason'].isNotEmpty
                            ? Colors.red
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (!widget.activity['isApproved'] && (widget.activity['rejectReason'] == null || widget.activity['rejectReason'].isEmpty)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApprovalDetailPage(
                            activity: widget.activity,
                          ),
                        ),
                      ).then((updatedActivity) {
                        if (updatedActivity != null) {
                          setState(() {
                            widget.activity['isApproved'] = updatedActivity['isApproved'];
                            widget.activity['rejectReason'] = updatedActivity['rejectReason'];
                          });
                        }
                      });
                    }
                  },
                  child: Text("操作"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}