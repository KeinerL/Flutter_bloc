import 'package:flutter/material.dart';
import 'package:flutter_application_1/block/bloc.dart';
import 'package:flutter_application_1/vista/home.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => SubjectBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Quitar banner debug
      home: Home(),
    );
  }
}

