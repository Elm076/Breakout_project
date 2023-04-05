import 'package:flutter/material.dart';

class Bola extends StatelessWidget{
  final double diametro;
  Bola({Key? key, this.diametro = 20});
  
  @override
  Widget build(BuildContext context){
    return Container(
      width: diametro,
      height: diametro,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        shape: BoxShape.circle,
      ),
    );
  }
}