import 'package:breakout_project/Ladrillos.dart';
import 'package:flutter/material.dart';

class LadrillosDuros extends Ladrillos {
  int vidas = 2; //estos hay que golpearlos dos veces
  @override
  final int puntos = 5;

  LadrillosDuros({Key? key, required double anchura, required double altura, required double xPosition, required double yPosition, required bool vivo})
      : super(key: key, anchura: anchura, altura: altura, xPosition: xPosition, yPosition: yPosition, vivo: vivo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: anchura,
      height: altura,
      decoration: BoxDecoration(
          color: Colors.pink[800],
          border: Border.all(color: Colors.black, width: 3)),
    );
  }
}