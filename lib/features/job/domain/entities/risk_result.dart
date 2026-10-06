class RiskResult {
  const RiskResult({
    required this.upfrontPayment,
    required this.unrealisticIncome,
    required this.sensitiveInformation,
  });

  final bool upfrontPayment;
  final bool unrealisticIncome;
  final bool sensitiveInformation;

  int get score =>
      ((upfrontPayment ? 40 : 0) +
              (unrealisticIncome ? 25 : 0) +
              (sensitiveInformation ? 40 : 0))
          .clamp(0, 100);

  String get riskLabel {
    if (score >= 80) return 'DANGEROUS';
    if (score >= 60) return 'SUSPICIOUS';
    if (score >= 30) return 'CAUTION';
    return 'LOW RISK';
  }
}
