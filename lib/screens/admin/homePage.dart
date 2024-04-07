import 'package:flutter/material.dart';
import 'travelcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> urls = [
    "assets/list/pexels-alesia-kozik-5992583.jpg",
    "assets/list/pexels-asad-photo-maldives-1129343.jpg",
    "assets/list/pexels-donald-tong-189296.jpg",
    "assets/list/pexels-johny-goh-14147849.jpg",
    "assets/list/pexels-pineapple-supply-co-137090.jpg",
    "assets/list/pexels-ricky-esquivel-1802255.jpg",
    "assets/list/pexels-thorsten-technoman-338504.jpg",
    "assets/list/pexels-tom-fisk-3285725.jpg",
    "assets/list/pexels-zachary-debottis-1838640.jpg",
    "assets/list/pexels-matthis-volquardsen-2103825.jpg",
    "assets/list/pexels-quark-studio-2506988.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FF),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF6F7FF),
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Admin",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Pick your destination",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: TextField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Search for Hotel, Flight...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Color.fromARGB(255, 33, 195, 236),
                      unselectedLabelColor: Color(0xFF555555),
                      labelColor: Color.fromARGB(255, 33, 155, 236),
                      labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      tabs: [
                        Tab(
                          text: "Trending",
                        ),
                        Tab(
                          text: "Promotion",
                        ),
                        Tab(
                          text: "Favorites",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 300.0,
                      child: TabBarView(
                        children: [
                          Container(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(urls[0], "Luxary Hotel", "Caroline", 5),
                                travelCard(urls[2], "Plaza Hotel", "Italy", 5),
                                travelCard(urls[4], "Safari Hotel", "Africa", 5),
                              ],
                            ),
                          ),
                          Container(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(urls[3], "Visit Rome", "Italy", 4),
                                travelCard(urls[4], "Visit Sidi bou Said", "Tunsia", 4),
                              ],
                            ),
                          ),
                          Container(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 20.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: urls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Add your onTap functionality here
                          },
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                urls[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
