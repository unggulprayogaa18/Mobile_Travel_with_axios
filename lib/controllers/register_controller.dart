import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final kompasswordController = TextEditingController();

  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  void register() async {
    String username = usernameController.text;
    String password = passwordController.text;
    String komfirmasipassword = kompasswordController.text;
    String status = 'user';
    // Perform registration process
    if (password == komfirmasipassword) {
      Map<String, dynamic> formData = {
        'username': username,
        'password': password,
        'status': status,
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://sidikwebsite.000webhostapp.com/mobile_register.php'),
          body: formData,
        );

        if (response.statusCode == 200) {
          // Print karakter pertama dan hasil pembersihan respons
          String cleanedResponse = response.body.trim();
          final startIndex = cleanedResponse.indexOf('{');
          final endIndex = cleanedResponse.lastIndexOf('}') + 1;
          if (startIndex != -1 && endIndex != -1) {
            cleanedResponse = cleanedResponse.substring(startIndex, endIndex);
          }

          print('Cleaned response: $cleanedResponse');

          try {
            Map<String, dynamic> jsonResponse = json.decode(cleanedResponse);

            if (jsonResponse['status'] == 'success') {
              // Registration successful, you can navigate to another screen or show a success message
              Get.snackbar(
                'Success',
                'Registration successful',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );

              // Clear text controllers after successful registration
              usernameController.clear();
              passwordController.clear();
              kompasswordController.clear();
            } else {
              // Registration failed, show a snackbar with the error message
              Get.snackbar(
                'Error',
                jsonResponse['message'],
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          } catch (error) {
            print('Error parsing JSON: $error');
            // Show snackbar with the error message
            Get.snackbar(
              'Error',
              'An error occurred during registration. Please try again later.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          // Handle other status codes (e.g., show an error message)
          print('Error: ${response.statusCode}');
        }
      } catch (error) {
        // Show snackbar with the error message
        Get.snackbar(
          'Error',
          'An error occurred during registration. Please try again later. Error: $error',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      // Passwords do not match, show a snackbar notification
      Get.snackbar(
        'Error',
        'Password and confirmation do not match',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
