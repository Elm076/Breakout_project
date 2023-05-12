import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:breakout_project/PaginaPrincipal.dart';

class BreakoutApp extends StatelessWidget {
  const BreakoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breakout',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const PaginaPrincipal(),
    );
  }
}