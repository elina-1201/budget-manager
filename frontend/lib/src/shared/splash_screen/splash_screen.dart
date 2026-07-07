import 'package:budget_manager/generated/l10n.dart';
import 'package:flutter/material.dart';

//TODO: add a splash screen with the app logo
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).loading)),
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
