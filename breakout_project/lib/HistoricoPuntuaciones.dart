import 'package:flutter/material.dart';
import 'package:breakout_project/Puntuaciones.dart';
import 'package:breakout_project/FuncionesPublicas.dart';

class HistoricoPuntuaciones extends StatelessWidget{

  List<Puntuacion> MejoresPuntuaciones = [];

  Future<void> ObtenerPuntuaciones() async
  {
    MejoresPuntuaciones = await leerPuntuaciones();
  }


/* Mostrar las 10 mejores puntuaciones en la pantalla de juego
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puntuaciones'),
      ),
      body: ListView.builder(
        itemCount: MejoresPuntuaciones.length,
        itemBuilder: (context, index) {
          final puntuacion = MejoresPuntuaciones[index];
          return ListTile(
            title: Text(puntuacion.nombre),
            subtitle: Text('Puntuación: ${puntuacion.puntos}'),
          );
        },
      ),
    );
  }
}

 */

  List<Puntuacion> puntuaciones = [(Puntuacion(nombre: "Joaquín Peruano", puntos: 28)),(Puntuacion(nombre: "El Nano", puntos: 25)),(Puntuacion(nombre: "Majano", puntos: 23)),(Puntuacion(nombre: "Dominguillo xdxd", puntos: 12)),(Puntuacion(nombre: "Jordi Wild", puntos: 7))];
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Puntuaciones'),
    ),
    body: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(puntuaciones[index].nombre),
          subtitle: Text('Puntuación: ${puntuaciones[index].puntos}'),
        );
      },
    ),
  );
}
}

/*@override
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
*/
