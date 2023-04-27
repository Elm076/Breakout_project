import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:breakout_project/Ladrillos.dart';

class LadrillosProvider extends ChangeNotifier {
  List<Ladrillos> _ladrillos = [];

  LadrillosProvider() {
    // Cargar la lista de ladrillos en el constructor
    // En este ejemplo, se crean 10 ladrillos en posiciones aleatorias
    for (int i = 0; i < 10; i++) {
      _ladrillos.add(Ladrillos(xPosition: 0, yPosition: 0, vivo: true, ));
    }
  }

  List<Ladrillos> get ladrillos => _ladrillos;
}