import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../bindings/detail_binding.dart';
import '../bindings/search_binding.dart';
import '../ui/detail_page.dart';
import '../ui/home_page.dart';
import '../ui/search_page.dart';


part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),
  ];
}

