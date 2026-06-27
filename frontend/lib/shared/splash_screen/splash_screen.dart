import 'package:flutter/material.dart';

//TODO: add a splash screen with the app logo
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loading...')),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            const Color.fromARGB(255, 240, 150, 15),
          ),
        ),
      ),
    );
  }
}
