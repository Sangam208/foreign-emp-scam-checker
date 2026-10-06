import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/job/domain/usecases/analyze_job_content.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/screens/risk_result_screen.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/security_analysis_view.dart';
import 'package:foreign_emp_scam_checker/features/job/presentation/widgets/security_check_colors.dart';

class SecurityCheckPage extends StatefulWidget {
  const SecurityCheckPage({
    required this.content,
    required this.checkType,
    super.key,
  });

  final String content;
  final String checkType;

  @override
  State<SecurityCheckPage> createState() => _SecurityCheckPageState();
}

class _SecurityCheckPageState extends State<SecurityCheckPage> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _analyze();
  }

  Future<void> _analyze() async {
    for (var step = 0; step < SecurityAnalysisView.steps.length; step++) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
      setState(() => _currentStep = step + 1);
    }

    if (!mounted) return;
    final result = analyzeJobContent(widget.content);
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => RiskResultPage(
          result: result,
          checkType: widget.checkType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: securityPageColor,
      body: SafeArea(
        child: SecurityAnalysisView(
          checkType: widget.checkType,
          currentStep: _currentStep,
        ),
      ),
    );
  }
}
