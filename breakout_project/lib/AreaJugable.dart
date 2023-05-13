import 'package:breakout_project/Ladrillos.dart';
import 'package:breakout_project/LadrillosNormal.dart';
import 'package:breakout_project/LadrillosDuros.dart';
import 'package:breakout_project/LadrillosAumentoVelocidad.dart';
import 'package:breakout_project/LadrillosReduccionVelocidad.dart';
import 'package:breakout_project/LadrillosAumentoTamRaqueta.dart';
import 'package:breakout_project/LadrillosReduccionTamRaqueta.dart';
import 'package:breakout_project/Puntuaciones.dart';
import 'package:flutter/material.dart';
import 'package:breakout_project/Bola.dart';
import 'package:breakout_project/Raqueta.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:breakout_project/FuncionesPublicas.dart';
import 'package:audioplayers/audioplayers.dart';


enum Direccion {
  arriba, abajo, izquierda, derecha,
}

class AreaJugable extends StatefulWidget {
  const AreaJugable({Key? key}) : super(key: key);
  @override
  State<AreaJugable> createState() => _AreaJugableState();
}
//declaracion de la clase. Con with hacemos que se puedan usar los metodos de una clase sin extenderla
class _AreaJugableState extends State<AreaJugable> with SingleTickerProviderStateMixin {

  late double anchoRaqueta;
  late double altoRaqueta;
  double anchoAreaJuego = 0.0; //Variables que van a tener el alto y ancho max
  double altoAreaJuego = 0.0;
  late double diametroBola; //variable para asignar un diametro a la bola
  late double anchoLadrillo;//variables para tam ladrillo
  late double altoLadrillo;
  late double xLadrillo;
  late double yLadrillo;

  late List<Ladrillos> listaLadrillos;
  late bool raquetaModificada;
  bool _listaLadrillosCreada = false;
  late int filasLadrillos;
  late int ladrillosPorFila;
  int num_ladrillos = 0;


  late AnimationController controladorAnimacion;

  late double xBola;
  late double yBola;
  late double incremento;

  late Direccion direccionVertical;
  late Direccion direccionHorizontal;

  late double xRaqueta;

  int puntuacion = 0;
  
  late AudioPlayer ReproductorAudio;
  late AudioCache  ReproductorCache;



