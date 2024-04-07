import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:abdullahsidik_uts/controllers/list_controller.dart';
import 'package:get/get.dart';

class SearchHotel extends StatelessWidget {
  final ListController listController = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 10, bottom: 15),
              child: Material(
                elevation: 20.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: TextField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var hotelData = listController.allHotels[index];
                String imgUrl = hotelData['image'];
                String nama = hotelData['namahotel'];
                int harga = hotelData['hargahotel'];
                String location = hotelData['location'];

                String text ='\$$harga /night'; // String yang mengandung variabel 'harga'

// Kemudian, Anda bisa menampilkan 'text' menggunakan widget Text di dalam widget apa pun seperti:

                int rating = hotelData['rating'];

                List<Widget> starIcons = List.generate(
                  rating,
                  (index) => Icon(
                    Icons.star,
                    color: Color.fromRGBO(248, 201, 48, 1),
                    size: 18,
                  ),
                );

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 120.0, left: 8, right: 8, bottom: 8),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(121, 14, 21, 27), // warna biru
                              Color.fromARGB(144, 22, 28, 36), // warna putih
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.0,
                              0.5
                            ], // stops untuk mengatur transparansi pada gambar
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Row(
                        children: starIcons,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 53),
                        child: Text(
                          nama,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 35),
                        child: Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 247, 209, 86),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 16),
                        child: Text(
                          text,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: listController.allHotels.length,
            ),
          ),
        ],
      ),
    );
  }
}
