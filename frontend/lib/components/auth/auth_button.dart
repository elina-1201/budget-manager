import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final String buttonText;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await widget.onPressed();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.buttonText} successful.')),
                );
              } catch (error) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.buttonText} failed: $error'),
                  ),
                );
              } finally {
                if (!mounted) return;
                setState(() {
                  _isLoading = false;
                });
              }
            },
      child: _isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(widget.buttonText),
    );
  }
}
