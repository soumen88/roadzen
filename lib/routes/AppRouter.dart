import 'package:auto_route/annotations.dart';
import 'package:roadzen/checkout/checkoutscreenpage.dart';
import 'package:roadzen/homescreen/homescreenpage.dart';
import 'package:roadzen/register/familydetailsscreenpage.dart';
import 'package:roadzen/register/familylistingscreenpage.dart';
import 'package:roadzen/register/familyregistrationscreenpage.dart';
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
    AutoRoute(
      path: "/familydetails",
      page: FamilyDetailsScreenPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/familyregistration",
      page: FamilyRegistrationScreenPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/checkout",
      page: CheckOutScreenPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/familylisting",
      page: FamilyListingScreenPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ]
)

class $AppRouter{

}