import 'package:breakout_project/PantallaAjustes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:breakout_project/Juego.dart';
import 'package:breakout_project/HistoricoPuntuaciones.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);
  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breakout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Juego()),
                );
              },
              child: const Text("Jugar"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoricoPuntuaciones()), //AQUÍ NO SE CREA BIEN EL .TXT AUNQUE AL MENOS NO SALTA EXCEPCIÓN CATASTRÓFICA
                );
              },
              child: const Text("Ver Puntuaciones"),
            ),
          ],
        ),
      ),
    );
  }
}