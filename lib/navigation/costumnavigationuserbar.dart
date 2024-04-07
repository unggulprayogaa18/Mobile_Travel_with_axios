import 'package:abdullahsidik_uts/controllers/button_nav_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavigationUserBar extends StatelessWidget {
  const CustomNavigationUserBar({super.key});

  @override
  Widget build(BuildContext context) {
    bottomNavigationBarUserController controller = Get.put(bottomNavigationBarUserController());
    return Scaffold(
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child:  GNav(
          backgroundColor: Color.fromARGB(255, 253, 252, 252),
            color: Color.fromARGB(255, 41, 89, 177),
            activeColor: Color.fromARGB(255, 26, 114, 214),
            tabBackgroundColor: Color.fromARGB(255, 253, 253, 253),
            gap: 5,
            padding: EdgeInsets.all(16),
            onTabChange: (value) {
              print(value);
              controller.index.value = value; 
            },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'search',
            ),
            // GButton(
            //   icon: Icons.add,
            //   text: 'Add',
            // ),
            // GButton(
            //   icon: Icons.list,
            //   text: 'List',
            // ),
            GButton(
              icon: Icons.account_box,
              text: 'about',
            ),
            
          ],
        ),
      ),
      body: Obx(() =>  controller.pages[controller.index.value],
      )
    );
  }
}
