import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Peintre personnalisé pour afficher un disque de fraction découpé en parts
class FractionPiePainter extends CustomPainter {
  final int numerateur;
  final int denominateur;
  final Color fillColor;
  final Color emptyColor;
  final Color borderColor;

  FractionPiePainter({
    required this.numerateur,
    required this.denominateur,
    required this.fillColor,
    required this.emptyColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (denominateur <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;
    final sweepAngle = (2 * math.pi) / denominateur;

    final emptyPaint = Paint()
      ..color = emptyColor
      ..style = PaintingStyle.fill;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final sliceBorderPaint = Paint()
      ..color = borderColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Dessin de chaque part
    for (int i = 0; i < denominateur; i++) {
      final startAngle = -math.pi / 2 + (i * sweepAngle);
      final isFilled = i < numerateur;
      final currentPaint = isFilled ? fillPaint : emptyPaint;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        currentPaint,
      );

      // Trait de séparation
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        sliceBorderPaint,
      );
    }

    // Cercle extérieur
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant FractionPiePainter oldDelegate) {
    return oldDelegate.numerateur != numerateur ||
        oldDelegate.denominateur != denominateur ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.emptyColor != emptyColor ||
        oldDelegate.borderColor != borderColor;
  }
}

/// Peintre personnalisé pour afficher une réglette rectangulaire de fraction
class FractionBarPainter extends CustomPainter {
  final int numerateur;
  final int denominateur;
  final Color fillColor;
  final Color emptyColor;
  final Color borderColor;

  FractionBarPainter({
    required this.numerateur,
    required this.denominateur,
    required this.fillColor,
    required this.emptyColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (denominateur <= 0) return;

    final widthPerSlice = size.width / denominateur;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(10),
    );

    canvas.clipRRect(rrect);

    final emptyPaint = Paint()
      ..color = emptyColor
      ..style = PaintingStyle.fill;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final separatorPaint = Paint()
      ..color = borderColor.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Fond complet vide
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), emptyPaint);

    // Dessin des parts pleines
    for (int i = 0; i < denominateur; i++) {
      final rect = Rect.fromLTWH(i * widthPerSlice, 0, widthPerSlice, size.height);
      if (i < numerateur) {
        canvas.drawRect(rect, fillPaint);
      }
      if (i > 0) {
        canvas.drawLine(
          Offset(i * widthPerSlice, 0),
          Offset(i * widthPerSlice, size.height),
          separatorPaint,
        );
      }
    }

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant FractionBarPainter oldDelegate) {
    return oldDelegate.numerateur != numerateur ||
        oldDelegate.denominateur != denominateur ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.emptyColor != emptyColor ||
        oldDelegate.borderColor != borderColor;
  }
}
