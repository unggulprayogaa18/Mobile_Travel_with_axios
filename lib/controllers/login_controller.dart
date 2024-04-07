import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var showPassword = false.obs;

  void login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    Map<String, dynamic> formData = {
      'username': username,
      'password': password,
    };
    
    try {
      final response = await http.post(
        Uri.parse('https://sidikwebsite.000webhostapp.com/mobile_login.php'),
        body: formData,
      );

      if (response.statusCode == 200) {
        String cleanedResponse = response.body.trim();
        final startIndex = cleanedResponse.indexOf('{');
        final endIndex = cleanedResponse.lastIndexOf('}') + 1;
        if (startIndex != -1 && endIndex != -1) {
          cleanedResponse = cleanedResponse.substring(startIndex, endIndex);
        }

        try {
          Map<String, dynamic> jsonMap = json.decode(cleanedResponse);

          if (jsonMap['status'] == 'success') {
            String userStatus = jsonMap['user_status'];

            if (userStatus == 'user') {
              Get.offAllNamed('/home_user');
            } else if (userStatus == 'admin') {
              Get.offAllNamed('/home_admin');
            } else {
              // Handle other user statuses if needed
            }
          } else {
            Get.snackbar(
              'Login Failed',
              'Invalid username or password',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } catch (error) {
          print('Error parsing JSON: $error');
          Get.snackbar(
            'Error',
            'An error occurred during login. Please try again later.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        print('Error: ${response.statusCode}');
        // Handle other status codes (e.g., show an error message)
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar(
        'Error',
        'An error occurred during login. Please try again later. Error: $error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  void logout() {
      // Clear username and password controllers
      usernameController.clear();
      passwordController.clear();

      // Navigate back to welcome screen
      Get.offAllNamed(
          '/welcome'); // Assuming '/welcome' is the route for the welcome screen
    }

}
