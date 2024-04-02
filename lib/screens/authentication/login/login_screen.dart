import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/screens/authentication/auth_screen.dart';
import 'package:sellers_app/screens/global/global.dart';
import 'package:sellers_app/screens/home_screen.dart';
import 'package:sellers_app/widgets/custom_text_field.dart';
import 'package:sellers_app/widgets/error_dialog.dart';
import 'package:sellers_app/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (context) => const ErrorDialog(
                message: 'Please write email/password',
              ));
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (context) => const LoadingDialog(
        message: 'Checking credentials',
      ),
    );
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then(
      (auth) {
        currentUser = auth.user!;
      },
    ).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            message: error.toString(),
          ),
        );
      },
    );
    if (currentUser != null) {
      readDataAndSetDataLocaly(currentUser!);
    }
  }

  Future readDataAndSetDataLocaly(User currentUser) async {
    await FirebaseFirestore.instance
        .collection('sellers')
        .doc(currentUser.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          await sharedPreferences!.setString('uid', currentUser.uid);

          await sharedPreferences!.setString(
            'sellerEmail',
            snapshot.data()!['sellerEmail'],
          );

          await sharedPreferences!.setString(
            'sellerName',
            snapshot.data()!['sellerName'],
          );

          await sharedPreferences!.setString(
            'sellerAvatarURL',
            snapshot.data()!['sellerAvatarURL'],
          );
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          firebaseAuth.signOut();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: height * 0.4,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset('assets/images/seller.png'),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  icon: Icons.email,
                  controller: emailController,
                  hintText: 'Email',
                  isObscure: false,
                ),
                CustomTextField(
                  icon: Icons.lock,
                  controller: passwordController,
                  hintText: 'Password',
                  isObscure: true,
                ),
                ElevatedButton(
                  onPressed: () {
                    formValidation();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
