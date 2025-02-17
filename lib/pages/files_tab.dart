import 'package:flutter/material.dart';
import 'dart:convert';
import '../utils/api_client.dart';
import 'preview/image_preview_page.dart';
import 'preview/video_player_page.dart';
import 'preview/audio_player_page.dart';
import 'preview/pdf_viewer_page.dart';

class FilesTab extends StatefulWidget {
  final Map<String, dynamic> userInfo;

  const FilesTab({super.key, required this.userInfo});

  @override
  State<FilesTab> createState() => _FilesTabState();
}

class _FilesTabState extends State<FilesTab> {
  String _currentPath = '/';
  List<String> _pathSegments = ['/'];
  List<dynamic> _files = [];
  bool _isListView = true;
  String _sortBy = 'name';
  bool _ascending = true;
  final TextEditingController _searchController = TextEditingController();
  bool _isSelectionMode = false;
  Set<String> _selectedFiles = {};
  bool _hasShownExitWarning = false;
  late final ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _apiClient = ApiClient(
      serverUrl: widget.userInfo['serverUrl'],
      cookie: 'cloudreve-session=${widget.userInfo['token']}',
    );
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    try {
      final data = await _apiClient.get('/api/v3/directory${_currentPath == "/" ? "" : _currentPath}');
      setState(() {
        _files = data['objects'];
        _sortFiles();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载失败: $e')),
        );
      }
    }
  }

  void _sortFiles() {
    _files.sort((a, b) {
      // 文件夹始终在前
      if (a['type'] == 'dir' && b['type'] != 'dir') return -1;
      if (a['type'] != 'dir' && b['type'] == 'dir') return 1;

      switch (_sortBy) {
        case 'name':
          return _ascending ? 
            a['name'].compareTo(b['name']) :
            b['name'].compareTo(a['name']);
        case 'size':
          return _ascending ?
            a['size'].compareTo(b['size']) :
            b['size'].compareTo(a['size']);
        case 'modified':
          return _ascending ?
            a['date'].compareTo(b['date']) :
            b['date'].compareTo(a['date']);
        default:
          return 0;
      }
    });
  }

  void _navigateToPath(String path) {
    setState(() {
      _currentPath = path;
      _pathSegments = path.split('/')
        .where((segment) => segment.isNotEmpty)
        .toList();
      _pathSegments.insert(0, '/');
    });
    _loadFiles();
  }

  IconData _getFileIcon(String type, String name) {
    if (type == 'dir') return Icons.folder;
    
    final extension = name.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'mp4':
      case 'avi':
        return Icons.video_file;
      case 'mp3':
      case 'wav':
        return Icons.audio_file;
      default:
        return Icons.insert_drive_file;
    }
  }

  Future<void> _showFileOperations(Map<String, dynamic> file) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('下载'),
            onTap: () => Navigator.pop(context, 'download'),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('分享'),
            onTap: () => Navigator.pop(context, 'share'),
          ),
          if (file['type'] != 'dir') ...[
            ListTile(
              leading: const Icon(Icons.preview),
              title: const Text('预览'),
              onTap: () => Navigator.pop(context, 'preview'),
            ),
          ],
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('删除'),
            onTap: () => Navigator.pop(context, 'delete'),
          ),
          ListTile(
            leading: const Icon(Icons.drive_file_move),
            title: const Text('移动'),
            onTap: () => Navigator.pop(context, 'move'),
          ),
        ],
      ),
    );

    if (result == null) return;

    switch (result) {
      case 'download':
        await _downloadFile(file);
        break;
      case 'share':
        await _shareFile(file);
        break;
      case 'preview':
        await _previewFile(file);
        break;
      case 'delete':
        await _deleteFile(file);
        break;
      case 'move':
        await _moveFile(file);
        break;
    }
  }

  Future<void> _downloadFile(Map<String, dynamic> file) async {
    try {
      final data = await _apiClient.put('/api/v3/file/download/${file['id']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('开始下载: ${file['name']}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('下载失败: $e')),
      );
    }
  }

  Future<void> _shareFile(Map<String, dynamic> file) async {
    try {
      final data = await _apiClient.post('/api/v3/share', body: {
        'id': file['id'],
        'is_dir': file['type'] == 'dir',
        'password': '',
        'downloads': -1,
        'expire': 0,
        'preview': true,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('分享链接: $data')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('分享失败: $e')),
      );
    }
  }

  Future<void> _previewFile(Map<String, dynamic> file) async {
    try {
      final data = await _apiClient.post('/api/v3/file/source', body: {
        'items': [file['id']],
      });
      
      if (data.isNotEmpty) {
        final previewUrl = data[0]['url'];
        
        if (!mounted) return;
        
        // 根据文件类型打开不同的预览页面
        final extension = file['name'].split('.').last.toLowerCase();
        switch (extension) {
          case 'jpg':
          case 'jpeg':
          case 'png':
          case 'gif':
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImagePreviewPage(
                  url: previewUrl,
                  title: file['name'],
                ),
              ),
            );
            break;
          case 'mp4':
          case 'avi':
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerPage(
                  url: previewUrl,
                  title: file['name'],
                ),
              ),
            );
            break;
          case 'mp3':
          case 'wav':
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AudioPlayerPage(
                  url: previewUrl,
                  title: file['name'],
                ),
              ),
            );
            break;
          case 'pdf':
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerPage(
                  url: previewUrl,
                  title: file['name'],
                ),
              ),
            );
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('暂不支持该类型文件的预览')),
            );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('预览失败: $e')),
      );
    }
  }

  Future<void> _deleteFile(Map<String, dynamic> file) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除 ${file['name']} 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final response = await _apiClient.delete('/api/v3/object', body: {
        'items': file['type'] == 'dir' ? [] : [file['id']],
        'dirs': file['type'] == 'dir' ? [file['id']] : [],
      });

      if (response['code'] == 0) {
        _loadFiles();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('删除成功')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('删除失败: $e')),
      );
    }
  }

  Future<void> _moveFile(Map<String, dynamic> file) async {
    // TODO: 实现文件移动
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('移动功能开发中')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPath == '/') {
          if (!_hasShownExitWarning) {
            _hasShownExitWarning = true;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('再次返回退出应用')),
            );
            Future.delayed(const Duration(seconds: 2), () {
              _hasShownExitWarning = false;
            });
            return false;
          }
          return true;
        }
        
        String parentPath = _currentPath.substring(0, _currentPath.lastIndexOf('/'));
        if (parentPath.isEmpty) parentPath = '/';
        _navigateToPath(parentPath);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: _isSelectionMode
            ? Text('已选择 ${_selectedFiles.length} 个文件')
            : Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < _pathSegments.length; i++)
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    String path = i == 0 ? '/' : 
                                      '/${_pathSegments.sublist(1, i + 1).join('/')}';
                                    _navigateToPath(path);
                                  },
                                  child: Text(
                                    _pathSegments[i],
                                    style: TextStyle(
                                      color: i == _pathSegments.length - 1 ?
                                        Colors.white : Colors.white70,
                                      fontWeight: i == _pathSegments.length - 1 ?
                                        FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (i < _pathSegments.length - 1)
                                  const Icon(Icons.chevron_right, color: Colors.white70),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          actions: _isSelectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    // TODO: 批量下载
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // TODO: 批量分享
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // TODO: 批量删除
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _isSelectionMode = false;
                      _selectedFiles.clear();
                    });
                  },
                ),
              ]
            : [
                IconButton(
                  icon: Icon(_isListView ? Icons.grid_view : Icons.list),
                  onPressed: () => setState(() => _isListView = !_isListView),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: (value) {
                    setState(() {
                      if (_sortBy == value) {
                        _ascending = !_ascending;
                      } else {
                        _sortBy = value;
                        _ascending = true;
                      }
                      _sortFiles();
                    });
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'name',
                      child: Text('按名称排序'),
                    ),
                    const PopupMenuItem(
                      value: 'size',
                      child: Text('按大小排序'),
                    ),
                    const PopupMenuItem(
                      value: 'modified',
                      child: Text('按修改时间排序'),
                    ),
                  ],
                ),
              ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '搜索文件...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onChanged: (value) {
                  // TODO: 实现搜索功能
                },
              ),
            ),
            Expanded(
              child: _isListView ? _buildListView() : _buildGridView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _files.length,
      itemBuilder: (context, index) {
        final file = _files[index];
        return ListTile(
          leading: Icon(_getFileIcon(file['type'], file['name'])),
          title: Text(file['name']),
          subtitle: Text(
            '修改时间: ${DateTime.parse(file['date']).toLocal()}',
          ),
          trailing: _isSelectionMode
            ? Checkbox(
                value: _selectedFiles.contains(file['id']),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedFiles.add(file['id']);
                    } else {
                      _selectedFiles.remove(file['id']);
                    }
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showFileOperations(file),
              ),
          onTap: () {
            if (_isSelectionMode) {
              setState(() {
                if (_selectedFiles.contains(file['id'])) {
                  _selectedFiles.remove(file['id']);
                } else {
                  _selectedFiles.add(file['id']);
                }
              });
            } else {
              if (file['type'] == 'dir') {
                _navigateToPath('$_currentPath${file['name']}/');
              } else {
                _showFileOperations(file);
              }
            }
          },
          onLongPress: () {
            if (!_isSelectionMode) {
              setState(() {
                _isSelectionMode = true;
                _selectedFiles.add(file['id']);
              });
            }
          },
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _files.length,
      itemBuilder: (context, index) {
        final file = _files[index];
        return InkWell(
          onTap: () {
            if (file['type'] == 'dir') {
              _navigateToPath('$_currentPath${file['name']}/');
            } else {
              // TODO: 处理文件点击
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getFileIcon(file['type'], file['name']),
                size: 48,
              ),
              const SizedBox(height: 4),
              Text(
                file['name'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
} 