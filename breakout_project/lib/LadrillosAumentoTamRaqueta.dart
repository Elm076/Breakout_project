import 'package:breakout_project/Ladrillos.dart';
import 'package:flutter/material.dart';

class LadrillosAumentoTamRaqueta extends Ladrillos {
  final double multTamRaqueta = 1.3; //multiplicador de aumento del tamaño de la raqueta
  @override
  final int puntos = 1;

  LadrillosAumentoTamRaqueta({Key? key, required double anchura, required double altura, required double xPosition, required double yPosition, required bool vivo})
      : super(key: key, anchura: anchura, altura: altura, xPosition: xPosition, yPosition: yPosition, vivo: vivo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: anchura,
      height: altura,
      decoration: BoxDecoration(
          color: Colors.purple[400],
          border: Border.all(color: Colors.black, width: 3)),
    );
  }
}