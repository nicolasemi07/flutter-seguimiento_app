part of 'custom_markers.dart';

class MarkerInicioPainter extends CustomPainter {

  final int minutos;

  MarkerInicioPainter(this.minutos);

  @override
  void paint(Canvas canvas, Size size) {
    final double circuloNegroRadio = 20;
    final double circuloBlancoRadio = 7;

    Paint paint = new Paint()
      ..color = Colors.black; // Es lo mismo que: paint.color = Colors.black;

    // Dibujar círculo negro:
    canvas.drawCircle(
        Offset(circuloNegroRadio, size.height - circuloNegroRadio),
        circuloNegroRadio,
        paint);

    // Círculo blanco:
    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(circuloNegroRadio, size.height - circuloNegroRadio),
        circuloBlancoRadio,
        paint);

    // Sombra:
    final Path path = new Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // Caja blanca:
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(cajaBlanca, paint);

    // Caja negra:
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    // Numero de los minutos:
    TextSpan textSpan = new TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      text: '$minutos'
    );

    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    // '..layout()' es igual a poner 'textPainter.layout()' en una linea de abajo
    textPainter.paint(canvas, Offset(40, 35));

    // Texto de "minutos":
    textSpan = new TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: 'min'
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    );
    
    textPainter.layout(
      minWidth: 70,
      maxWidth: 70
    );

    textPainter.paint(canvas, Offset(40, 67));

    // Texto de "Mi ubicación":
    textSpan = new TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
      text: 'Mi ubicación'
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(maxWidth: size.width - 130);

    // '..layout()' es igual a poner 'textPainter.layout()' en una linea de abajo
    textPainter.paint(canvas, Offset(155, 48));
  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}
