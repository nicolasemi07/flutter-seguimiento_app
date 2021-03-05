import 'package:flutter/material.dart';
import 'package:mapa_app/custom_markers/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          // color: Colors.red,
          // child: CustomPaint(painter: MarkerInicioPainter(28)),
          child: CustomPaint(
              painter: MarkerDestinoPainter(
                  'Reprehenderit sint est minim dolor laboris deserunt elit mollit cillum nostrud velit Lorem.',
                  28674)),
        ),
      ),
    );
  }
}
