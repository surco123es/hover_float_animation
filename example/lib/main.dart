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
            positionHorizontal: horizontal,
            positionVertical: vertical,
            child: Container(
              alignment: Alignment.center,
              color: Colors.amber,
              width: 150,
              height: 250,
              child: const Text('Hover con animacion'),
            ),
            transition: TransitionType.FadeInLeftBig,
            animationDuration: const Duration(milliseconds: 300),
            sizeFloat: const Size(180, 270),
            hoverChild: Container(
              alignment: Alignment.center,
              color: Colors.amberAccent,
              child: const Text('Contenido del hover'),
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
