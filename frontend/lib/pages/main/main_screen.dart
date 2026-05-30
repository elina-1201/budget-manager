import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Manager')),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/register');
          },
          child: const Text('Go to Register Screen'),
        ),
      ),
    );
  }
}
