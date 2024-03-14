import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class DetectLeftFacePage extends StatelessWidget {
  static const String routeName = '/detectLeftFace';

  const DetectLeftFacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (BuildContext context) =>
          DetectLeftFaceBloc(const UnDetectLeftFaceState())
            ..add(LoadDetectLeftFaceEvent()),
      child: const DetectLeftFaceScreen(),
    ));
  }
}
