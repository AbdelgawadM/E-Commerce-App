import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts.dart';
import 'package:e_commerce/features/auth_feature/components/custom_button.dart';
import 'package:e_commerce/features/auth_feature/components/custom_text_form.dart';
import 'package:e_commerce/features/auth_feature/components/statement_row.dart';
import 'package:e_commerce/features/auth_feature/screens/login_screen.dart';
import 'package:e_commerce/features/main_feature/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistScreen extends StatefulWidget {
  const RegistScreen({super.key});

  @override
  State<RegistScreen> createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool loading = false;
  Future<void> registerUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() => loading = true);

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = credential.user;

      // Set display name
      await user?.updateDisplayName(nameController.text.trim());

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String msg = 'Signup failed';
      if (e.code == 'email-already-in-use') msg = 'Email already in use';
      if (e.code == 'weak-password') msg = 'Weak password';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Image(image: AssetImage('assets/images/freed.png')),
                const SizedBox(height: 30),
                CustomTextForm(label: 'Name', controller: nameController),
                const SizedBox(height: 20),
                CustomTextForm(label: 'Email', controller: emailController),
                const SizedBox(height: 20),
                CustomTextForm(
                  label: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                CustomTextForm(
                  label: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 30),
                loading
                    ? const CircularProgressIndicator(color: kPrimaryColor)
                    : CustomButton(buttonText: 'Sign Up', screen: registerUser),
                const SizedBox(height: 20),
                StatementRow(
                  statement: 'Already have Account ?',
                  buttonText: 'Login Now',
                  screen: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
