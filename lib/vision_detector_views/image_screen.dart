import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../remote/post_image.dart';

class ImageView extends StatelessWidget {
  static final String route = '/image-view';
  const ImageView({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Image.file(File(path)),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () async {
                  ApiService.postImage(File(path)).then((isSuccessfully) {
                    print('Sended file');
                    if (isSuccessfully) {
                      print('Successfully');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Upload successfully')),
                      );
                    }
                    if (context.canPop()) {
                      context.pop();
                    }
                  });
                },
                child: Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
