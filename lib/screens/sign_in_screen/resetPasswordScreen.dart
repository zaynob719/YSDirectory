import 'package:YSDirectory/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Reset Password',
          style: TextStyle(fontFamily: 'GentiumPlus', color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email address',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Password reset email sent',
                          style: TextStyle(fontFamily: 'GentiumPlus')),
                      backgroundColor: brown,
                    ));
                    Navigator.pop(context); // Close the reset password screen
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Error sending reset password email',
                          style: TextStyle(fontFamily: 'GentiumPlus')),
                      backgroundColor: brown,
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please enter your email address',
                        style: TextStyle(fontFamily: 'GentiumPlus')),
                    backgroundColor: brown,
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orengy,
              ),
              child: const Text('Send Reset Password',
                  style: TextStyle(fontFamily: 'GentiumPlus')),
            ),
          ],
        ),
      ),
    );
  }
}
