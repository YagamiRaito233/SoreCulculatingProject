import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:points/user_management/login/login_page.dart';
import 'package:points/user_management/login/bind_phone_page.dart';
import 'package:points/user_management/login/forget_password_page.dart';
import 'package:points/user_management/login/find_password_page.dart';
import 'package:points/user_management/login/auth_provider.dart';
import 'package:points/school_committee/home_page.dart';
import 'package:points/school_committee/organizational_account_management_page.dart';
import 'package:points/school_committee/event_approval_page.dart';
import 'package:points/school_committee/data_maintenance_page.dart';
import 'package:points/school_committee/data_import_export_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.checkLoginStatus();

  runApp(
    ChangeNotifierProvider.value(
      value: authProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'points',
      initialRoute:"/school_league_committee/home_page", // 这个是初始界面，可以换成/login初始进入登录界面
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      onGenerateRoute:(RouteSettings settings) {
        WidgetBuilder builder;

        // 获取当前登录状态
        final authProvider = Provider.of<AuthProvider>(context, listen: false);

        // 定义需要登录的路由
        final protectedRoutes = ['/bind_phone_page'];

        // 检查是否访问受保护路由且未登录
        if (protectedRoutes.contains(settings.name) && !authProvider.isLoggedIn) {
          return MaterialPageRoute(
            builder: (_) => LoginPage(title: 'Login Page'),
            settings: settings,
          );
        }

        // 如果是从主页返回，直接退出
        if (settings.name == '/school_league_committee/home_page' && Navigator.canPop(context)) {
          SystemNavigator.pop();
          return null;
        }

        switch (settings.name) {
          case '/login_page':
            builder = (BuildContext context) => LoginPage(title: 'Login Page'); break;
          case '/forget_password_page':
            builder = (BuildContext context) => ForgetPasswordPage(title: 'Forget Password Page'); break;
          case '/bind_phone_page':
            builder = (BuildContext context) => BindPhonePage(title: 'Bind Phone Page'); break;
          case '/find_password_page':
            builder = (BuildContext context) => FindPasswordPage(title: 'Find Password Page'); break;
          case '/school_league_committee/home_page':
            builder = (BuildContext context) => SchoolHomePage(title: 'School Home Page'); break;
          case '/school_league_committee/organizational_account_management_page':
            builder = (BuildContext context) => OrganizationalAccountManagementPage(title: 'Organizational Account Management Page'); break;
          case '/school_league_committee/event_approval_page':
            builder = (BuildContext context) => EventApprovalPage(title: 'Event Approval Page'); break;
          case '/school_league_committee/data_maintenance_page':
            builder = (BuildContext context) => DataMaintenancePage(title: 'Data Maintenance Page'); break;
          case '/school_league_committee/data_import_export_page':
            builder = (BuildContext context) => DataImportExportPage(title: 'Data Import Export Page'); break;
          default:
            builder = (BuildContext context) => LoginPage(title: 'Login Page'); break;
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }
}