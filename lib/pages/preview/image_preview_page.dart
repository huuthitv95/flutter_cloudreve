import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewPage extends StatelessWidget {
  final String url;
  final String title;

  const ImagePreviewPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PhotoView(
        imageProvider: NetworkImage(url),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
} 