import 'package:flutter/material.dart';

import '../models/lake.dart';
import '../theme/app_colors.dart';

/// A stylized, survey-chart-style bathymetric rendering of a lake:
/// depth-shaded contour bands, labeled isobaths, a max-depth marker,
/// and a faint coordinate grid. Pinch-zoom it via [InteractiveViewer].
class BathymetryChart extends StatelessWidget {
  final Lake lake;

  const BathymetryChart({super.key, required this.lake});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF081218),
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: InteractiveViewer(
          maxScale: 5,
          child: AspectRatio(
            aspectRatio: 1.05,
            child: CustomPaint(painter: _BathymetryPainter(lake)),
          ),
        ),
      ),
    );
  }
}

class _BathymetryPainter extends CustomPainter {
  final Lake lake;

  _BathymetryPainter(this.lake);

  // Water column shading: shore → deepest basin.
  static const _shallow = Color(0xFF1C5A74);
  static const _deep = Color(0xFF03121E);

  @override
  void paint(Canvas canvas, Size size) {
    final pad = size.shortestSide * 0.10;
    final w = size.width - pad * 2;
    final h = size.height - pad * 2;

    Offset at(List<double> p) => Offset(pad + p[0] * w, pad + p[1] * h);

    // ── Coordinate grid ─────────────────────────────────────────────
    final grid = Paint()
      ..color = const Color(0xFF12303E)
      ..strokeWidth = 0.7;
    for (var i = 1; i < 8; i++) {
      final x = size.width * i / 8;
      final y = size.height * i / 8;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // ── Depth rings ─────────────────────────────────────────────────
    // Ring 0 is the shoreline; each inner ring is the outline lerped
    // toward the deep point, shaded darker as the water deepens.
    final deep = at(lake.deepPoint);
    final shore = lake.outline.map(at).toList();
    final ringCount = (lake.maxDepthFt / 5).round().clamp(3, 6);

    for (var r = 0; r < ringCount; r++) {
      final t = r / ringCount;
      final ring = shore
          .map((p) => Offset.lerp(p, deep, t * 0.92)!)
          .toList(growable: false);
      final path = _smoothClosed(ring);
      canvas.drawPath(
        path,
        Paint()..color = Color.lerp(_shallow, _deep, t)!,
      );
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = r == 0 ? 2.0 : 1.0
          ..color = r == 0
              ? const Color(0xFF7ED4F0)
              : const Color(0xFF4FA8C9).withValues(alpha: 0.55),
      );

      // Isobath label on the ring's east side.
      if (r > 0) {
        final depthFt = (lake.maxDepthFt * t).round();
        final east = ring.reduce((a, b) => a.dx > b.dx ? a : b);
        _label(canvas, '$depthFt', east + const Offset(2, -10),
            const Color(0xFF8FD8F2), 9);
      }
    }

    // ── Max depth marker ────────────────────────────────────────────
    final marker = Paint()
      ..color = AppColors.warning
      ..strokeWidth = 1.4;
    canvas.drawLine(deep + const Offset(-6, 0), deep + const Offset(6, 0), marker);
    canvas.drawLine(deep + const Offset(0, -6), deep + const Offset(0, 6), marker);
    canvas.drawCircle(
      deep,
      4,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = AppColors.warning
        ..strokeWidth = 1.4,
    );
    _label(canvas, '${lake.maxDepthFt} FT', deep + const Offset(8, 4),
        AppColors.warning, 10, FontWeight.w700);

    // ── Chart furniture ─────────────────────────────────────────────
    _label(canvas, 'N', Offset(size.width - 22, 10), AppColors.textSecondary,
        11, FontWeight.w700);
    final north = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(size.width - 16, 40), Offset(size.width - 16, 24), north);
    canvas.drawLine(Offset(size.width - 16, 24), Offset(size.width - 20, 30), north);
    canvas.drawLine(Offset(size.width - 16, 24), Offset(size.width - 12, 30), north);

    _label(
        canvas,
        '${lake.name.toUpperCase()} · DEPTHS IN FEET · APPROX.',
        Offset(10, size.height - 18),
        AppColors.textMuted,
        8.5,
        FontWeight.w600,
        1.1);
  }

  /// Closed smooth blob through [pts] (quadratic beziers via midpoints).
  Path _smoothClosed(List<Offset> pts) {
    final path = Path();
    final n = pts.length;
    Offset mid(Offset a, Offset b) => Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
    path.moveTo(mid(pts[0], pts[1]).dx, mid(pts[0], pts[1]).dy);
    for (var i = 1; i <= n; i++) {
      final p = pts[i % n];
      final m = mid(p, pts[(i + 1) % n]);
      path.quadraticBezierTo(p.dx, p.dy, m.dx, m.dy);
    }
    path.close();
    return path;
  }

  void _label(Canvas canvas, String text, Offset pos, Color color, double size,
      [FontWeight weight = FontWeight.w500, double letterSpacing = 0]) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
          letterSpacing: letterSpacing,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant _BathymetryPainter old) => old.lake != lake;
}
