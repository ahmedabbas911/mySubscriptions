import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';

class ForgotPasswordDialogWidget extends StatefulWidget {
  final String initialEmail;

  const ForgotPasswordDialogWidget({
    super.key,
    required this.initialEmail,
  });

  @override
  State<ForgotPasswordDialogWidget> createState() =>
      _ForgotPasswordDialogWidgetState();
}

class _ForgotPasswordDialogWidgetState
    extends State<ForgotPasswordDialogWidget> {
  final resetFormKey = GlobalKey<FormState>();
  late TextEditingController resetEmailController;
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    resetEmailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    resetEmailController.dispose();
    super.dispose();
  }

  static InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.55)),
      floatingLabelStyle: const TextStyle(color: Color(0xFFB5A9FF)),
      prefixIcon: Icon(
        icon,
        color: Colors.white.withValues(alpha: 0.45),
        size: 21,
      ),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.045),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF9B8AFF), width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1B2235),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
      ),
      title: const Text(
        'Reset Password',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Form(
        key: resetFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your email address and we will send you a link to reset your password.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: resetEmailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(
                label: 'Email',
                icon: Icons.email_outlined,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      actions: [
        TextButton(
          onPressed: isSending ? null : () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.60),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: isSending
              ? null
              : () async {
                  if (resetFormKey.currentState?.validate() ?? false) {
                    setState(() {
                      isSending = true;
                    });

                    final email = resetEmailController.text.trim();

                    try {
                      await context
                          .read<AuthCubit>()
                          .sendPasswordResetEmail(email);

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password reset email sent! Please check your inbox.',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } catch (e) {
                      setState(() {
                        isSending = false;
                      });

                      String errorMessage =
                          'Failed to send password reset email';

                      if (e is FirebaseAuthException) {
                        if (e.code == 'user-not-found') {
                          errorMessage = 'No user found with this email.';
                        } else if (e.code == 'invalid-email') {
                          errorMessage = 'Invalid email address.';
                        } else {
                          errorMessage =
                              e.message ?? 'Authentication error.';
                        }
                      }

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C6BEE),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: isSending
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Send Reset Link'),
        ),
      ],
    );
  }
}
