import 'package:flutter/material.dart';

class Sample extends StatelessWidget {
  final String token;
  const Sample({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SelectableText(token),
    );
  }
}
