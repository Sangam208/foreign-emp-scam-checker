import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/job/domain/entities/risk_result.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/security_check_colors.dart';

class RiskScoreView extends StatelessWidget {
  const RiskScoreView({required this.result, super.key});

  final RiskResult result;

  @override
  Widget build(BuildContext context) {
    final riskColor = securityRiskColor(result.score);
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 116,
                height: 116,
                child: CircularProgressIndicator(
                  value: result.score / 100,
                  strokeWidth: 9,
                  strokeCap: StrokeCap.round,
                  color: riskColor,
                  backgroundColor: const Color(0xFFEAECF3),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${result.score}',
                    style: const TextStyle(
                      color: securityInkColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    '/ 100',
                    style: TextStyle(color: securityMutedColor, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
          decoration: BoxDecoration(
            color: riskColor.withValues(alpha: 0.07),
            border: Border.all(color: riskColor.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            result.riskLabel,
            style: TextStyle(
              color: riskColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
