import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  static final String route = '/image-view';
  const ImageView({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.file(File(path));
  }
}
