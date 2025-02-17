import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/login_page.dart';
import 'pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  const storage = FlutterSecureStorage();
  final prefs = await SharedPreferences.getInstance();
  
  // 尝试获取保存的数据
  final serverUrl = prefs.getString('serverUrl');
  final cookie = await storage.read(key: 'cloudreve-session');
  
  Widget home = const LoginPage();
  
  // 如果有保存的 cookie，验证是否有效
  if (serverUrl != null && cookie != null) {
    try {
      final response = await http.get(
        Uri.parse('$serverUrl/api/v3/user'),
        headers: {'Cookie': cookie},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 0) {
          final Map<String, dynamic> userInfo = {
            ...Map<String, dynamic>.from(data['data']),
            'serverUrl': serverUrl,
            'token': cookie,
          };
          home = MainPage(userInfo: userInfo);
        }
      }
    } catch (e) {
      debugPrint('Cookie验证失败: $e');
    }
  }
  
  runApp(MyApp(home: home));
}

class MyApp extends StatelessWidget {
  final Widget home;
  
  const MyApp({super.key, required this.home});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloudreve客户端',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: home,
    );
  }
} 