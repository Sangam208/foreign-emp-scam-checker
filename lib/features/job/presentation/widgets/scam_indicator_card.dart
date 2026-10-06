import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/security_check_colors.dart';

class ScamIndicatorCard extends StatelessWidget {
  const ScamIndicatorCard({
    required this.title,
    required this.detected,
    required this.icon,
    super.key,
  });

  final String title;
  final bool detected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final color = detected ? securityWarningColor : securitySuccessColor;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E6EF)),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080D1B3E),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: color, size: 17),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: securityInkColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detected ? 'Warning sign detected.' : 'No issue detected.',
                  style: const TextStyle(
                    color: securityMutedColor,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.07),
                    border: Border.all(color: color.withValues(alpha: 0.25)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    detected ? 'Review carefully' : 'Low Risk',
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
