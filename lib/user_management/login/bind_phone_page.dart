import 'package:flutter/material.dart';

class BindPhonePage extends StatefulWidget {
  const BindPhonePage({super.key, required this.title});

  final String title;

  @override
  State<BindPhonePage> createState() => _BindPhonePageState();
}

class _BindPhonePageState extends State<BindPhonePage> {
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
                child: BindPhoneContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BindPhoneContent extends StatefulWidget {
  const BindPhoneContent({super.key});

  @override
  State<BindPhoneContent> createState() => _BindPhoneContentState();
}

// 绑定手机界面的内容
class _BindPhoneContentState extends State<BindPhoneContent> {
  final _phoneNumberController = TextEditingController(); // 输入的手机号
  final _verificationCodeController = TextEditingController(); // 输入的验证码

  // 确认按钮的处理函数
  _confirmQuest() {

    // 绑定成功，登录进校团委首页（需要先判断账号身份）
    Navigator.pushReplacementNamed(context, '/school_league_committee/home_page');
  }

  // 获取验证码按钮的函数
  _getVerificationCode() {

  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _verificationCodeController.dispose();
    super.dispose();
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
                        child: Text("绑定手机",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            height: 2.5,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("首次登录需绑定手机，便于密码找回",
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
                      hintText: "请输入手机号码",
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

