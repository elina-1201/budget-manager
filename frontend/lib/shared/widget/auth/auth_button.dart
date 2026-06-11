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

  Future<void> _handlePress() async {
    // Prevent multiple submissions
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } catch (error) {
      // Only show snackbar if widget is still in the tree
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.buttonText} failed: $error'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      // Only reset loading state if widget is still in the tree
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePress,
      child: _isLoading ? LoadingIndicator() : Text(widget.buttonText),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
