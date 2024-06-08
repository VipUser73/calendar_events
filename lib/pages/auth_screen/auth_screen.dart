import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green.shade700,
          title: const Text('MeetRoom'),
        ),
        body: SafeArea(
          child: Form(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 60),
              children: [
                WTextField(
                  textController: emailController,
                  labelText: 'Email',
                ),
                const SizedBox(height: 16),
                WTextField(
                  textController: passwordController,
                  labelText: 'Password',
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: ElevatedButton(
                    onPressed: () => submit(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class WTextField extends StatelessWidget {
  const WTextField({
    super.key,
    required this.textController,
    required this.labelText,
    this.isPassword = false,
  });

  final TextEditingController textController;
  final bool isPassword;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isPassword ? true : false,
        maxLength: 16,
        controller: textController,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        validator: (value) {
          if (value != null && value.length < 8) {
            return 'Minimum 8 characters';
          } else {
            return null;
          }
        });
  }
}
