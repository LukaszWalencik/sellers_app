import 'package:flutter/material.dart';
import 'package:sellers_app/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          controller: emailController,
          icon: Icons.email,
          hintText: 'Email',
          isObscure: false,
        ),
        CustomTextField(
          controller: passwordController,
          icon: Icons.key,
          hintText: 'Email',
          isObscure: false,
        ),
      ],
    );
  }
}
