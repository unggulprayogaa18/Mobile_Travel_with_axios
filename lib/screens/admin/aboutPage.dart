import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abdullahsidik_uts/controllers/login_controller.dart';
import 'package:abdullahsidik_uts/screens/WelcomeScreen.dart'; // Import WelcomeScreen
import 'package:abdullahsidik_uts/widgets/sessionname.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AboutPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String email = '';

    if (user != null) {
      if (user.providerData[0].providerId == 'google.com') {
        email = user.email!;
        print('asu:$email');
      }
    } else {
      email = SimpanEmail.getEmail();
      print('asu2:$email');
    }

    // Conditionally set the profile image based on login method
    Widget profileImage = user?.providerData[0].providerId == 'google.com'
        ? CircleAvatar(
            radius: 60.0,
            backgroundColor: Color.fromARGB(255, 247, 209, 86),
            backgroundImage: NetworkImage(user?.photoURL ?? ''),
          )
        : CircleAvatar(
            radius: 60.0,
            backgroundColor: Color.fromARGB(255, 247, 209, 86),
            backgroundImage: AssetImage('assets/avvvatar.png'),
          );

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 7, 156, 255),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar Profile
          profileImage,

          SizedBox(height: 16.0),

          // Nama
          Text(
            '$email',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 16.0),

          // Menu Items
          buildMenuItem(
            context,
            'Edit Profile',
            Icons.edit,
            () {
              // Handle Edit Profile action
            },
          ),
          buildMenuItem(
            context,
            'Settings',
            Icons.settings,
            () {
              // Handle Settings action
            },
          ),
          buildMenuItem(
            context,
            'About',
            Icons.info,
            () {
              // Handle About action
            },
          ),
          buildMenuItem(
            context,
            'Privacy',
            Icons.privacy_tip,
            () {
              // Handle Privacy action
            },
          ),
          buildMenuItem(
            context,
            'Security',
            Icons.security,
            () {
              // Handle Security action
            },
          ),
          buildMenuItem(
            context,
            'Logout',
            Icons.exit_to_app,
            () async {
              if (user?.providerData[0]?.providerId == 'google.com') {
                // Handle Logout action for Google sign-in
                // Sign out from Google Sign-In
                await _googleSignIn.signOut();
                // Sign out from Firebase Authentication
                await _auth.signOut();
                // Navigate to WelcomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              } else {
                // Handle Logout action for other sign-in methods
                Get.find<LoginController>().logout();
              }
            },
          ),

          SizedBox(height: 16.0),

          // Catatan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              '',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(
      BuildContext context, String title, IconData icon, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
