import 'package:flutter/material.dart';

class RecentChecks extends StatelessWidget {
  final IconData iconData;
  final String jobTitle;
  final String date;
  final String jobRisk;
  final Color color;
  const RecentChecks({
    super.key,
    required this.iconData,
    required this.jobTitle,
    required this.date,
    required this.jobRisk,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                spacing: 3,
                children: [
                  Icon(
                    iconData,
                    color: Colors.blueGrey,
                    shadows: [Shadow(offset: Offset(1, 2))],
                  ),

                  Column(
                    children: [
                      Text(jobTitle, style: TextStyle(fontSize: 12)),
                      Text(date, style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Text(
                      jobRisk,
                      style: TextStyle(fontSize: 9, color: color),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
