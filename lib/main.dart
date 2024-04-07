import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import firebase_core
import 'package:get/get.dart';
import 'navigation/costumnavigationbar.dart';
import 'navigation/costumnavigationuserbar.dart';
import 'package:abdullahsidik_uts/screens/WelcomeScreen.dart';
import 'firebase_options.dart'; // Impor file firebase_options.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase dengan opsi default dari file firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(
        name: '/',
        page: () => WelcomeScreen(),
      ),
      GetPage(  
        name: '/home_admin',
        page: () => CustomNavigationBar(),
      ),
      GetPage(  
        name: '/home_user',
        page: () => CustomNavigationUserBar(),
      ),
        GetPage(  
        name: '/welcome',
        page: () => WelcomeScreen(),
      ),
      // Lainnya rute jika ada
    ],
  ));
}
