import 'package:abdullahsidik_uts/navigation/costumnavigationuserbar.dart';
import 'package:flutter/material.dart';
import 'package:abdullahsidik_uts/screens/regScreen.dart';
import 'package:abdullahsidik_uts/screens/loginScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:abdullahsidik_uts/screens/user/homePageUser.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg/awan.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(155, 27, 32, 36), // warna biru
                  Color.fromARGB(143, 24, 33, 41), // warna putih
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.5
                ], // stops untuk mengatur transparansi pada gambar
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Transform.scale(
                    scale: 1.8,
                    child: Image.asset('assets/logoo.png'),
                  ),
                ),
                SizedBox(height: 80),
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    height: 43,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await _signInWithGoogle(context);
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.google,
                            color: Colors
                                .red), // Using FontAwesomeIcons for Google
                        SizedBox(width: 10), // Jarak antara ikon dan teks
                        Text(
                          'Login with Google',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'Login with Social Media',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk melakukan login dengan Google menggunakan Firebase Authentication
  Future<void> _signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      // Meminta izin untuk mengakses akun Google pengguna
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Mendapatkan token otentikasi Google
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;

      // Mendapatkan kredensial Firebase menggunakan token otentikasi Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Melakukan login ke Firebase menggunakan kredensial yang didapatkan
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // Mendapatkan informasi pengguna yang berhasil login
      final User? user = userCredential.user;

      // Jika login berhasil, tampilkan pesan sukses
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in success! Welcome, ${user.displayName}'),
          ),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomNavigationUserBar()));
        // Navigasi ke layar beranda atau halaman setelah login berhasil
        // Misalnya:
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Jika gagal mendapatkan informasi pengguna, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in'),
          ),
        );
      }
    } catch (error) {
      // Tangani kesalahan yang mungkin terjadi selama proses autentikasi
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in'),
        ),
      );
    }
  }
}
