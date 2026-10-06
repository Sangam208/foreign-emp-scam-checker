import 'package:flutter/material.dart';

const securityPageColor = Color(0xFFF6F7FB);
const securityInkColor = Color(0xFF17233F);
const securityMutedColor = Color(0xFF687184);
const securityAccentColor = Color(0xFF394AA5);
const securitySuccessColor = Color(0xFF079B71);
const securityWarningColor = Color(0xFFD94A36);

Color securityRiskColor(int score) {
  if (score >= 60) return const Color(0xFFD82735);
  if (score >= 30) return const Color(0xFFE58B17);
  return securitySuccessColor;
}
