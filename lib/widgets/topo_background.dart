import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class TopoBackground extends StatelessWidget {
  final Widget child;
  final double opacity;

  const TopoBackground({
    super.key,
    required this.child,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: opacity,
            child: CustomPaint(painter: _TopoPainter()),
          ),
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
      ..color = AppColors.topoLine
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final brightPaint = Paint()
      ..color = AppColors.topoLineBright
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const lineCount = 14;
    final spacing = size.height / lineCount;

    for (int i = 0; i < lineCount; i++) {
      final y = i * spacing;
      final path = Path();
      final isMajor = i % 4 == 0;

      path.moveTo(0, y);

      const segmentWidth = 60.0;
      final segments = (size.width / segmentWidth).ceil() + 1;

      for (int j = 0; j < segments; j++) {
        final x1 = j * segmentWidth;
        final x2 = x1 + segmentWidth / 2;
        final x3 = x1 + segmentWidth;

        final amp1 = 6.0 + math.sin(i * 0.7 + j * 0.4) * 4.0;
        final amp2 = 6.0 + math.cos(i * 0.5 + j * 0.3) * 5.0;

        path.quadraticBezierTo(x2, y + amp1, x3, y + amp2 * 0.3);
      }

      canvas.drawPath(path, isMajor ? brightPaint : paint);
    }

    // Vertical accent lines — subtle meridian effect
    final vPaint = Paint()
      ..color = AppColors.topoLine.withValues(alpha: 0.4)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 8; i++) {
      final x = i * (size.width / 8) + size.width / 16;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), vPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
