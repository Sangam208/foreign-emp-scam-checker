import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/job/domain/entities/risk_result.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/risk_scale.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/risk_score_view.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/scam_indicator_card.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/security_check_colors.dart';

class RiskResultPage extends StatelessWidget {
  const RiskResultPage({
    required this.result,
    required this.checkType,
    super.key,
  });

  final RiskResult result;
  final String checkType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: securityPageColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    RiskScoreView(result: result),
                    const SizedBox(height: 8),
                    Text(
                      result.score == 0
                          ? 'No strong warning signs found in this check. Still worth an independent check.'
                          : 'Some warning signs were found. Verify the details independently before proceeding.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: securityMutedColor,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RiskScale(score: result.score),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Scam indicators',
                        style: TextStyle(
                          color: securityInkColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ScamIndicatorCard(
                      title: 'Upfront Payment Request',
                      detected: result.upfrontPayment,
                      icon: Icons.payments_outlined,
                    ),
                    ScamIndicatorCard(
                      title: 'Unrealistic Salary or Guaranteed Income',
                      detected: result.unrealisticIncome,
                      icon: Icons.warning_amber_rounded,
                    ),
                    ScamIndicatorCard(
                      title: 'Sensitive Personal Info Requested Early',
                      detected: result.sensitiveInformation,
                      icon: Icons.security_outlined,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$checkType checked on this device. This automated check can miss scams; verify the employer independently.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: securityMutedColor,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        children: [
          const SizedBox(width: 4),
          IconButton(
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: securityInkColor,
              side: const BorderSide(color: Color(0xFFE4E7F0)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Risk Result',
            style: TextStyle(
              color: securityInkColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
