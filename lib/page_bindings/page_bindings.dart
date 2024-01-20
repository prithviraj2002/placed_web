import 'package:get/get.dart';
import 'package:placed_web/constants/pages/pages.dart';
import 'package:placed_web/modules/home_module/view/home_page.dart';

List<GetPage> pages = [
  GetPage(
    name: PageNames.homePage,
    page: () => const HomePage(),
  ),
];