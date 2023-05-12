import 'package:breakout_project/Puntuaciones.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:breakout_project/PantallaAjustes.dart';

int minimo(int num1, int num2){
    if(num1 > num2)
    {
      return num2;
    }
    else
    {
      return num1;
    }

}


Future<void> escribirPuntuacion(Puntuacion score) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final File file = File('$path/Puntuaciones.txt');

  final Puntuaciones = await leerPuntuaciones();
  Puntuaciones.add(score);
  Puntuaciones.sort((a, b) => b.puntos.compareTo(a.puntos));
  Puntuaciones.length = minimo(Puntuaciones.length, 30); //30 PORQUE NOS PIDEN 30

  final jsonList = Puntuaciones.map((score) => score.toMap()).toList();
  final jsonString = jsonEncode(jsonList);

  await file.writeAsString(jsonString);
}

Future<List<Puntuacion>> leerPuntuaciones() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final File file = File('$path/Puntuaciones.txt');

  if (await file.exists()) {
    final contents = await file.readAsString();
    final jsonList = jsonDecode(contents);
    return jsonList.map((json) => Puntuacion.fromMap(json)).toList();
  } else {
    await file.create();
    await file.writeAsString('[]');
    return Future.value([]);
  }
}

