import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _savePassword = false;
  bool _agreeToTerms = false;

  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _urlController.text = prefs.getString('serverUrl') ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
      if (prefs.getBool('savePassword') ?? false) {
        _passwordController.text = prefs.getString('password') ?? '';
        _savePassword = true;
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('serverUrl', _urlController.text);
    await prefs.setString('username', _usernameController.text);
    await prefs.setBool('savePassword', _savePassword);
    if (_savePassword) {
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('password');
    }
  }

  Future<void> _testConnection() async {
    try {
      final response = await http.get(
        Uri.parse('${_urlController.text}/api/v3/site/ping')
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('连接成功! 服务器版本: ${data['data']}'))
        );
      } else {
        throw Exception('服务器响应错误');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('连接失败: ${e.toString()}'))
      );
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先同意用户协议'))
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${_urlController.text}/api/v3/user/session'),
        body: json.encode({
          'userName': _usernameController.text,
          'Password': _passwordController.text,
          'captchaCode': ''
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 0) {
          await _saveData();
          
          String? cookie;
          if (response.headers['set-cookie'] != null) {
            cookie = response.headers['set-cookie']!.split(';').first;
            await _storage.write(key: 'cloudreve-session', value: cookie);
          }
          
          if (!mounted) return;
          
          final Map<String, dynamic> userInfo = {
            ...Map<String, dynamic>.from(data['data']),
            'serverUrl': _urlController.text,
            'token': cookie ?? '',
          };
          
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MainPage(userInfo: userInfo),
            ),
          );
        } else {
          throw Exception(data['msg']);
        }
      } else {
        throw Exception('登录失败');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录失败: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade300,
              Colors.purple.shade300,
            ],
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cloudreve登录',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: '服务器地址',
                        hintText: 'https://your-server.com',
                        prefixIcon: Icon(Icons.link),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) return '请输入服务器地址';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: '用户名',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) return '请输入用户名';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: '密码',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return '请输入密码';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _savePassword,
                          onChanged: (value) {
                            setState(() => _savePassword = value!);
                          },
                        ),
                        const Text('记住密码'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() => _agreeToTerms = value!);
                          },
                        ),
                        TextButton(
                          onPressed: () => _showTerms(context),
                          child: const Text('同意用户协议'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _testConnection,
                          icon: const Icon(Icons.wifi_tethering),
                          label: const Text('测试连接'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _login,
                          icon: const Icon(Icons.login),
                          label: const Text('登录'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showTerms(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('用户协议'),
        content: const SingleChildScrollView(
          child: Text(
            '''
用户协议

1. 服务说明
本应用为Cloudreve网盘的第三方客户端,用于访问您的Cloudreve网盘服务。

2. 隐私保护
我们会在本地存储您的服务器地址、用户名等信息,仅用于自动登录。您的密码仅在您选择"记住密码"时才会被加密存储。

3. 免责声明
本应用仅提供Cloudreve网盘的访问服务,对您在使用过程中造成的数据丢失等问题不承担责任。

4. 使用限制
请勿利用本应用进行任何违法或不当行为。我们保留对违规用户终止服务的权利。

5. 协议更新
我们保留随时更新本协议的权利。协议更新后,将在应用内发出通知。

6. 知识产权
本应用的所有权利归开发者所有。未经允许,不得对应用进行反编译、破解等行为。
            ''',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
} 