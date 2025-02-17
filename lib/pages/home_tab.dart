import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  const HomeTab({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('首页'),
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '快速访问',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: [
                    _buildQuickAccessItem(Icons.description, '文档'),
                    _buildQuickAccessItem(Icons.video_library, '视频'),
                    _buildQuickAccessItem(Icons.book, '图书'),
                    _buildQuickAccessItem(Icons.audiotrack, '音频'),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '最近文件',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        // TODO: 实现最近文件列表
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: Text('文件 ${index + 1}'),
                subtitle: Text('上次打开: ${DateTime.now().toString()}'),
              );
            },
            childCount: 10, // 临时显示10个项目
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
} 