  @override
  void initState(){
    diametroBola = 20.0; //EL METODO initState ES PARA HACER ALGO ANTES DEL CONSTRUCTOR DE LA VISTA
                         //Inicializamos aqui el diametro de la bola


    raquetaModificada = false;


    if (!_listaLadrillosCreada) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        final size = MediaQuery
            .of(context)
            .size;
        anchoAreaJuego = size.width;
        altoAreaJuego = size.height;

        xBola = anchoAreaJuego/2;
        yBola = 300;

        inicializarListaLadrillos();

      });
    }




    incremento = 5.0;
    direccionVertical = Direccion.abajo;
    direccionHorizontal = Direccion.derecha;
    darTamanioRaqueta();
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
    AudioPlayer();
    controladorAnimacion.forward(); //con esto se ejecuta la animacion

    ReproductorAudio = AudioPlayer();
    ReproductorCache = AudioCache(fixedPlayer: ReproductorAudio);
    ReproductorCache.play('audios/InicioAreaJugable.mp3');


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

            darTamanioAreaJugable(context, constraints);
            darTamanioRaqueta();


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
                for (int i = 0; i < num_ladrillos; i++)
                  if(listaLadrillos[i].vivo)
                    Positioned(
                      child: listaLadrillos[i],
                      top: listaLadrillos[i].yPosition,
                      left: listaLadrillos[i].xPosition,
                    ),
              ],
            );
          }
      ),
    );
  }

  void darTamanioAreaJugable(BuildContext context, BoxConstraints constraints) {
    anchoAreaJuego = constraints.maxWidth; //se asignan los maximos a las variables
    altoAreaJuego = constraints.maxHeight;
  }

  void inicializarListaLadrillos(){
    listaLadrillos = []; // inicializa la lista de ladrillos aquí

    ladrillosPorFila = 5;
    filasLadrillos = 3;
    num_ladrillos = ladrillosPorFila * filasLadrillos;
    anchoLadrillo = anchoAreaJuego / ladrillosPorFila; //tamanio de los ladrillos
    altoLadrillo = altoAreaJuego / 20.0;

    xLadrillo = 0;
    yLadrillo = 0;


    listaLadrillos.add(elegirLadrilloAzar());



    for (int i = 1; i < num_ladrillos; i++) {
      if (xLadrillo + anchoLadrillo >= (anchoAreaJuego -
          1)) { //aquí he puesto el -1 porque hay inexactitud y no lo interpreta bien
        xLadrillo = 0;
        yLadrillo = yLadrillo + altoLadrillo;
      } else {
        xLadrillo = xLadrillo + anchoLadrillo;
      }

      listaLadrillos.add(elegirLadrilloAzar());
    }

    _listaLadrillosCreada = true;
  }


   Ladrillos elegirLadrilloAzar(){

    Ladrillos ladrillo;

    //Parametrizar nextInt
    switch (Random().nextInt(10)) {
      case 0:
        ladrillo = LadrillosReduccionTamRaqueta
          (anchura: anchoLadrillo, altura: altoLadrillo, xPosition: xLadrillo, yPosition: yLadrillo, vivo: true);
        return ladrillo;

      case 1:
        ladrillo = LadrillosDuros
          (anchura: anchoLadrillo, altura: altoLadrillo, xPosition: xLadrillo, yPosition: yLadrillo, vivo: true);
        return ladrillo;

      case 2:
        ladrillo = LadrillosAumentoVelocidad
          (anchura: anchoLadrillo, altura: altoLadrillo, xPosition: xLadrillo, yPosition: yLadrillo, vivo: true);
        return ladrillo;

      case 3:
        ladrillo = LadrillosAumentoTamRaqueta
          (anchura: anchoLadrillo, altura: altoLadrillo, xPosition: xLadrillo, yPosition: yLadrillo, vivo: true);
        return ladrillo;

      case 4:
        ladrillo = LadrillosReduccionVelocidad
          (anchura: anchoLadrillo, altura: altoLadrillo, xPosition: xLadrillo, yPosition: yLadrillo, vivo: true);
        return ladrillo;
      case 5:
      case 6:
      case 8:
        ladrillo = LadrillosNormal
          (anchura: anchoLadrillo, altura: altoLadrillo, xPosition: xLadrillo, yPosition: yLadrillo, vivo: true);
        return ladrillo;

      default:
        ladrillo = LadrillosNormal
          (anchura: anchoLadrillo, altura: altoLadrillo, xPosition: xLadrillo, yPosition: yLadrillo, vivo: true);
        return ladrillo;

    }

  }

  comprobarLadrilloYAplicar(Ladrillos ladrillo){

    if (ladrillo is LadrillosNormal){
      ladrillo.vivo = false;
      puntuacion = puntuacion + ladrillo.puntos;
    }
    else if (ladrillo is LadrillosDuros)
    {
      if (ladrillo.vidas == 1)
      {
        ladrillo.vidas = 0;
        ladrillo.vivo = false;
        puntuacion = puntuacion + ladrillo.puntos;
      }
      else
      {
        ladrillo.vidas = ladrillo.vidas - 1;
      }
    }
    else if (ladrillo is LadrillosAumentoVelocidad)
    {
      incremento = incremento * ladrillo.multVelocidad;
      ladrillo.vivo = false;
      puntuacion = puntuacion + ladrillo.puntos;
    }
    else if (ladrillo is LadrillosReduccionVelocidad)
    {
      incremento = incremento * ladrillo.multVelocidad;
      ladrillo.vivo = false;
      puntuacion = puntuacion + ladrillo.puntos;
    }
    else if (ladrillo is LadrillosAumentoTamRaqueta)
    {
      raquetaModificada = true;
      anchoRaqueta = anchoRaqueta * ladrillo.multTamRaqueta;
      ladrillo.vivo = false;
      puntuacion = puntuacion + ladrillo.puntos;
    }
    else if (ladrillo is LadrillosReduccionTamRaqueta){
      raquetaModificada = true;
      anchoRaqueta = anchoRaqueta * ladrillo.multTamRaqueta;
      ladrillo.vivo = false;
      puntuacion = puntuacion + ladrillo.puntos;
    }

  }


  void darTamanioRaqueta(){
    if (!raquetaModificada)
    {
      anchoRaqueta = anchoAreaJuego / 5.0; //estas variables serviran para dar un tam proporcional a la raqueta
    }
    //no ponemos nada de anchoRaqueta porque se modificará en los ladrillos cuando impacte
    altoRaqueta = altoAreaJuego / 20.0;
  }

  Future<void> guardarPuntuacion() async
  {
    await escribirPuntuacion(Puntuacion(nombre: "El pepe", puntos: puntuacion));
  }

  void comprobarBordes() {
    double mitadBola = diametroBola / 2.0;
    double bordeDerecho = anchoAreaJuego - diametroBola;
    double bordeInferior = altoAreaJuego - diametroBola - altoRaqueta;

    if (yBola <= 0 && direccionVertical == Direccion.arriba) {
      direccionVertical = Direccion.abajo;
    } else if (yBola <= (altoLadrillo * filasLadrillos) && direccionVertical == Direccion.arriba) {
      for (int i = num_ladrillos - 1; i > -1; i--){
        if(listaLadrillos[i].vivo) {
          if (yBola <= (listaLadrillos[i].yPosition + altoLadrillo)  &&
              xBola >= (listaLadrillos[i].xPosition - mitadBola) &&
              xBola <= (listaLadrillos[i].xPosition + anchoLadrillo - mitadBola)) {
            comprobarLadrilloYAplicar(listaLadrillos[i]);
            direccionVertical = Direccion.abajo;
            setState(() { //mostramos la nueva puntuacion
              puntuacion;
            });
            break;
          }
        }
      }
    }  else if (yBola >= bordeInferior && direccionVertical == Direccion.abajo) {
      if (xBola >= (xRaqueta - mitadBola) &&
          xBola <= (xRaqueta + anchoRaqueta - mitadBola)) {
        direccionVertical = Direccion.arriba;
      } else {
        controladorAnimacion.stop();

        guardarPuntuacion();

        double volumen = 1.0; //ESTO ESTÁ A 1 PORQUE ES LO QUE SE DA POR DEFECTO EN EL .PLAY
        for(int i = 0; i < 5; i++){
          ReproductorAudio.setVolume(volumen-0.2);
        }
        ReproductorAudio.stop();
        
        preguntarRepetirPartida(context); //si la bola no da en la raqueta, preguntar si se quiere seguir jugando
      }
    }



    if (xBola <= 0 && direccionHorizontal == Direccion.izquierda) {
      direccionHorizontal = Direccion.derecha;
    }
    else if ((direccionHorizontal == Direccion.izquierda) &&
              (yBola <= (altoLadrillo * filasLadrillos))){
      for (int i = 0; i < num_ladrillos; i++){
        if (listaLadrillos[i].vivo){
          if ((xBola == listaLadrillos[i].xPosition + anchoLadrillo) &&
              (yBola >= listaLadrillos[i].yPosition - mitadBola) &&
              (yBola <= listaLadrillos[i].yPosition + altoLadrillo - mitadBola)){

            comprobarLadrilloYAplicar(listaLadrillos[i]);
            direccionHorizontal = Direccion.derecha;
            setState(() { //mostramos la nueva puntuacion
              puntuacion;
            });
            break;
          }
        }
      }
    }
    else if (xBola >= bordeDerecho && direccionHorizontal == Direccion.derecha) {
      direccionHorizontal = Direccion.izquierda;
    }
    else if ((direccionHorizontal == Direccion.derecha) &&
        (yBola <= (altoLadrillo * filasLadrillos))){
      for (int i = 0; i < num_ladrillos; i++){
        if (listaLadrillos[i].vivo){
          if ((xBola == listaLadrillos[i].xPosition) &&
              (yBola >= listaLadrillos[i].yPosition - mitadBola) &&
              (yBola <= listaLadrillos[i].yPosition + altoLadrillo - mitadBola)){

            comprobarLadrilloYAplicar(listaLadrillos[i]);
            direccionHorizontal = Direccion.izquierda;
            setState(() { //mostramos la nueva puntuacion
              puntuacion;
            });
            break;
          }
        }
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
                ReproductorAudio.resume();
                xBola = 200.0;
                yBola = 200.0;
                puntuacion = 0;
                incremento = 5;
                raquetaModificada = false;
                xBola = anchoAreaJuego/2;
                yBola = 300;
                darTamanioRaqueta();
                //Esto es para resetear los ladrillos en la interfaz
                for (Ladrillos ladrillo in listaLadrillos){
                  ladrillo.vivo = true;
                  if (ladrillo is LadrillosDuros){
                    ladrillo.vidas = 2;
                  }
                }
              });
              Navigator.of(context).pop();
              controladorAnimacion.repeat();
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


}