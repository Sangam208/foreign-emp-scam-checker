import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/security_check_colors.dart';

class SecurityAnalysisView extends StatelessWidget {
  const SecurityAnalysisView({
    required this.checkType,
    required this.currentStep,
    super.key,
  });

  static const steps = [
    'Extracting job information',
    'Checking company identity',
    'Analyzing language',
    'Checking contact info',
    'Detecting suspicious requests',
    'Calculating risk score',
  ];

  final String checkType;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SizedBox(
                width: 56,
                height: 56,
                child: CircularProgressIndicator(
                  color: securityAccentColor,
                  backgroundColor: Color(0xFFE3E6F2),
                  strokeWidth: 4,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: Text(
                'Analyzing ${checkType.toLowerCase()}...',
                style: const TextStyle(
                  color: securityInkColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 14),
            for (var index = 0; index < steps.length; index++)
              _AnalysisStep(
                label: steps[index],
                complete: index < currentStep,
                active: index == currentStep,
              ),
          ],
        ),
      ),
    );
  }
}

class _AnalysisStep extends StatelessWidget {
  const _AnalysisStep({
    required this.label,
    required this.complete,
    required this.active,
  });

  final String label;
  final bool complete;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = complete
        ? securitySuccessColor
        : active
        ? securityAccentColor
        : securityMutedColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            complete ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 9),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
