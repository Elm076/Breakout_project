import 'package:breakout_project/Ladrillos.dart';
import 'package:flutter/material.dart';

class LadrillosNormal extends Ladrillos {
  @override
  final int puntos = 2;

  LadrillosNormal({Key? key, required double anchura, required double altura, required double xPosition, required double yPosition, required bool vivo})
      : super(key: key, anchura: anchura, altura: altura, xPosition: xPosition, yPosition: yPosition, vivo: vivo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: anchura,
      height: altura,
      decoration: BoxDecoration(
          color: Colors.grey[400],
          border: Border.all(color: Colors.black, width: 3)),
    );
  }
}