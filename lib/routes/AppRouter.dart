import 'package:auto_route/annotations.dart';
import 'package:roadzen/homescreen/homescreenpage.dart';
import 'package:roadzen/splashscreen/splashscreenpage.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes:<AutoRoute>[
    AutoRoute(
      path: "/splash",
      initial: true,
      page: SplashScreenPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/home",
      page: HomeScreenPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ]
)

class $AppRouter{

}