import 'dart:ffi';
import 'package:flutter/material.dart';

class DataImportExportPage extends StatefulWidget {
  const DataImportExportPage({super.key, required this.title});

  final String title;

  @override
  State<DataImportExportPage> createState() => _DataImportExportPageState();
}

class _DataImportExportPageState extends State<DataImportExportPage> {
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
                child: DataImportExportPageContent(),
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

class DataImportExportPageContent extends StatefulWidget {
  const DataImportExportPageContent({super.key});

  @override
  State<DataImportExportPageContent> createState() => _DataImportExportPageContentState();
}

// 界面主要框架
class _DataImportExportPageContentState extends State<DataImportExportPageContent> {

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
              ),
            ),
          ],
        );
      },
    );
  }
}