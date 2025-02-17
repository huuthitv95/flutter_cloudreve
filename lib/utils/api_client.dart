import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String serverUrl;
  final String cookie;

  ApiClient({required this.serverUrl, required this.cookie});

  Map<String, String> get _headers => {
    'Cookie': cookie,
    'Content-Type': 'application/json',
  };

  Future<dynamic> get(String path) async {
    final response = await http.get(
      Uri.parse('$serverUrl$path'),
      headers: _headers,
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['code'] == 0) {
        return data['data'];
      }
      throw Exception(data['msg']);
    }
    throw Exception('请求失败: ${response.statusCode}');
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$serverUrl$path'),
      headers: _headers,
      body: body != null ? json.encode(body) : null,
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['code'] == 0) {
        return data['data'];
      }
      throw Exception(data['msg']);
    }
    throw Exception('请求失败: ${response.statusCode}');
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? body}) async {
    final response = await http.put(
      Uri.parse('$serverUrl$path'),
      headers: _headers,
      body: body != null ? json.encode(body) : null,
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['code'] == 0) {
        return data['data'];
      }
      throw Exception(data['msg']);
    }
    throw Exception('请求失败: ${response.statusCode}');
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? body}) async {
    final response = await http.delete(
      Uri.parse('$serverUrl$path'),
      headers: _headers,
      body: body != null ? json.encode(body) : null,
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['code'] == 0) {
        return data['data'];
      }
      throw Exception(data['msg']);
    }
    throw Exception('请求失败: ${response.statusCode}');
  }
} 