import 'package:e_commerce/features/auth_feature/components/custom_button.dart';
import 'package:e_commerce/features/auth_feature/components/custom_text_form.dart';
import 'package:e_commerce/features/auth_feature/components/statement_row.dart';
import 'package:e_commerce/features/auth_feature/screens/forget_screen.dart';
import 'package:e_commerce/features/auth_feature/screens/regist_screen.dart';
import 'package:e_commerce/features/main_feature/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> saveUserData(User user) async {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    final doc = await userRef.get();
    if (!doc.exists) {
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'name': user.displayName ?? user.email?.split('@').first ?? 'No Name',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Image(image: AssetImage('assets/images/freed.png')),
              const SizedBox(height: 30),
              CustomTextForm(label: 'Email', controller: emailController),
              const SizedBox(height: 20),
              CustomTextForm(label: 'Password', controller: passwordController),
              const SizedBox(height: 20),
              CustomButton(
                buttonText: 'Login',
                screen: () async {
                  try {
                    UserCredential credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                    await saveUserData(credential.user!);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed: ${e.toString()}')),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: const Text(
                    'forget password',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetScreen(),
                      ),
                    );
                  },
                ),
              ),
              StatementRow(
                statement: 'don\'t have Account ?',
                buttonText: 'Sign Up Now',
                screen: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
