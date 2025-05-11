import 'dart:ffi';
import 'package:flutter/material.dart';

class SchoolHomePage extends StatefulWidget {
  const SchoolHomePage({super.key, required this.title});

  final String title;

  @override
  State<SchoolHomePage> createState() => _SchoolHomePageState();
}

class _SchoolHomePageState extends State<SchoolHomePage> {
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
                child: SchoolHomePageContent(termName: termName),
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

class SchoolHomePageContent extends StatefulWidget {
  const SchoolHomePageContent({super.key, required this.termName});

  final String termName;

  @override
  State<SchoolHomePageContent> createState() => _SchoolHomePageContentState(termName: termName);
}

// 界面主要框架
class _SchoolHomePageContentState extends State<SchoolHomePageContent> {
  _SchoolHomePageContentState({required this.termName});

  final termName;

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
            // 上部蓝色框，是简单数据统计
            Positioned(
              left: maxWidth * 0.03,
              child: Container(
                width: maxWidth * 0.94,
                height: maxHeight * 0.105,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SimpleStatisticsContent(),
              ),
            ),
            SizedBox(height: maxHeight * 0.02),
            // 中部白色框，是数据看板
            Positioned(
              left: maxWidth * 0.03,
              child: Container(
                width: maxWidth * 0.94,
                height: maxHeight * 0.630,
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
                child: DataBoardContent(termName: termName),
              ),
            ),
            SizedBox(height: maxHeight * 0.02),
            // 下部白色框，是底部功能选择导航栏
            Positioned(
              left: maxWidth * 0.03,
              child: Container(
                width: maxWidth * 0.94,
                height: maxHeight * 0.11,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FunctionSelectionContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SimpleStatisticsContent extends StatefulWidget {
  const SimpleStatisticsContent({super.key});

  @override
  State<SimpleStatisticsContent> createState() => _SimpleStatisticsContentState();
}

// 简单数据统计内容(上部蓝色框)
class _SimpleStatisticsContentState extends State<SimpleStatisticsContent> {
  final _allActivityNumber = 10; // 全部活动
  final _inProgressNumber = 2; // 正在进行
  final _pendingApprovalNumber = 3; // 待审批
  final _endedActivityNumber = 5; // 已结束

  // layout
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: maxWidth * 0.04),
            Positioned(
              top: maxHeight * 0.2,
              child: Container(
                height: maxHeight * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('$_allActivityNumber',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text("全部活动",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              )
            ),
            SizedBox(width: maxWidth * 0.1),
            Positioned(
              top: maxHeight * 0.2,
              child: Container(
                height: maxHeight * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('$_inProgressNumber',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text("正在进行",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              )
            ),
            SizedBox(width: maxWidth * 0.1),
            Positioned(
              top: maxHeight * 0.2,
              child: Container(
                height: maxHeight * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('$_pendingApprovalNumber',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text("待审批",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: maxWidth * 0.1),
            Positioned(
              top: maxHeight * 0.2,
              child: Container(
                height: maxHeight * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('$_endedActivityNumber',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Text("已结束",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

class DataBoardContent extends StatefulWidget {
  const DataBoardContent({super.key, required this.termName});

  final String termName;

  @override
  State<DataBoardContent> createState() => _DataBoardContentState(termName: termName);
}

// 数据看板内容
class _DataBoardContentState extends State<DataBoardContent> {
  _DataBoardContentState({required this.termName});

  final String termName;
  final _inProgressNumber = 2; // 正在进行活动
  final _peopleNumber = 200; // 参与人数

  // 获取学期菜单
  List<String> _getTermMenu(String beginTerm) {
    List<String> terms = ['2025春'];
    terms.add('2024秋');
    terms.add('2024夏');
    terms.add('2024春');
    terms.add('2023秋');
    return terms;
  }

  // 获取学院菜单
  List<String> _getMajorMenu() {
    List<String> majors = ['计算机技术与科学暨软件学院', '海洋工程学院', '紫丁香书院', '商学院'];
    return majors;
  }

  // 下拉菜单的选择逻辑
  void _onSelected(String? value) {

  }

  // layout
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: maxHeight * 0.015),
            Positioned(
              left: maxWidth * 0.025,
              child: Container(
                width: maxWidth * 0.95,
                child: Text("数据看板",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.03),
            Positioned(
              left: 0,
              child: Container(
                width: maxWidth,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Material(
                        child: DropdownMenu<String>(
                          dropdownMenuEntries: _buildTermMenu(_getTermMenu(termName)),
                          initialSelection: _getTermMenu(termName).first,
                          onSelected: _onSelected,
                          width: maxWidth * 0.3,
                          enableFilter: false,
                          requestFocusOnTap: false,
                          textStyle: TextStyle(
                            color: Colors.black,
                            height: 1.0,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Color(0xFFE2E2E2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            constraints: BoxConstraints.tightFor(height: maxHeight * 0.08),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: maxWidth * 0.03),
                      Material(
                        child: DropdownMenu<String>(
                          dropdownMenuEntries: _buildMajorMenu(_getMajorMenu()),
                          initialSelection: _getMajorMenu().first,
                          onSelected: _onSelected,
                          width: maxWidth * 0.6,
                          enableFilter: false,
                          requestFocusOnTap: false,
                          textStyle: TextStyle(
                            color: Colors.black,
                            height: 1.0,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Color(0xFFE2E2E2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            constraints: BoxConstraints.tightFor(height: maxHeight * 0.08),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.02),
            Positioned(
              left: maxWidth * 0.05,
              child: Container(
                width: maxWidth * 0.90,
                height: maxHeight * 0.53,
                /*child: ChartDataDisplay(),*/
              ),
            ),
            SizedBox(height: maxHeight * 0.02),
            Positioned(
              left: maxWidth * 0.025,
              child: Container(
                width: maxWidth * 0.95,
                child: Text("实时数据",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.02),
            Positioned(
              left: maxWidth * 0.1,
              child: Container(
                width: maxWidth * 0.8,
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("正在进行的活动：",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text("$_inProgressNumber",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(" 个",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: maxWidth * 0.1,
              child: Container(
                width: maxWidth * 0.8,
                child: Row(
                  children: <Widget>[
                    Text("参与人数：",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("$_peopleNumber",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ),
                    Text(" 个",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  List<DropdownMenuEntry<String>> _buildTermMenu(List<String> terms) {
    return terms.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  List<DropdownMenuEntry<String>> _buildMajorMenu(List<String> majors) {
    return majors.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }
}

// 图表
/*
class ChartDataDisplay extends StatefulWidget {
  const ChartDataDisplay({super.key});

  @override
  State<ChartDataDisplay> createState() => _ChartDataDisplayState();
}

class _ChartDataDisplayState extends State<ChartDataDisplay> {
  final List<String> activityTypes = ['活动类型A', '活动类型B', '活动类型C']; // 活动类型
  final List<String> months = ['2月', '3月', '4月', '5月', '6月']; // 月份
  final List<List<double>> data = [
    [100, 150, 219], // 2月
    [140, 100, 168],    // 3月
    [230, 200, 179],  // 4月
    [100, 140, 168],     // 5月
    [130, 100, 142],       // 6月 (示例数据中没有，假设为0)
  ];// 数据: [月份][活动类型]
  final List<Color> activityColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
  ];// 颜色定义

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 活动类型图例

            // 柱状图
            Expanded(child: BarChart(BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              groupsSpace: 10, // 组间间距
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.white,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final month = months[group.x.toInt()];
                    final activity = activityTypes[rodIndex];
                    return BarTooltipItem(
                      '$month $activity\n${rod.toY.toInt()}',
                      TextStyle(
                        color: activityColors[rodIndex],
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    margin: 16,
                    getTitles: (double value) {
                      return months[value.toInt()];
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,

                    getTextStyles: (context, value) => TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    margin: 30,
                    interval: 50, // Y轴刻度间隔
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              barGroups: _generateBarGroups(),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 50,
              ),
              maxY: 250, // 根据你的数据最大值设置
            ))),
          ],
        );
      },
    );
  }
}
*/
class FunctionSelectionContent extends StatefulWidget {
  const FunctionSelectionContent({super.key});

  @override
  State<FunctionSelectionContent> createState() => _FunctionSelectionContentState();
}

// 底部功能选择导航栏内容
class _FunctionSelectionContentState extends State<FunctionSelectionContent> {
  // 定义各个导航
  _routeOrganizationalAccountManagementPage() {
    Navigator.pushNamed(context, '/school_league_committee/organizational_account_management_page');
  }
  _routeEventApprovalPage() {
    Navigator.pushNamed(context, '/school_league_committee/event_approval_page');
  }
  _routeDataMaintenancePage() {
    Navigator.pushNamed(context, '/school_league_committee/data_maintenance_page');
  }
  _routeDataImportExportPage() {
    Navigator.pushNamed(context, '/school_league_committee/data_import_export_page');
  }

  // layout
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                height: maxHeight,
                width: maxWidth * 0.246,
                child: TextButton(
                  onPressed: _routeOrganizationalAccountManagementPage,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.manage_accounts,
                        size: 40,
                        color: Color(0xFF5ACAE4),
                      ),
                      Text("组织/账号管理",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
            Positioned(
              top: 0,
              child: Container(
                height: maxHeight,
                width: maxWidth * 0.005,
                color: Colors.black12,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: maxHeight,
                width: maxWidth * 0.246,
                child: TextButton(
                  onPressed: _routeEventApprovalPage,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.checklist,
                        size: 40,
                        color: Colors.orange,
                      ),
                      Text("活动审批",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: maxHeight,
                width: maxWidth * 0.005,
                color: Colors.black12,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: maxHeight,
                width: maxWidth * 0.246,
                child: TextButton(
                  onPressed: _routeDataMaintenancePage,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.wifi_protected_setup,
                        size: 40,
                        color: Color(0xFFE45245),
                      ),
                      Text("数据维护",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: maxHeight,
                width: maxWidth * 0.005,
                color: Colors.black12,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: maxHeight,
                width: maxWidth * 0.246,
                child: TextButton(
                  onPressed: _routeDataImportExportPage,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.import_export,
                        size: 40,
                        color: Color(0xFF66C17E),
                      ),
                      Text("全局报表导出",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}