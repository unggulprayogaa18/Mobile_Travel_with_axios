import 'package:abdullahsidik_uts/screens/user/homePageUser.dart';
import 'package:abdullahsidik_uts/screens/admin/aboutPage.dart';
import 'package:abdullahsidik_uts/screens/other/searchhotel.dart';

import 'package:get/get.dart';

class bottomNavigationBarUserController extends GetxController{
RxInt index = 0.obs;

var pages = [
   HomePage(),
   SearchHotel(),
   AboutPage()
];

}