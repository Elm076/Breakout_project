import 'package:flutter/material.dart';

class Ladrillos extends StatelessWidget{
  double anchura;
  double altura;
  double xPosition;
  double yPosition;

  Ladrillos({Key? key, this.anchura = 100, this.altura = 10, required this.xPosition, required this.yPosition});

  @override
  Widget build(BuildContext context){
    return Container(
      width: anchura,
      height: altura,
      decoration: BoxDecoration(
        color: Colors.amber[900],
        border: Border.all(color: Colors.black,
                            width: 3)
      ),
    );
  }
}