import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Paints faint topographic contour lines behind its child — the signature
/// rugged texture of the app.
class TopoBackground extends StatelessWidget {
  final Widget child;
  final double opacity;

  const TopoBackground({super.key, required this.child, this.opacity = 0.3});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: opacity,
          child: CustomPaint(painter: _TopoPainter()),
        ),
        child,
      ],
    );
  }
}

class _TopoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Deterministic pseudo-random contours so the texture is stable.
    final rng = math.Random(49); // Alaska, the 49th state
    for (var i = 0; i < 9; i++) {
      paint.color = i.isEven ? AppColors.topoLine : AppColors.topoLineBright;
      final path = Path();
      final baseY = size.height * (i + 0.5) / 9;
      path.moveTo(-20, baseY);
      var x = -20.0;
      var y = baseY;
      while (x < size.width + 20) {
        final dx = 40 + rng.nextDouble() * 50;
        final dy = (rng.nextDouble() - 0.5) * 70;
        final cx = x + dx / 2;
        final cy = y + dy / 2 + (rng.nextDouble() - 0.5) * 30;
        x += dx;
        y = baseY + dy;
        path.quadraticBezierTo(cx, cy, x, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
