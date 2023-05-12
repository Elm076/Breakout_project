import 'package:flutter/material.dart';
import 'package:breakout_project/AreaJugable.dart';
import 'package:provider/provider.dart';

class Juego extends StatelessWidget{
  const Juego ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titulo = 'Breakout';
    return MaterialApp(
      title: titulo,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
        ),
        body: const SafeArea(
            child: AreaJugable(),
          ),
        ),
      );
  }
}