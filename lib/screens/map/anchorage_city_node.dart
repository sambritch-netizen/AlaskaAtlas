import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// The state-view marker shown over Anchorage before the user zooms in
/// far enough to trigger City Mode. A slow expanding ring plus a label
/// pill invites the zoom.
class AnchorageCityNode extends StatefulWidget {
  final VoidCallback onTap;

  const AnchorageCityNode({super.key, required this.onTap});

  @override
  State<AnchorageCityNode> createState() => _AnchorageCityNodeState();
}

class _AnchorageCityNodeState extends State<AnchorageCityNode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ringController;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 120,
        height: 80,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AnimatedBuilder(
              animation: _ringController,
              builder: (context, _) {
                final t = _ringController.value;
                return Opacity(
                  opacity: (0.6 * (1 - t)).clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 1.0 + t * 1.4,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.pine,
                      ),
                    ),
                  ),
                );
              },
            ),
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.pine,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            Positioned(
              top: 22,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.pine,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'Anchorage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
