// feature/parent pages/welcome back/ui/widgets/circuit_painter.dart
import 'package:flutter/material.dart';

class CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBDD4EA)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFFBDD4EA)
      ..style = PaintingStyle.fill;

    final p1 = Path()
      ..moveTo(0, size.height * 0.25)
      ..lineTo(size.width * 0.18, size.height * 0.25)
      ..lineTo(size.width * 0.18, size.height * 0.75)
      ..lineTo(size.width * 0.33, size.height * 0.75)
      ..lineTo(size.width * 0.33, size.height * 0.42)
      ..lineTo(size.width * 0.48, size.height * 0.42)
      ..lineTo(size.width * 0.48, size.height * 0.9);

    final p2 = Path()
      ..moveTo(size.width * 0.08, size.height * 0.95)
      ..lineTo(size.width * 0.08, size.height * 0.55)
      ..lineTo(size.width * 0.25, size.height * 0.55)
      ..lineTo(size.width * 0.25, size.height * 0.12)
      ..lineTo(size.width * 0.58, size.height * 0.12)
      ..lineTo(size.width * 0.58, size.height * 0.58)
      ..lineTo(size.width * 0.85, size.height * 0.58);

    final p3 = Path()
      ..moveTo(size.width * 0.62, size.height * 0.95)
      ..lineTo(size.width * 0.62, size.height * 0.36)
      ..lineTo(size.width * 0.77, size.height * 0.36)
      ..lineTo(size.width * 0.77, size.height * 0.16)
      ..lineTo(size.width, size.height * 0.16);

    canvas.drawPath(p1, paint);
    canvas.drawPath(p2, paint);
    canvas.drawPath(p3, paint);

    final dots = [
      Offset(size.width * 0.18, size.height * 0.25),
      Offset(size.width * 0.33, size.height * 0.75),
      Offset(size.width * 0.48, size.height * 0.9),
      Offset(size.width * 0.25, size.height * 0.55),
      Offset(size.width * 0.58, size.height * 0.58),
      Offset(size.width * 0.77, size.height * 0.16),
      Offset(size.width * 0.85, size.height * 0.58),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
