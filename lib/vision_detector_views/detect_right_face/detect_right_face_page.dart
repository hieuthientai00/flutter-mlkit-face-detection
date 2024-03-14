import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class DetectRightFacePage extends StatelessWidget {
  static const String routeName = '/detectRightFace';

  const DetectRightFacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DetectRightFace'),
        ),
        body: BlocProvider(
          create: (BuildContext context) =>
              DetectRightFaceBloc(const UnDetectRightFaceState())
                ..add(LoadDetectRightFaceEvent()),
          child: const DetectRightFaceScreen(),
        ));
  }
}
