import 'package:foreign_emp_scam_checker/features/job/domain/entities/risk_result.dart';

RiskResult analyzeJobContent(String content) {
  final text = content.toLowerCase();
  return RiskResult(
    upfrontPayment: RegExp(
      r'\b(upfront|registration|application|processing|training)\s+(fee|payment|cost)\b|\bpay\s+(a\s+)?(fee|deposit)\b',
    ).hasMatch(text),
    unrealisticIncome: RegExp(
      r'\b(guaranteed|guarantee)\s+(income|salary|earnings|profit)\b|\bearn\s+\$?\d{4,}\s+(per|a)\s+(day|week)\b',
    ).hasMatch(text),
    sensitiveInformation: RegExp(
      r'\b(passport|social security number|ssn|bank account|credit card|one[- ]time password|otp)\b',
    ).hasMatch(text),
  );
}
