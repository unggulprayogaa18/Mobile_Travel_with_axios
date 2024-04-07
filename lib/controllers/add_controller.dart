import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddController extends GetxController {
  var namaHotelController = TextEditingController();
  var hargaHotelController = TextEditingController();
  var ratingController = TextEditingController();
  var tentangHotelController = TextEditingController();
  var location = TextEditingController();
  var image = Rxn<File>();

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image.value = pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<void> saveData() async {
    if (image.value == null) {
      Get.snackbar('Warning', 'Pilih foto terlebih dahulu!',
          backgroundColor: Colors.red,  colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (double.parse(ratingController.text) > 6.0) {
      Get.snackbar('Warning', 'Rating tidak boleh lebih dari 6!',
          backgroundColor: Colors.red,  colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      var uri =
          Uri.parse('https://sidikwebsite.000webhostapp.com/mobile_tambah.php');
      var request = http.MultipartRequest('POST', uri)
        ..fields['namahotel'] = namaHotelController.text
        ..fields['hargahotel'] = hargaHotelController.text
        ..fields['rating'] = ratingController.text
        ..fields['tentanghotel'] = tentangHotelController.text
        ..fields['location'] = location.text
        ..files
            .add(await http.MultipartFile.fromPath('image', image.value!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Data saved successfully!',
            backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
          'Error',
          'Failed to save data!',
          backgroundColor: Colors.red,
          colorText: Colors.white, // Set text color to white
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred!',
          backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
