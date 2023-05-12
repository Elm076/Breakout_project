import 'package:breakout_project/Ladrillos.dart';
import 'package:flutter/material.dart';

class LadrillosAumentoVelocidad extends Ladrillos {
  final double multVelocidad = 1.3; //aumento de la velocidad de la bola
  @override
  final int puntos = 3;

  LadrillosAumentoVelocidad({Key? key, required double anchura, required double altura, required double xPosition, required double yPosition, required bool vivo})
      : super(key: key, anchura: anchura, altura: altura, xPosition: xPosition, yPosition: yPosition, vivo: vivo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: anchura,
      height: altura,
      decoration: BoxDecoration(
          color: Colors.red[300],
          border: Border.all(color: Colors.black, width: 3)),
    );
  }
}