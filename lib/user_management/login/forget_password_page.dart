import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key, required this.title});

  final String title;

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
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
                child: ForgetPasswordContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ForgetPasswordContent extends StatefulWidget {
  const ForgetPasswordContent({super.key});

  @override
  State<ForgetPasswordContent> createState() => _ForgetPasswordContentState();
}

// 忘记密码界面的内容
class _ForgetPasswordContentState extends State<ForgetPasswordContent> {
  final _phoneNumberController = TextEditingController(); // 输入的手机号
  final _verificationCodeController = TextEditingController(); // 输入的验证码

  // 确认按钮的处理函数
  _confirmQuest() {

    // 验证通过，跳转重设密码界面
    Navigator.pushReplacementNamed(context, '/find_password_page');
  }

  // 点击获取验证码按钮的函数
  _getVerificationCode() {

  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _verificationCodeController.dispose();
    super.dispose();
  }

  // 以下是layout，不用更改
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("忘记密码",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            height: 2.5,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
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
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: "请输入绑定手机号码",
                      prefixIcon: Icon(Icons.phone),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Material(
                        type: MaterialType.transparency,
                        child: TextField(
                          autofocus: true,
                          controller: _verificationCodeController,
                          decoration: InputDecoration(
                            hintText: "请输入验证码",
                            prefixIcon: Icon(Icons.domain_verification),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text("发送验证码",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      onPressed: _getVerificationCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
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
                    child: Text("确认",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    onPressed: _confirmQuest,
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

