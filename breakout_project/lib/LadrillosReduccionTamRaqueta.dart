import 'package:breakout_project/Ladrillos.dart';
import 'package:flutter/material.dart';

class LadrillosReduccionTamRaqueta extends Ladrillos {
  final double multTamRaqueta = 0.7; //multiplicador de disminución del tamaño de la raqueta
  @override
  final int puntos = 3;

  LadrillosReduccionTamRaqueta({Key? key, required double anchura, required double altura, required double xPosition, required double yPosition, required bool vivo})
      : super(key: key, anchura: anchura, altura: altura, xPosition: xPosition, yPosition: yPosition, vivo: vivo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: anchura,
      height: altura,
      decoration: BoxDecoration(
          color: Colors.orange[300],
          border: Border.all(color: Colors.black, width: 3)),
    );
  }
}