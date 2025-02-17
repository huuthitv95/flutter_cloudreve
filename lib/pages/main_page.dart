import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'files_tab.dart';
import 'profile_tab.dart';

class MainPage extends StatefulWidget {
  final Map<String, dynamic> userInfo;

  const MainPage({super.key, required this.userInfo});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeTab(userInfo: widget.userInfo),
      FilesTab(userInfo: widget.userInfo),
      ProfileTab(userInfo: widget.userInfo),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: '文件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
} 