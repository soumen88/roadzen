import 'package:auto_route/annotations.dart';
import 'package:roadzen/homescreen/HomeScreenPage.dart';
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes:[
    AutoRoute(
      path: "/home",
      initial: true,
      page: HomeScreenPage,
    ),
  ]
)

class $AppRouter{

}