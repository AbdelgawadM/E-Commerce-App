import 'package:e_commerce/consts.dart';
import 'package:e_commerce/features/auth_feature/screens/login_screen.dart';
import 'package:e_commerce/features/checkout_feature/screens/checkout_screen.dart';
import 'package:e_commerce/features/favourite_feature/screens/favourites_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  Future<Map<String, dynamic>?> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc.data();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Failed to load user data'));
          }

          final userData = snapshot.data!;
          final displayName = userData['name'] ?? 'No Name';
          final email = userData['email'] ?? 'No Email';
          // final photoUrl = userData['photoUrl']; // optional

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Profile Picture
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          // photoUrl != null
                          //     ? NetworkImage(photoUrl)
                          //     :
                          const AssetImage("assets/images/OIP.jpeg")
                              as ImageProvider,
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: kPrimaryColor,
                      child: const Icon(
                        Icons.edit,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Name & Email
                Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(email, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),

                // Options
                ProfileOption(
                  icon: CupertinoIcons.heart,
                  title: 'Favorites',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouritesScreen(),
                      ),
                    );
                  },
                ),
                ProfileOption(
                  icon: CupertinoIcons.cart,
                  title: 'My Orders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                ),
                ProfileOption(
                  icon: CupertinoIcons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
                ProfileOption(
                  icon: CupertinoIcons.info,
                  title: 'About App',
                  onTap: () {},
                ),
                ProfileOption(
                  icon: CupertinoIcons.square_arrow_right,
                  title: 'Logout',
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  color: Colors.red,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.black,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: ListTile(
        leading: Icon(icon, color: kPrimaryColor),
        title: Text(title, style: TextStyle(color: color)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
