import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.google, color: Colors.black),
          label: Text('Sign in with Google'),
          style: ElevatedButton.styleFrom(minimumSize: const Size(170, 50)),
        ),
      ),
    );
  }
}
