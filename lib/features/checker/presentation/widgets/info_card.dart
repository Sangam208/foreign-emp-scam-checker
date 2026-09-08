import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData iconData;

  final String count;

  final String labelText;

  final Color iconColor;

  const InfoCard({
    super.key,
    required this.iconData,
    required this.count,
    required this.labelText,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(iconData, color: iconColor),
            const SizedBox(height: 10),
            Text(count, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(labelText, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
