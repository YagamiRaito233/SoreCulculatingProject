import 'dart:ffi';
import 'package:flutter/material.dart';

class DataMaintenancePage extends StatefulWidget {
  const DataMaintenancePage({super.key, required this.title});

  final String title;

  @override
  State<DataMaintenancePage> createState() => _DataMaintenancePageState();
}

class _DataMaintenancePageState extends State<DataMaintenancePage> {
  // 全局变量设置
  final termName = "2024-2025春季学期"; // 学期名字
  final termTime = "2025.2.28-2025.6.28"; // 学期时间

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: maxWidth,
                height: maxHeight * 0.15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      Colors.blue,
                      Color(0xFFE2E2E2),
                    ],
                    stops: [0.0, 0.7, 1.0],
                  ),
                ),
                child: TopNavigationContent(termName: termName, termTime: termTime),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: maxWidth,
                height: maxHeight * 0.85,
                decoration: BoxDecoration(
                  color: Color(0xFFE2E2E2),
                ),
                child: DataMaintenancePageContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TopNavigationContent extends StatefulWidget {
  const TopNavigationContent({super.key, required this.termName, required this.termTime});

  final String termName, termTime;

  @override
  State<TopNavigationContent> createState() => _TopNavigationContentState(termName: termName, termTime: termTime);
}

// 顶部导航栏内容
class _TopNavigationContentState extends State<TopNavigationContent> {
  _TopNavigationContentState({required this.termName, required this.termTime});

  final String termName, termTime;

  // layout
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          return Stack(
            children: <Widget>[
              Positioned(
                top: maxHeight * 0.40,
                left: maxWidth * 0.06,
                child: Container(
                  width: maxWidth * 0.12,
                  height: maxWidth * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text("校",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                ),
              ),
              Positioned(
                top: maxHeight * 0.40,
                left: 0,
                child: Container(
                  width: maxWidth,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("$termName",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: maxHeight * 0.02),
                        Text("$termTime",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}

class DataMaintenancePageContent extends StatefulWidget {
  const DataMaintenancePageContent({super.key});

  @override
  State<DataMaintenancePageContent> createState() => _DataMaintenancePageContentState();
}

// 界面主要框架
class _DataMaintenancePageContentState extends State<DataMaintenancePageContent> {

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: maxHeight * 0.01),
            Positioned(
              left: maxWidth * 0.03,
              child: Container(
                width: maxWidth * 0.94,
                height: maxHeight * 0.885,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5.0, 2.0),
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      )
                    ]
                ),
                child: DataMaintenanceList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DataMaintenanceList extends StatefulWidget {
  const DataMaintenanceList({super.key});

  @override
  State<DataMaintenanceList> createState() => _DataMaintenanceListState();
}

// 界面主要列表
class _DataMaintenanceListState extends State<DataMaintenanceList> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Positioned(
              left: maxWidth * 0.01,
              child: Container(
                width: maxWidth * 0.98,
                child: TextButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(Icons.arrow_back_ios_new,
                        size: 25,
                        color: Colors.black54,
                      ),
                      Text("返回首页",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                        )
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ),
            ),
            Positioned(
              left: maxWidth * 0.05,
              child: Container(
                width: maxWidth * 0.90,
                child: Text("数据维护",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.05),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5.0, 2.0),
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    )
                  ],
                ),
                child: TextButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(Icons.people,
                        size: 50,
                        color: Colors.orange,
                      ),
                      Text(" 全校数据导入/导出",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          decoration: TextDecoration.none,
                        )
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ),
            ),
            SizedBox(height: maxHeight * 0.05),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5.0, 2.0),
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: TextButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(Icons.people,
                        size: 50,
                        color: Colors.orange,
                      ),
                      Text(" 学校/班级数据管理",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          decoration: TextDecoration.none,
                        )
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ),
            ),
            SizedBox(height: maxHeight * 0.05),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5.0, 2.0),
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: TextButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(Icons.people,
                        size: 50,
                        color: Colors.orange,
                      ),
                      Text(" 学号冲突检测",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          decoration: TextDecoration.none,
                        )
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ),
            ),
          ],
        );
      },
    );
  }
}