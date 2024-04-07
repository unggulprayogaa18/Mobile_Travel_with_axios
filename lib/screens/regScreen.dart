import 'package:abdullahsidik_uts/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abdullahsidik_uts/controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your existing code for the background gradient
          Positioned.fill(
            bottom: 300,
            child: Image.asset(
              'assets/list/pexels-zachary-debottis-1838640.jpg', // Ganti dengan path gambar Anda
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(115, 60, 88, 104),
                  Color.fromARGB(54, 59, 130, 189)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Hello\nSign UP!',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Your existing code for the login form
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                child: SingleChildScrollView( // Wrap with SingleChildScrollView
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: registerController.usernameController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text(
                            'Username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 46, 39, 20),
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        return TextField(
                          obscureText: !registerController.showPassword.value,
                          controller: registerController.passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                registerController.showPassword.toggle();
                              },
                              icon: Icon(registerController.showPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 46, 39, 20),
                              ),
                            ),
                          ),
                        );
                      }),
                      Obx(() {
                        return TextField(
                          obscureText: !registerController.showConfirmPassword.value,
                          controller: registerController.kompasswordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                registerController.showConfirmPassword.toggle();
                              },
                              icon: Icon(registerController.showConfirmPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 46, 39, 20),
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Handle Sign Up action
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen())); // Assuming '/signup' is the route for the sign up screen
                          },
                          child: Text(
                            'Let\'s go Sign In?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff281537),
                            ),
                          ),  
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(148, 20, 115, 170),
                              Color.fromARGB(255, 65, 100, 129)
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: registerController.register,
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
