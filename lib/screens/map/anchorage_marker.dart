import 'package:flutter/material.dart';

import '../../data/anchorage_data.dart';

/// A category-coded POI marker for Anchorage city mode. Turnagain Outfitters
/// gets a slow pulse ring to draw the eye as the featured gear partner.
class AnchorageMarker extends StatefulWidget {
  final AnchoragePOI poi;
  final VoidCallback onTap;

  const AnchorageMarker({super.key, required this.poi, required this.onTap});

  @override
  State<AnchorageMarker> createState() => _AnchorageMarkerState();
}

class _AnchorageMarkerState extends State<AnchorageMarker>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulseController;

  bool get _pulses => widget.poi.isTurnagainOutfitters;

  @override
  void initState() {
    super.initState();
    if (_pulses) {
      _pulseController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1800),
      )..repeat();
    }
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    super.dispose();
  }

  String get _emoji => switch (widget.poi.category) {
        AnchoragePOICategory.fishing => '🎣',
        AnchoragePOICategory.lake => '🎣',
        AnchoragePOICategory.food => '🍽',
        AnchoragePOICategory.lodging => '🏨',
        AnchoragePOICategory.gearRental => '🎒',
        AnchoragePOICategory.trail => '🥾',
        AnchoragePOICategory.scenic => '📸',
        AnchoragePOICategory.wildlife => '🦅',
      };

  Color get _color => switch (widget.poi.category) {
        AnchoragePOICategory.fishing => const Color(0xFF3B82F6),
        AnchoragePOICategory.lake => const Color(0xFF3B82F6),
        AnchoragePOICategory.food => const Color(0xFFF59E0B),
        AnchoragePOICategory.lodging => const Color(0xFF8B5CF6),
        AnchoragePOICategory.gearRental => const Color(0xFF2D6A4F),
        AnchoragePOICategory.trail => const Color(0xFF92400E),
        AnchoragePOICategory.scenic => const Color(0xFF0D9488),
        AnchoragePOICategory.wildlife => const Color(0xFFEA580C),
      };

  double get _size => widget.poi.isTurnagainOutfitters ? 44 : 32;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: _size + 24,
        height: _size + 24,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_pulseController != null)
              AnimatedBuilder(
                animation: _pulseController!,
                builder: (context, _) {
                  final t = _pulseController!.value;
                  return Opacity(
                    opacity: (1 - t).clamp(0.0, 1.0) * 0.5,
                    child: Transform.scale(
                      scale: 1.0 + t * 1.2,
                      child: Container(
                        width: _size,
                        height: _size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _color,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(_emoji,
                    style: TextStyle(fontSize: _size * 0.45)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
