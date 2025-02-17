import 'package:flutter/material.dart';
// TODO: 添加PDF查看器依赖

class PDFViewerPage extends StatelessWidget {
  final String url;
  final String title;

  const PDFViewerPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text('PDF查看器开发中...'),
      ),
    );
  }
} 