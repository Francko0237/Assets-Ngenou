import 'package:flutter/material.dart';

/// Peintre personnalisé pour l'axe gradué horizontal des nombres relatifs
class DroiteGradueePainter extends CustomPainter {
  final int minVal;
  final int maxVal;
  final int? pointValA;
  final int? pointValB;
  final int? deplacementDepart;
  final int? deplacementArrivee;
  final bool isDark;

  DroiteGradueePainter({
    this.minVal = -10,
    this.maxVal = 10,
    this.pointValA,
    this.pointValB,
    this.deplacementDepart,
    this.deplacementArrivee,
    this.isDark = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double yCenter = size.height / 2;
    final double totalUnits = (maxVal - minVal).toDouble();
    final double unitWidth = size.width / totalUnits;

    double xFromVal(num val) => (val - minVal) * unitWidth;

    final axisPaint = Paint()
      ..color = isDark ? Colors.white60 : Colors.black87
      ..strokeWidth = 2.0;

    final originPaint = Paint()
      ..color = isDark ? Colors.white : Colors.black
      ..strokeWidth = 3.5;

    final tickPaint = Paint()
      ..color = isDark ? Colors.white30 : Colors.black26
      ..strokeWidth = 1.2;

    // Ligne principale de l'axe
    canvas.drawLine(Offset(0, yCenter), Offset(size.width, yCenter), axisPaint);

    // Flèche au bout à droite
    final arrowPath = Path()
      ..moveTo(size.width, yCenter)
      ..lineTo(size.width - 10, yCenter - 5)
      ..lineTo(size.width - 10, yCenter + 5)
      ..close();
    canvas.drawPath(arrowPath, axisPaint..style = PaintingStyle.fill);

    // Graduations
    for (int v = minVal; v <= maxVal; v++) {
      final double x = xFromVal(v);
      final bool isOrigin = v == 0;
      final double tickHeight = isOrigin ? 12 : 6;

      canvas.drawLine(
        Offset(x, yCenter - tickHeight),
        Offset(x, yCenter + tickHeight),
        isOrigin ? originPaint : tickPaint,
      );

      // Chiffres des graduations principales
      if (v % 2 == 0 || isOrigin) {
        final textSpan = TextSpan(
          text: isOrigin ? '0' : (v > 0 ? '+$v' : '$v'),
          style: TextStyle(
            color: isOrigin
                ? (isDark ? Colors.white : Colors.black)
                : (v > 0
                    ? const Color(0xFF2ECC71)
                    : const Color(0xFFE74C3C)),
            fontWeight: isOrigin ? FontWeight.bold : FontWeight.w500,
            fontSize: isOrigin ? 12.5 : 10.5,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(x - (textPainter.width / 2), yCenter + 14),
        );
      }
    }

    // Vecteur de déplacement (opération animée)
    if (deplacementDepart != null && deplacementArrivee != null) {
      final startX = xFromVal(deplacementDepart!);
      final endX = xFromVal(deplacementArrivee!);
      final bool avanceVersDroite = endX >= startX;
      final arrowColor =
          avanceVersDroite ? const Color(0xFF2ECC71) : const Color(0xFFE74C3C);

      final vectorPaint = Paint()
        ..color = arrowColor
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke;

      // Arc courbé au-dessus
      final double arcHeight = yCenter - 34;
      final path = Path()
        ..moveTo(startX, yCenter - 14)
        ..quadraticBezierTo(
          (startX + endX) / 2,
          arcHeight,
          endX,
          yCenter - 14,
        );
      canvas.drawPath(path, vectorPaint);

      // Flèche au point d'arrivée
      final tipX = endX;
      final tipY = yCenter - 14;
      final tipPath = Path()
        ..moveTo(tipX, tipY)
        ..lineTo(
          avanceVersDroite ? tipX - 7 : tipX + 7,
          tipY - 5,
        )
        ..lineTo(
          avanceVersDroite ? tipX - 7 : tipX + 7,
          tipY + 5,
        )
        ..close();
      canvas.drawPath(tipPath, Paint()..color = arrowColor);
    }

    // Point A
    if (pointValA != null) {
      _drawMarker(
        canvas: canvas,
        x: xFromVal(pointValA!),
        y: yCenter,
        label: 'A ($pointValA)',
        color: const Color(0xFF3498DB),
      );
    }

    // Point B
    if (pointValB != null) {
      _drawMarker(
        canvas: canvas,
        x: xFromVal(pointValB!),
        y: yCenter,
        label: 'B ($pointValB)',
        color: const Color(0xFFE67E22),
      );
    }
  }

  void _drawMarker({
    required Canvas canvas,
    required double x,
    required double y,
    required String label,
    required Color color,
  }) {
    final dotPaint = Paint()..color = color;
    canvas.drawCircle(Offset(x, y), 6, dotPaint);
    canvas.drawCircle(
      Offset(x, y),
      8,
      Paint()
        ..color = color.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final textSpan = TextSpan(
      text: label,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(x - (textPainter.width / 2), y - 28),
    );
  }

  @override
  bool shouldRepaint(covariant DroiteGradueePainter oldDelegate) {
    return oldDelegate.pointValA != pointValA ||
        oldDelegate.pointValB != pointValB ||
        oldDelegate.deplacementDepart != deplacementDepart ||
        oldDelegate.deplacementArrivee != deplacementArrivee ||
        oldDelegate.isDark != isDark;
  }
}
