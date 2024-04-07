import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListController extends GetxController {
  late RxList<Map<String, dynamic>> allHotels = <Map<String, dynamic>>[].obs;
  late RxList<Map<String, dynamic>> promotionData =
      <Map<String, dynamic>>[].obs;
  late RxList<Map<String, dynamic>> trendingData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://sidikwebsite.000webhostapp.com/mobile_ambil_data.php'),
      );

      if (response.statusCode == 200) {
        String cleanedResponse = response.body.trim();
        final startIndex = cleanedResponse.indexOf('{');
        final endIndex = cleanedResponse.lastIndexOf('}') + 1;
        if (startIndex != -1 && endIndex != -1) {
          cleanedResponse = cleanedResponse.substring(startIndex, endIndex);
        }

        try {
          Map<String, dynamic> jsonResponse = json.decode(cleanedResponse);

          // Check if the response contains the 'data' field
          if (jsonResponse.containsKey('data')) {
            // Extract the 'data' field which should contain the list of hotels
            List<Map<String, dynamic>> jsonDataList =
                List<Map<String, dynamic>>.from(jsonResponse['data']);

            // Split data into promotion and trending based on rating
            promotionData.clear();
            trendingData.clear();

            for (var hotel in jsonDataList) {
              if (hotel.containsKey('image') &&
                  hotel.containsKey('id') &&
                  hotel.containsKey('namahotel') &&
                  hotel.containsKey('hargahotel') &&
                  hotel.containsKey('rating') &&
                  hotel.containsKey('location') &&
                  hotel.containsKey('tentanghotel')) {
                int rating = hotel['rating'] is int
                    ? hotel['rating']
                    : (hotel['rating']).toInt();
                if (rating < 5) {
                  promotionData.add(hotel);
                } else {
                  trendingData.add(hotel);
                }
              }
            }

            allHotels.assignAll(jsonDataList);
            update();

            // Now you have promotionData and trendingData lists
            // You can use them as needed in your application
            print('Promotion Data: $promotionData');
            print('Trending Data: $trendingData');
          } else {
            print('Error: Response does not contain the "data" field');
          }
        } catch (error) {
          print('Error parsing JSON: $error');
          Get.snackbar(
            'Error',
            'An error occurred during data fetching. Please try again later.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar(
        'Error',
        'An error occurred during data fetching. Please try again later. Error: $error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteHotel(int hotelId) async {
    print("$hotelId");
    try {
      // Melakukan permintaan HTTP POST ke skrip PHP delete dengan mengirimkan id hotel
      final response = await http.post(
        Uri.parse('https://sidikwebsite.000webhostapp.com/mobile_delete.php'),
        body: {
          'id': hotelId.toString(),
        },
      );

      // Memeriksa apakah permintaan HTTP berhasil (kode status 200)
      if (response.statusCode == 200) {
        // Mendekode respons JSON dari server
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Membersihkan respons untuk memastikan hanya data JSON yang diambil
        String cleanedResponse = response.body.trim();
        final startIndex = cleanedResponse.indexOf('{');
        final endIndex = cleanedResponse.lastIndexOf('}') + 1;

        // Memastikan respons hanya berisi data JSON
        if (startIndex != -1 && endIndex != -1) {
          cleanedResponse = cleanedResponse.substring(startIndex, endIndex);
        }

        // Memeriksa apakah respons JSON mengandung kunci 'status'
        if (jsonResponse.containsKey('status')) {
          // Jika status adalah 'success', cetak pesan sukses dan perbarui data
          if (jsonResponse['status'] == 'success') {
            print('Hotel berhasil dihapus');
            await fetchData();
          } else {
            // Jika status bukan 'success', cetak pesan kesalahan
            print('Error menghapus hotel: ${jsonResponse['message']}');
            print('Server Response: $cleanedResponse');
          }
        } else {
          // Jika respons tidak memiliki kunci 'status', cetak pesan format respons tidak valid
          print('Format respons tidak valid');
        }
      } else {
        // Jika kode status tidak 200, cetak pesan kesalahan
        print('Error menghapus hotel: ${response.statusCode}');
      }
    } catch (error) {
      // Tangkap dan cetak pesan kesalahan jika terjadi kesalahan selama proses
      print('Error: $error');
    }
  }
}
