import 'package:flutter/material.dart';
import 'dart:convert';


class Student {
  String classInfo;
  String organization;
  String id;
  String name;
  String counselor;
  String phone;
  String isInOtherOrg;

  Student({
    required this.classInfo,
    required this.organization,
    required this.id,
    required this.name,
    required this.counselor,
    required this.phone,
    required this.isInOtherOrg,
  });

  // 从 JSON 创建 Student 对象
  factory Student.fromJson(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString); // 解析 JSON 字符串
    return Student(
      classInfo: jsonData['classInfo'],
      organization: jsonData['organization'],
      id: jsonData['id'],
      name: jsonData['name'],
      counselor: jsonData['counselor'],
      phone: jsonData['phone'],
      isInOtherOrg: jsonData['isInOtherOrg'],
    );
  }

  // 将 Student 对象转为 JSON 字符串
  String toJson() {
    final Map<String, dynamic> data = {
      'classInfo': classInfo,
      'organization': organization,
      'id': id,
      'name': name,
      'counselor': counselor,
      'phone': phone,
      'isInOtherOrg': isInOtherOrg,
    };
    return json.encode(data); // 转为 JSON 字符串
  }
}


class AddStudentPage extends StatefulWidget {
  final Student? student;

  const AddStudentPage({Key? key, this.student}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  late TextEditingController _nameController;
  late TextEditingController _idController;
  late TextEditingController _counselorController;
  late TextEditingController _phoneController;
  late TextEditingController _otherOrgController;
  String? _selectedClass;
  String? _selectedOrg;

  final List<String> classes = ['班级A', '班级B', '班级C'];
  final List<String> organizations = ['组织X', '组织Y', '组织Z'];

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    _nameController = TextEditingController(text: s?.name ?? '');
    _idController = TextEditingController(text: s?.id ?? '');
    _counselorController = TextEditingController(text: s?.counselor ?? '');
    _phoneController = TextEditingController(text: s?.phone ?? '');
    _otherOrgController = TextEditingController(text: s?.isInOtherOrg ?? '');
    _selectedClass = s?.classInfo ?? classes[0];
    _selectedOrg = s?.organization ?? organizations[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? '添加学生' : '编辑学生'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildField('学生姓名', _nameController),
                _buildField('学号', _idController),
                _buildDropdown('所在班级', _selectedClass, classes),
                _buildDropdown('所在组织', _selectedOrg, organizations),
                _buildField('辅导员', _counselorController),
                _buildField('联系电话', _phoneController),
                _buildField('是否在其他组织', _otherOrgController),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text('保存'),
                      onPressed: () {
                        final student = Student(
                          classInfo: _selectedClass!,
                          organization: _selectedOrg!,
                          id: _idController.text,
                          name: _nameController.text,
                          counselor: _counselorController.text,
                          phone: _phoneController.text,
                          isInOtherOrg: _otherOrgController.text,
                        );
                        Navigator.pop(context, student);
                      },
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.cancel),
                      label: Text('取消'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onChanged: (newValue) {
          setState(() {
            if (label == '所在班级') {
              _selectedClass = newValue;
            } else if (label == '所在组织') {
              _selectedOrg = newValue;
            }
          });
        },
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}


