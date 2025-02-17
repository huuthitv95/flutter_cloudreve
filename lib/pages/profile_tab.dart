import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  const ProfileTab({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('我的页面'),
      ),
    );
  }
} 