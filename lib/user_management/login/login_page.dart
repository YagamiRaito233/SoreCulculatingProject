import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:points/user_management/login/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                child: LoginContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

// 登录界面的内容
class _LoginContentState extends State<LoginContent> {
  bool _checkboxSelected = true; // 是否同意协议
  final _idController = TextEditingController(); // 输入的学号/工号
  final _passwordController = TextEditingController(); // 输入的密码

  // 处理登录按钮的函数
  _loginQuest() {

    // 登录成功，更新登录状态，并跳转绑定手机界面（需要判断是否绑定）
    Provider.of<AuthProvider>(context, listen: false).login();
    Navigator.pushReplacementNamed(context, '/bind_phone_page');
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 都是layout，只需更改247行的用户协议跳转
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
                child: Text("登录",
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
                    controller: _idController,
                    decoration: InputDecoration(
                      hintText: "请输入学号/工号",
                      prefixIcon: Icon(Icons.person),
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
              right: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.05,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: Text("忘记密码？",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.0,
                        height: 1.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/forget_password_page');
                    },
                  ),
                )
              ),
            ),
            SizedBox(height: maxHeight * 0.05),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.06,
                child: ElevatedButton(
                  child: Text("登录",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  onPressed: _loginQuest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              )
            ),
            Positioned(
              left: maxWidth * 0.08,
              child: Container(
                width: maxWidth * 0.84,
                height: maxHeight * 0.1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Material(
                      type: MaterialType.transparency,
                      child: Checkbox(
                        value: _checkboxSelected,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _checkboxSelected = value!;
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("同意",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          height: 1.0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: Text("《用户服务与隐私协议》",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.0,
                            height: 1.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}