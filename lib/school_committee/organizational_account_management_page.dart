import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:points/school_committee/add_account_page.dart';

class OrganizationalAccountManagementPage extends StatefulWidget {
  const OrganizationalAccountManagementPage({super.key, required this.title});

  final String title;

  @override
  State<OrganizationalAccountManagementPage> createState() => _OrganizationalAccountManagementPageState();
}

class _OrganizationalAccountManagementPageState extends State<OrganizationalAccountManagementPage> {
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
                child: OrganizationalAccountManagementPageContent(),
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

class OrganizationalAccountManagementPageContent extends StatefulWidget {
  const OrganizationalAccountManagementPageContent({super.key});

  @override
  State<OrganizationalAccountManagementPageContent> createState() => _OrganizationalAccountManagementPageContentState();
}

// 界面主要框架
class _OrganizationalAccountManagementPageContentState extends State<OrganizationalAccountManagementPageContent> {

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
                child: OrganizationalList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OrganizationalList extends StatefulWidget {
  const OrganizationalList({super.key});

  @override
  State<OrganizationalList> createState() => _OrganizationalListState();
}

// 界面主要列表
class _OrganizationalListState extends State<OrganizationalList> {
  List<Account> _accounts = [];

  // 初始化列表
  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    // 从后端获取数据
    // final response = await http.get(Uri.parse('your_api_url'));
    // setState(() {
    //   _accounts = (json.decode(response.body) as List)
    //       .map((item) => Account.fromJson(item))
    //       .toList();
    // });

    _accounts = [
      Account(id: 1, name: 'A Sensei1', employeeId: '1234123'),
      Account(id: 2, name: 'A Sensei2', employeeId: '1234124'),
      Account(id: 3, name: 'A Sensei3', employeeId: '1234125'),
      Account(id: 4, name: 'A Sensei4', employeeId: '1234126'),
      Account(id: 5, name: 'A Sensei5', employeeId: '1234127'),
      Account(id: 6, name: 'A Sensei6', employeeId: '1234128'),
      Account(id: 7, name: 'A Sensei7', employeeId: '1234129'),
      Account(id: 8, name: 'A Sensei8', employeeId: '1234130'),
      Account(id: 9, name: 'A Sensei9', employeeId: '1234131'),
    ];
  }

  // 获取学院菜单
  List<String> _getMajorMenu() {
    List<String> majors = ['计算机技术与科学暨软件学院', '海洋工程学院', '紫丁香书院', '商学院'];
    return majors;
  }

  // 获取组织菜单
  List<String> _getOrganizationMenu() {
    List<String> organizations = ['组织1', '组织2', '组织3', '组织4'];
    return organizations;
  }

  // 下拉菜单的选择逻辑
  void _onSelected(String? value) {

  }

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
                  onPressed: (){Navigator.pop(context);},
                )
              ),
            ),
            Positioned(
              left: maxWidth * 0.05,
              child: Container(
                width: maxWidth * 0.90,
                child: Text("组织/账号管理",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.01),
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
                            constraints: BoxConstraints.tightFor(height: maxHeight * 0.05),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: maxWidth * 0.03),
                      Material(
                        child: DropdownMenu<String>(
                          dropdownMenuEntries: _buildOrganizationMenu(_getOrganizationMenu()),
                          initialSelection: _getOrganizationMenu().first,
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
                            constraints: BoxConstraints.tightFor(height: maxHeight * 0.05),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.01),
            Positioned(
              left: maxWidth * 0.025,
              child: Container(
                width: maxWidth * 0.95,
                height: maxHeight * 0.670,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  itemCount: _accounts.length,
                  itemBuilder: (context, index) {
                    return _buildAccountItem(context, _accounts[index]);
                  },
                )
              ),
            ),
            SizedBox(height: maxHeight * 0.01),
            Positioned(
              left: maxWidth * 0.025,
              child: Container(
                width: maxWidth * 0.95,
                height: maxHeight * 0.12,
                child: Card(
                  color: Colors.grey[100],
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white, // 设置背景色
                      radius: 24,
                      child: Text('+',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: Text("添加账号"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAccountPage(),
                        ),
                      ).then((_) {
                        _fetchAccounts();
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<DropdownMenuEntry<String>> _buildMajorMenu(List<String> majors) {
    return majors.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  List<DropdownMenuEntry<String>> _buildOrganizationMenu(List<String> organizations) {
    return organizations.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  Widget _buildAccountItem(BuildContext context, Account account) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue, // 设置背景色
          radius: 24,
          child: Text(
            account.name.isNotEmpty ? account.name[0] : '?', // 取名字首字母
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(account.name),
        subtitle: Text(account.employeeId),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _showAccountActionsDialog(context, account),
      ),
    );
  }

  void _showAccountActionsDialog(BuildContext context, Account account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("账户操作"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue, // 设置背景色
              radius: 24,
              child: Text(
                account.name.isNotEmpty ? account.name[0] : '?', // 取名字首字母
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Text("姓名: ${account.name}"),
            Text("工号: ${account.employeeId}"),
          ],
        ),
        actions: [
          TextButton(
            child: Text("编辑"),
            onPressed: () => _showEditDialog(context, account),
          ),
          TextButton(
            child: Text("删除", style: TextStyle(color: Colors.red)),
            onPressed: () => _confirmDelete(context, account),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Account account) {
    final nameController = TextEditingController(text: account.name);
    final idController = TextEditingController(text: account.employeeId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("编辑账户"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "姓名"),
            ),
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: "工号"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("取消"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("确认"),
            onPressed: () {
              final updatedAccount = Account(
                id: account.id,
                name: nameController.text,
                employeeId: idController.text,
              );
               // 更新数据
              Navigator.pop(context); // 关闭编辑对话框
              Navigator.pop(context); // 关闭操作对话框
              _showAccountActionsDialog(context, updatedAccount); // 重新打开（可选）
            },
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, Account account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("确认删除？"),
        content: Text("确定要删除 ${account.name} 的账户吗？"),
        actions: [
          TextButton(
            child: Text("取消"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("删除", style: TextStyle(color: Colors.red)),
            onPressed: () {
               // 执行删除
              Navigator.pop(context); // 关闭确认对话框
              Navigator.pop(context); // 关闭操作对话框
            },
          ),
        ],
      ),
    );
  }
}

class Account {
  final int id;
  final String name;
  final String employeeId;

  Account({
    required this.id,
    required this.name,
    required this.employeeId,
  });
}