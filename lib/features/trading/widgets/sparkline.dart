import 'dart:math' as math;
import 'package:flutter/material.dart';

class Sparkline extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double strokeWidth;
  final bool filled;

  const Sparkline({
    super.key,
    required this.data,
    required this.color,
    this.strokeWidth = 1.5,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (data.length < 2) return const SizedBox.shrink();
    return CustomPaint(
      painter: _SparklinePainter(
        data: data,
        color: color,
        strokeWidth: strokeWidth,
        filled: filled,
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final double strokeWidth;
  final bool filled;

  const _SparklinePainter({
    required this.data,
    required this.color,
    required this.strokeWidth,
    required this.filled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final min = data.reduce(math.min);
    final max = data.reduce(math.max);
    final range = (max - min).abs();

    Offset point(int i) {
      final x = (i / (data.length - 1)) * size.width;
      final y = range == 0
          ? size.height / 2
          : size.height - ((data[i] - min) / range) * size.height * 0.85 -
              size.height * 0.075;
      return Offset(x, y);
    }

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()..moveTo(point(0).dx, point(0).dy);
    for (int i = 1; i < data.length; i++) {
      final prev = point(i - 1);
      final curr = point(i);
      final cpx = (prev.dx + curr.dx) / 2;
      path.cubicTo(cpx, prev.dy, cpx, curr.dy, curr.dx, curr.dy);
    }

    if (filled) {
      final fillPath = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(
        fillPath,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.25), color.withValues(alpha: 0.0)],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
      );
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.data != data || old.color != color;
}
