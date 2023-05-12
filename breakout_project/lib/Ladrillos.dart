import 'package:flutter/material.dart';

abstract class Ladrillos extends StatelessWidget{
  double anchura;
  double altura;
  double xPosition;
  double yPosition;
  bool vivo;
  late int  puntos;

  Ladrillos({Key? key, required this.anchura, required this.altura, required this.xPosition, required this.yPosition, required this.vivo});

}
