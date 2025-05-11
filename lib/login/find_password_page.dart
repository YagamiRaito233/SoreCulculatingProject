import 'package:flutter/material.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({super.key, required this.title});

  final String title;

  @override
  State<FindPasswordPage> createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
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
                child: FindPasswordContent(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FindPasswordContent extends StatefulWidget {
  const FindPasswordContent({super.key});

  @override
  State<FindPasswordContent> createState() => _FindPasswordContentState();
}


// 重设密码的界面内容
class _FindPasswordContentState extends State<FindPasswordContent> {
  final _newPasswordController = TextEditingController(); // 输入的新密码
  final _newPasswordAgainController = TextEditingController(); // 再次输入的新密码

  // 确认按钮的处理函数
  _confirmQuest() {

  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _newPasswordAgainController.dispose();
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
                        child: Text("重设密码",
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
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      hintText: "请输入新密码",
                      prefixIcon: Icon(Icons.lock),
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
                          controller: _newPasswordAgainController,
                          decoration: InputDecoration(
                            hintText: "请确认新密码",
                            prefixIcon: Icon(Icons.lock),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
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
              ),
            ),
          ],
        );
      },
    );
  }
}

