import 'package:flutter/material.dart';

class AgencyDetails extends StatelessWidget {
  final List<Widget> children;
  const AgencyDetails({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
