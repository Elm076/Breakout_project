class Puntuacion {
  String nombre;
  int puntos;

  Puntuacion({required this.nombre , required this.puntos});

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'puntos': puntos,
    };
  }

  factory Puntuacion.fromMap(Map<String, dynamic> map) {
    return Puntuacion(nombre: map['nombre'], puntos: map['puntos']);
  }
}

