import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/security_check_colors.dart';

class RiskScale extends StatelessWidget {
  const RiskScale({required this.score, super.key});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final markerLeft = (constraints.maxWidth * score / 100 - 2)
                .clamp(0.0, constraints.maxWidth - 4)
                .toDouble();
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 7,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00A477),
                        Color(0xFF98B845),
                        Color(0xFFF2A51B),
                        Color(0xFFE33434),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Positioned(
                  left: markerLeft,
                  top: -2,
                  child: Container(
                    width: 4,
                    height: 11,
                    decoration: BoxDecoration(
                      color: securityInkColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ScaleLabel('Safe'),
            _ScaleLabel('Caution'),
            _ScaleLabel('Suspicious'),
            _ScaleLabel('Dangerous'),
          ],
        ),
      ],
    );
  }
}

class _ScaleLabel extends StatelessWidget {
  const _ScaleLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: securityMutedColor, fontSize: 9),
    );
  }
}
