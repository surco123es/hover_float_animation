import 'package:flutter/material.dart';
import 'package:hover_float_animation/hover_float_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Widget setPosition({
    required HoverPositionVertical vertical,
    required HoverPositionHorizontal horizontal,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) => HoverFloatController.start(
          hover: HoverAnimationData(
            //la posicion puede ser derecha, Izquierda, Centro
            positionHorizontal: horizontal,
            //la posicion puede ser arriba, abajo , centro
            positionVertical: vertical,
            //La transion que tomara al entrar al hover
            transition: TransitionType.FadeInLeftBig,
            //La duracion de la transicion
            animationDuration: const Duration(milliseconds: 300),
            //el tamaño del widget de flotara
            sizeFloat: const Size(180, 270),
            //Si se aplica la animacion por defecto esta el true
            animation: true,
            //si se cierra el hover al salir del widget flotante
            autoClose: true,
            //Para acomodar el widget flotante
            relativePosition: true,
            //el token de manipulacion del hover flotante por defecto es 0
            token: 0,
            //es la function que de dispara al entrar al widget flotante
            onEnterMouse: (token) {
              print('entrate al hover');
            },
            //es la funcion que se dispara al salir del hover
            onExitMouse: (token) {
              print('Saliste del hover');
            },
            //es la funcion que se dispara al dibujar el widget padre
            onStart: (token) {
              print('Se creo el widget y este es el token $token');
            },
            //el widget flotante
            hoverChild: Container(
              alignment: Alignment.center,
              color: Colors.amberAccent,
              child: const Text('Contenido del hover'),
            ),
            //El padre del hover
            child: Container(
              alignment: Alignment.center,
              color: Colors.amber,
              width: 150,
              height: 250,
              child: const Text('Hover con animacion'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(10),
            color: Colors.amber,
            child: const Text(
              'Posición Center',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          setPosition(
            horizontal: HoverPositionHorizontal.center,
            vertical: HoverPositionVertical.center,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(10),
            color: Colors.amber,
            child: const Text(
              'Posición Left',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          setPosition(
            horizontal: HoverPositionHorizontal.left,
            vertical: HoverPositionVertical.center,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(10),
            color: Colors.amber,
            child: const Text(
              'Posición Rigth',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          setPosition(
            horizontal: HoverPositionHorizontal.right,
            vertical: HoverPositionVertical.center,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(10),
            color: Colors.amber,
            child: const Text(
              'Posición bottom',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          setPosition(
            horizontal: HoverPositionHorizontal.center,
            vertical: HoverPositionVertical.bottom,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(10),
            color: Colors.amber,
            child: const Text(
              'Posición top',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          setPosition(
            horizontal: HoverPositionHorizontal.center,
            vertical: HoverPositionVertical.top,
          ),
        ],
      ),
    );
  }
}
