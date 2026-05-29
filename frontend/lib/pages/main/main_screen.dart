import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

String apiBaseUrl() {
  // Android emulator -> host machine
  // iOS simulator -> localhost works
  // real device -> use your LAN IP
  if (defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:8080';
  }
  return 'http://localhost:8080';
}

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
