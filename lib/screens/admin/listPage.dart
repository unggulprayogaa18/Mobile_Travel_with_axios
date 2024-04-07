import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abdullahsidik_uts/controllers/list_controller.dart';

class ListPage extends StatelessWidget {
  final ListController listController = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListPage'),
      ),
      body: Column(
        children: [
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Color.fromARGB(255, 243, 209, 55),
                    unselectedLabelColor: Color.fromARGB(255, 85, 85, 85),
                    labelColor: Color.fromARGB(255, 252, 201, 63),
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    tabs: [
                      Tab(text: "ALL DATA HOTEL"),
                      Tab(text: "Rating tinggi"),
                      Tab(text: "Rating rendah"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Obx(() => ListView.builder(
                          itemCount: listController.allHotels.length,
                          itemBuilder: (context, index) {
                            var hotel = listController.allHotels[index];
                            return createListTile(
                              hotel['image'] ?? '',
                              hotel['namahotel'] ?? '',
                              hotel['rating'] ?? 0,
                              hotel['id'], // Pass the hotelId to deleteHotel
                            );
                          },
                        )),
                        Obx(() => ListView.builder(
                          itemCount: listController.trendingData.length,
                          itemBuilder: (context, index) {
                            var hotel = listController.trendingData[index];
                            return createListTile(
                              hotel['image'] ?? '',
                              hotel['namahotel'] ?? '',
                              hotel['rating'] ?? 0,
                              hotel['id'], // Pass the hotelId to deleteHotel
                            );
                          },
                        )),
                        Obx(() => ListView.builder(
                          itemCount: listController.promotionData.length,
                          itemBuilder: (context, index) {
                            var hotel = listController.promotionData[index];
                            return createListTile(
                              hotel['image'] ?? '',
                              hotel['namahotel'] ?? '',
                              hotel['rating'] ?? 0,
                              hotel['id'], // Pass the hotelId to deleteHotel
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createListTile(String imagePath, String title, int rating, int hotelId) {
    return ListTile(
      leading: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imagePath),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${hotelId.toInt()}'),
          Text(title),
          Text('Rating: ${rating.toInt()}'),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await listController.deleteHotel(hotelId);
        },
      ),
      onTap: () {
        // Handle item tap
      },
    );
  }
}
