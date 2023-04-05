import 'package:flutter/material.dart';
import 'package:breakout_project/AreaJuego.dart';

class BreakoutApp extends StatelessWidget{
  const BreakoutApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titulo = 'Breakout';

    return MaterialApp(
      title: titulo,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
        ),
        body: const SafeArea(
          child: AreaJuego(),
        ),
      ),
    );
  }
}