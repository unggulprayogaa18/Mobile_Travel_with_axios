import 'package:abdullahsidik_uts/screens/admin/aboutPage.dart';
import 'package:abdullahsidik_uts/screens/admin/addPage.dart';
import 'package:abdullahsidik_uts/screens/admin/homePage.dart';
import 'package:abdullahsidik_uts/screens/admin/listPage.dart';
import 'package:abdullahsidik_uts/screens/other/searchhotel.dart';

import 'package:get/get.dart';

class bottomNavigationBarController extends GetxController{
RxInt index = 0.obs;

var pages = [
   HomePage(),
   SearchHotel(),
   AddPage(),
   ListPage(),
   AboutPage()
];

}