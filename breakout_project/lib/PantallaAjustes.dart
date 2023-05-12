import 'package:breakout_project/Juego.dart';
import 'package:flutter/material.dart';


//ESTA CLASE AL FINAL NO HEMOS SABIDO IMPLEMENTARLA DEBIDO A LOS PARÁMETROS, ASÍ QUE NO SE VA A UTILIZAR

class PantallaAjustes extends StatefulWidget {
  const PantallaAjustes({Key? key}) : super(key: key);

  @override
  _PantallaAjustesState createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  String _dificultadSeleccionada = "";
  String _nombreJugador = "";

  String get nombreJugador => _nombreJugador;
  String get dificultadSeleccionada => _dificultadSeleccionada;


  void _seleccionarDificultad(String dificultad) {
    setState(() {
      _dificultadSeleccionada = dificultad;
    });
  }

  void _cambiarNombreJugador(String value) {
    setState(() {
      _nombreJugador = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dificultad"),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _seleccionarDificultad("Fácil"),
                  child: const Text("Fácil"),
                  style: ElevatedButton.styleFrom(
                    primary: _dificultadSeleccionada == "Fácil"
                        ? Colors.green[100]
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _seleccionarDificultad("Medio"),
                  child: const Text("Medio"),
                  style: ElevatedButton.styleFrom(
                    primary: _dificultadSeleccionada == "Medio"
                        ? Colors.green[100]
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _seleccionarDificultad("Difícil"),
                  child: const Text("Difícil"),
                  style: ElevatedButton.styleFrom(
                    primary: _dificultadSeleccionada == "Difícil"
                        ? Colors.green[100]
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Ladrillos Especiales"),
            const SizedBox(height: 16),
            const Text("Nombre del Jugador"),
            const SizedBox(height: 8),
            TextField(
              onChanged: _cambiarNombreJugador,
              decoration: const InputDecoration(
                hintText: "Introduce Nombre",
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sí"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("No"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Juego(
                      ),
                    ),
                  );
                },
                child: const Text("JUGAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}