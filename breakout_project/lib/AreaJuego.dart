import 'package:breakout_project/Ladrillos.dart';
import 'package:flutter/material.dart';
import 'package:breakout_project/Bola.dart';
import 'package:breakout_project/Raqueta.dart';

enum Direccion {
  arriba, abajo, izquierda, derecha,
}

class AreaJuego extends StatefulWidget {
  const AreaJuego({Key? key}) : super(key: key);
  @override
  State<AreaJuego> createState() => _AreaJuegoState();
}
//declaracion de la clase. Con with hacemos que se puedan usar los metodos de una clase sin extenderla
class _AreaJuegoState extends State<AreaJuego> with SingleTickerProviderStateMixin {
  late double anchoRaqueta;
  late double altoRaqueta;
  late double anchoAreaJuego; //Variables que van a tener el alto y ancho max
  late double altoAreaJuego;
  late double diametroBola; //variable para asignar un diametro a la bola
  late double anchoLadrillo;//variables para tam ladrillo
  late double altoLadrillo;
  late double xLadrillo;
  late double yLadrillo;

  List<Ladrillos> listaLadrillos = [];

  late AnimationController controladorAnimacion;

  late double xBola;
  late double yBola;
  late double incremento;

  late Direccion direccionVertical;
  late Direccion direccionHorizontal;

  late double xRaqueta;

  int puntuacion = 0;

  @override
  void initState(){
    diametroBola = 20.0; //EL METODO initState ES PARA HACER ALGO ANTES DEL CONSTRUCTOR DE LA VISTA
                         //Inicializamos aqui el diametro de la bola
    xBola = 0.0;
    yBola = 20.0;
    xLadrillo = 0.0;
    yLadrillo = 0.0;
    incremento = 5.0;
    direccionVertical = Direccion.abajo;
    direccionHorizontal = Direccion.derecha;
    xRaqueta = 0.0;
    controladorAnimacion = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this, //para arreglar un error de compliacion que salia aqui ver la declaracion de la clase
    );
    controladorAnimacion.addListener(() {
      setState(() {
        (direccionHorizontal == Direccion.derecha) ? xBola += incremento: xBola -=
            incremento;
        (direccionVertical == Direccion.abajo) ? yBola += incremento: yBola -=
            incremento;
      });
      comprobarBordes();
    });
    controladorAnimacion.forward(); //con esto se ejecuta la animacion
    super.initState();
  }

  @override
  void dispose() {
    controladorAnimacion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900], // Establece el color de fondo a rojo oscuro
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            anchoAreaJuego = constraints.maxWidth; //se asignan los maximos a las variables
            altoAreaJuego = constraints.maxHeight;
            anchoRaqueta = anchoAreaJuego / 5.0; //estas variables serviran para dar un tam proporcional a la raqueta
            altoRaqueta = altoAreaJuego / 20.0;
            anchoLadrillo = anchoAreaJuego / 6.0; //tamanio de los ladrillos
            altoLadrillo = altoAreaJuego / 40.0;

            inicializarListaLadrillos(listaLadrillos, 19, anchoAreaJuego);

            return Stack( //Se devuelven la bola y Raqueta
              children: <Widget>[
                Positioned(
                  child: Bola(diametro: diametroBola),
                  top: yBola,
                  left: xBola,
                ),
                Positioned(
                  bottom: 0,
                  left: xRaqueta,
                  child: GestureDetector(
                      onHorizontalDragUpdate: (DragUpdateDetails detalleDeslizar) {
                        moverRaqueta(detalleDeslizar);
                      },
                      child: Raqueta(anchura: anchoRaqueta, altura: altoRaqueta,)
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Text(
                    'Puntuación: $puntuacion',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60,
                    ),
                  ),
                ),
                for (Ladrillos ladrillo in listaLadrillos)
                  Positioned(
                    child: ladrillo,
                    top: ladrillo.yPosition,
                    left: ladrillo.xPosition,
                  ),
              ],
            );
          }
      ),
    );
  }



  void comprobarBordes() {
    double mitadBola = diametroBola / 2.0;
    double bordeDerecho = anchoAreaJuego - diametroBola;
    double bordeInferior = altoAreaJuego - diametroBola - altoRaqueta;
    if (xBola <= 0 && direccionHorizontal == Direccion.izquierda) {
      direccionHorizontal = Direccion.derecha;
    } else if (xBola >= bordeDerecho && direccionHorizontal == Direccion.derecha) {
      direccionHorizontal = Direccion.izquierda;
    }

    if (yBola <= 0 && direccionVertical == Direccion.arriba) {
      direccionVertical = Direccion.abajo;
    } else if (yBola <= altoLadrillo && direccionVertical == Direccion.arriba) {
      if (xBola >= (xLadrillo - mitadBola) &&
          xBola <= (xLadrillo + anchoLadrillo - mitadBola)) {
        direccionVertical = Direccion.abajo;
        setState(() { //incrementamos la puntuacion
          puntuacion++;
        });
      }
    }  else if (yBola >= bordeInferior && direccionVertical == Direccion.abajo) {
        if (xBola >= (xRaqueta - mitadBola) &&
            xBola <= (xRaqueta + anchoRaqueta - mitadBola)) {
          direccionVertical = Direccion.arriba;
        } else {
          controladorAnimacion.stop();
          preguntarRepetirPartida(context); //si la bola no da en la raqueta, preguntar si se quiere seguir jugando
        }
      }
  }

  void moverRaqueta(DragUpdateDetails detalleDeslizar) {
    setState(() {
      xRaqueta += detalleDeslizar.delta.dx;
      if (xRaqueta <= 0) {
        xRaqueta = 0.0;
      } else if (xRaqueta >= anchoAreaJuego - anchoRaqueta) {
        xRaqueta = anchoAreaJuego - anchoRaqueta;
      }
    });
  }

  void preguntarRepetirPartida(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
          title: const Text(
          'Illo eres mu malo',
          textAlign: TextAlign.center,
      ),
    content: Text(
    'Puntuación: $puntuacion\n¿Quieres jugar otra vez?',
    textAlign: TextAlign.center,
    ),
        actions: <Widget>[
          TextButton(
            child: const Text('Si'),
            onPressed: () {
              setState(() {
                xBola = 0.0;
                yBola = 0.0;
                puntuacion = 0;
              });
              Navigator.of(context).pop();
              controladorAnimacion?.repeat();
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
              dispose();
            },
          ),
        ],
      );
        }
    );
  }

  void inicializarListaLadrillos(List<Ladrillos> lista, int numLadrillos, double anchoAreaJuego){
    double x = 0;
    double y = 0;
    for(int i = 0; i<numLadrillos; i++){

      lista.add(Ladrillos(anchura: anchoLadrillo, altura: altoLadrillo, xPosition: x, yPosition: y));
      if (x + lista[i].anchura >= (anchoAreaJuego - 1)) { //aquí he puesto el -1 porque hay inexactitud y no lo interpreta bien
        x = 0;
        y = y + lista[i].altura;
      } else {
        x = x + lista[i].anchura;
      }

    }
  }

}