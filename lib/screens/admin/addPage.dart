import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abdullahsidik_uts/controllers/add_controller.dart';

class AddPage extends StatelessWidget {
  final AddController addController = Get.put(AddController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Hotel')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Displaying the image avatar
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 24),
                height: 175.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 247, 209, 86), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Material(
                    elevation: 10.0,
                    shadowColor: Color(0x55434343),
                    child: InkWell(
                      onTap: () async {
                        await addController.pickImage();
                        Get.forceAppUpdate(); // Force UI update after picking image
                      },
                      child: Center(
                        child: Obx(() => addController.image.value != null
                            ? Image.file(addController.image.value!,
                                fit: BoxFit.cover, width: double.infinity)
                            : Icon(Icons.camera_alt,
                                size: 70.0, color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.0),

              // Nama Hotel TextField
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: addController.namaHotelController,
                    decoration: InputDecoration(
                      labelText: 'Nama Hotel',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Harga Hotel TextField
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: addController.hargaHotelController,
                    decoration: InputDecoration(
                      labelText: 'Harga',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Rating TextField
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: addController.ratingController,
                    decoration: InputDecoration(
                      labelText: 'Rating 1/6',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Tentang Hotel TextField
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: addController.tentangHotelController,
                    decoration: InputDecoration(
                      labelText: 'Tentang Hotel',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.0),

              // Tentang Hotel TextField
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: addController.location,
                    decoration: InputDecoration(
                      labelText: 'lokasi hotel',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              // Save Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await addController.saveData();
                      debugPrint("Data saved successfully!");
                      // Navigator.of(context).pop();
                    } catch (e) {
                      print("Error saving data: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 24, 108, 218),
                    onPrimary: Colors.white,
                  ),
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
