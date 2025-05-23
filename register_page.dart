import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_textfield.dart'; // This import is required now
import 'package:food_delivery_app/services/auth/auth_service.dart'; // Import AuthService

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .colorScheme
          .surface, // Updated from 'background' to 'surface'
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_open_rounded,
                size: 100, color: Theme.of(context).colorScheme.inversePrimary),
            const SizedBox(height: 25),
            Text("Let's Create an Account for you",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 25),
            MyTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false), // Fixed widget name here
            const SizedBox(height: 10),
            MyTextfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true), // Fixed widget name here
            const SizedBox(height: 10),
            MyTextfield(
                controller: confirmpasswordController,
                hintText: "Confirm Password",
                obscureText: true), // Fixed widget name here
            const SizedBox(height: 25),
            MyButton(
                text: "Sign Up",
                onTap: () {
                  register();
                }),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an account? ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Login Now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void register() async {
    final _authService = AuthService();

    if (passwordController.text == confirmpasswordController.text) {
      try {
        await _authService.signUpWithEmailPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())));
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password Mismatch"),
          content: Text("Please make sure both passwords match."),
        ),
      );
    }
  }
}
