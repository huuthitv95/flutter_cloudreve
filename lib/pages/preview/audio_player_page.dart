import 'package:flutter/material.dart';
// TODO: 添加音频播放器依赖

class AudioPlayerPage extends StatelessWidget {
  final String url;
  final String title;

  const AudioPlayerPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text('音频播放器开发中...'),
      ),
    );
  }
} 