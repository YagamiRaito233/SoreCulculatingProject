import 'dart:ffi';
import 'package:flutter/material.dart';

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

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: maxWidth,
                height: maxHeight * 0.25,
                child: Image(
                  image: AssetImage("images/school.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: maxWidth,
                height: maxHeight * 0.80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: AddAccountContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AddAccountContent extends StatefulWidget {
  const AddAccountContent({super.key});

  @override
  State<AddAccountContent> createState() => _AddAccountContentState();
}

// 添加账户界面的内容
class _AddAccountContentState extends State<AddAccountContent> {
  final _usernameController = TextEditingController(); // 输入的用户名
  final _idController = TextEditingController(); // 输入的工号
  final _passwordController = TextEditingController(); // 输入的密码
  final _professionController = TextEditingController(); // 选择的身份

  // 处理添加按钮的函数
  _addAccountQuest() {

    Navigator.pop(context);
  }

  // 处理批量添加按钮的函数
  _addMoreAccountsQuest() {

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _professionController.dispose();
    super.dispose();
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
              left: maxWidth * 0.1,
              child: Container(
                width: maxWidth * 0.8,
                height: maxHeight * 0.2,
                child: Text("添加账号",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    height: 2.5,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.1,
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    autofocus: true,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "请输入用户名",
                      prefixIcon: Icon(Icons.people),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.1,
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    autofocus: true,
                    controller: _idController,
                    decoration: InputDecoration(
                      hintText: "请输入工号",
                      prefixIcon: Icon(Icons.perm_identity_outlined),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.1,
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    autofocus: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.1,
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    autofocus: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "请选择身份",
                      prefixIcon: Icon(Icons.people_alt_outlined),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            SizedBox(height: maxHeight * 0.05),
            Positioned(
                left: maxWidth * 0.08,
                child: Container(
                  width: maxWidth * 0.84,
                  height: maxHeight * 0.06,
                  child: ElevatedButton(
                    child: Text("添加",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    onPressed: _addAccountQuest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                )
            ),
            SizedBox(height: maxHeight * 0.05),
            Positioned(
                left: maxWidth * 0.08,
                child: Container(
                  width: maxWidth * 0.84,
                  height: maxHeight * 0.06,
                  child: ElevatedButton(
                    child: Text("批量添加",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    onPressed: _addMoreAccountsQuest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                )
            ),
          ],
        );
      },
    );
  }
}