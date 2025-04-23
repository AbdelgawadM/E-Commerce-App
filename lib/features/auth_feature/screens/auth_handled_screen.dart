import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/consts.dart';
import 'package:e_commerce/features/main_feature/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthHandlerScreen extends StatefulWidget {
  const AuthHandlerScreen({super.key});

  @override
  State<AuthHandlerScreen> createState() => _AuthHandlerScreenState();
}

class _AuthHandlerScreenState extends State<AuthHandlerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleAuth();
    });
  }

  Future<void> saveUserData(User user) async {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    // Check if user already exists to avoid overwrite
    final doc = await userRef.get();
    if (doc.exists) return;

    await userRef.set({
      'uid': user.uid,
      'email': user.email ?? '',
      'name': user.displayName ?? 'Guest',
      'photoUrl': user.photoURL ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  void handleAuth() async {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      await auth.signInAnonymously();
    }

    final user = auth.currentUser!;
    await saveUserData(user); // <--- حفظ البيانات هنا

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: kPrimaryColor),
            SizedBox(height: 10),
            Text(
              "Setting things up for you...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
