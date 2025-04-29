import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:score_culculating_project/academy_committee/studentinfo/AddStudentPage.dart';
import 'package:score_culculating_project/academy_committee/studentinfo/AddStudentPage.dart' show Student;

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  _StudentInfoPageState createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  List<Student> students = [];
  String? selectedClass;
  String? selectedOrg;

  List<String> classes = ['全部班级', '班级A', '班级B', '班级C'];
  List<String> organizations = ['全部组织', '组织X', '组织Y', '组织Z'];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  // 从 SharedPreferences 中加载学生数据
  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedStudents = prefs.getStringList('students') ?? [];
    setState(() {
      students = savedStudents.map((studentJson) {
        return Student.fromJson(studentJson); // 假设 Student 类有 fromJson 方法
      }).toList();
    });
  }

  // 保存学生数据到 SharedPreferences
  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> studentJsons = students.map((student) => student.toJson()).toList(); // 假设 Student 类有 toJson 方法
    await prefs.setStringList('students', studentJsons);
  }

  @override
  Widget build(BuildContext context) {
    var filteredStudents = students.where((student) {
      bool matchesClass = selectedClass == null || selectedClass == '全部班级' || student.classInfo == selectedClass;
      bool matchesOrg = selectedOrg == null || selectedOrg == '全部组织' || student.organization == selectedOrg;
      return matchesClass && matchesOrg;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('学生信息管理'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: '添加学生',
            onPressed: () async {
              final newStudent = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudentPage()),
              );
              if (newStudent != null) {
                setState(() {
                  students.add(newStudent);
                });
                await _saveStudents(); // 添加后保存学生数据
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 筛选班级和组织
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedClass,
                  hint: Text('选择班级'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                  items: classes.map((classInfo) {
                    return DropdownMenuItem<String>(
                      value: classInfo,
                      child: Text(classInfo),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: selectedOrg,
                  hint: Text('选择组织'),
                  onChanged: (newValue) {
                    setState(() {
                      selectedOrg = newValue;
                    });
                  },
                  items: organizations.map((org) {
                    return DropdownMenuItem<String>(
                      value: org,
                      child: Text(org),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // 学生列表
          Expanded(
            child: filteredStudents.isEmpty
                ? Center(child: Text('暂无学生数据'))
                : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        student.name.isNotEmpty ? student.name[0] : '?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(student.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('学号：${student.id}'),
                        Text('班级：${student.classInfo}'),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddStudentPage(student: student),
                            ),
                          ).then((updatedStudent) {
                            if (updatedStudent != null) {
                              setState(() {
                                students[index] = updatedStudent;
                              });
                              _saveStudents(); // 更新后保存数据
                            }
                          });
                        } else if (value == 'delete') {
                          setState(() {
                            students.removeAt(index);
                          });
                          _saveStudents(); // 删除后保存数据
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('编辑'),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('删除'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




