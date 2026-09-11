import 'package:flutter/material.dart';

class ReportRow extends StatelessWidget {
  final String label;
  final String value;
  const ReportRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
